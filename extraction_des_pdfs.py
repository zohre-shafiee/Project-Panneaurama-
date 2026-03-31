"""
LGIDF — Extraction PHONOLOGIE (toutes langues) via OCR + correction IPA
========================================================================

Ce module scrape le site LGIDF (CNRS) pour extraire les sections
"Éléments de phonologie" de chaque fiche langue au format PDF A4,
via OCR (Tesseract), puis corrige automatiquement les confusions
de caractères IPA fréquentes (uniquement dans les segments [ ... ]).

l'OCR (Tesseract, DPI=450) produit trois catégories de problèmes récurrents : 
des artefacts de mise en page — bordures de tableaux lues comme |, 
URLs et noms propres déformés par les ligatures typographiques des PDFs — ; 
des erreurs de segmentation des crochets phonétiques, où un crochet fermant manqué 
absorbe plusieurs phrases dans un seul segment IPA, rendant les substitutions de fix_ipa_in_brackets contre-productives ; 
et des limites intrinsèques de la table de corrections, 
à la fois trop agressive ([a] → [ɑ̃] hors contexte nasal) et trop incomplète ([@], [5], [4] non couverts). 
Ces problèmes reflètent une contrainte fondamentale de l'approche : 
Tesseract n'a pas été entraîné sur les polices spécialisées de l'IPA, 
et les post-corrections par expressions régulières ne peuvent pas compenser une segmentation initiale défaillante

Dépendances
-----------
- requests, beautifulsoup4
- PyMuPDF (fitz) ou pymupdf
- Pillow, pytesseract
- Tesseract installé et accessible (Anaconda recommandé)
- Données tessdata avec au minimum fra et eng

Sortie
------
lgidf_phonologie_ALL_OCR_IPA.csv
    Colonnes : language_name, language_page, a4_label, a4_pdf,
               method, dpi, phonologie

Notes de performance
--------------------
DPI=450 donne de meilleurs résultats IPA mais est lent (~30–60 s/page).
Pour un test rapide, utiliser DPI=350 et max_lang_pages=10 :

    main_all_languages_ocr_ipa(max_lang_pages=10, dpi=350)

"""

import os
import re
import csv
import time
import io
from urllib.parse import urljoin

import requests
import urllib3
from bs4 import BeautifulSoup

try:
    import fitz  # PyMuPDF
except ImportError:
    import pymupdf as fitz

from PIL import Image
import pytesseract
import shutil


# 0) Tesseract config (Anaconda)

tpath = shutil.which("tesseract")
print("tesseract path:", tpath)
if not tpath:
    raise RuntimeError("tesseract introuvable. Vérifie ton kernel/Anaconda.")

pytesseract.pytesseract.tesseract_cmd = tpath

os.environ["TESSDATA_PREFIX"] = "/opt/anaconda3/share/tessdata"
print("tessdata prefix:", os.environ["TESSDATA_PREFIX"])
print("langs:", pytesseract.get_languages())


# 1) Session + site


urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

SESSION = requests.Session()
SESSION.verify = False
SESSION.headers.update({"User-Agent": "Mozilla/5.0 (UGA-scraper/1.0)"})

BASE = "https://lgidf.cnrs.fr"
LANGUES_URL = BASE + "/langues"

# réglages OCR 
DPI = 450
OCR_LANG = "fra+eng"
OCR_CONFIG = "--oem 1 --psm 6 -c preserve_interword_spaces=1"

# Titres de section qui marquent le début du bloc phonologie
START_MARKS = [
    "ÉLÉMENTS DE PHONOLOGIE",
    "ELEMENTS DE PHONOLOGIE",
    "PHONOLOGIE",
]

# Titres de section qui marquent la fin du bloc phonologie
END_MARKS = [
    "ÉLÉMENTS DE GRAMMAIRE",
    "ELEMENTS DE GRAMMAIRE",
    "GRAMMAIRE",
    "GRAPHIE",
    "ORTHOGRAPHE",
    "NOM ET SYNTAGME NOMINAL",
    "SYNTAXE",
    "MORPHOLOGIE",
    "LEXIQUE",
    "BIBLIOGRAPHIE",
]


# 2) Scraping


def get_soup(url: str) -> BeautifulSoup:
    """
    Télécharge une page HTML et retourne un objet BeautifulSoup.

    Parameters
    ----------
    url : str
        URL complète de la page à récupérer.

    Returns
    -------
    BeautifulSoup
        Arbre HTML parsé avec le parser "html.parser".

    Raises
    ------
    requests.HTTPError
        Si le serveur retourne un code d'erreur HTTP (4xx, 5xx).
    requests.Timeout
        Si la connexion dépasse 30 secondes.
    """
    r = SESSION.get(url, timeout=30)
    r.raise_for_status()
    return BeautifulSoup(r.text, "html.parser")


def extract_language_pages() -> list[str]:
    """
    Collecte les URLs de toutes les fiches langue du site LGIDF.

    Parcourt la page d'index /langues et extrait tous les liens
    internes de la forme /node/<id>, qui correspondent aux fiches
    individuelles de chaque langue.

    Returns
    -------
    list[str]
        Liste d'URLs absolues, dédupliquées, dans leur ordre d'apparition
        sur la page d'index.
    """
    soup = get_soup(LANGUES_URL)
    main = soup.find("main") or soup

    links = []
    for a in main.select("a[href]"):
        href = a["href"].strip()
        if href.startswith("/node/"):
            links.append(urljoin(BASE, href))

    seen = set()
    out = []
    for u in links:
        if u not in seen:
            seen.add(u)
            out.append(u)
    return out


def get_language_name(language_page_url: str) -> str:
    """
    Extrait le nom de la langue depuis le titre <h1> de sa fiche.

    Parameters
    ----------
    language_page_url : str
        URL de la fiche langue (ex. https://lgidf.cnrs.fr/node/42).

    Returns
    -------
    str
        Nom de la langue tel qu'il apparaît dans le <h1>.
        Si aucun <h1> n'est trouvé, retourne le dernier segment
        de l'URL en guise de fallback.
    """
    soup = get_soup(language_page_url)
    h1 = soup.find("h1")
    if h1:
        t = h1.get_text(" ", strip=True)
        if t:
            return t
    return language_page_url.rsplit("/", 1)[-1]


def find_a4_pdfs(language_page_url: str) -> list[tuple[str, str]]:
    """
    Trouve tous les liens PDF au format A4 sur une fiche langue.

    Un lien est considéré "A4" si son texte est exactement "A4"
    ou si l'URL du href se termine par A4.pdf (insensible à la casse).

    Parameters
    ----------
    language_page_url : str
        URL de la fiche langue à analyser.

    Returns
    -------
    list[tuple[str, str]]
        Liste de paires (label, pdf_url) où :
        - label : texte du <li> parent du lien (contexte humain) ;
        - pdf_url : URL absolue du fichier PDF.
        Les doublons (même label + même URL) sont supprimés.
    """
    soup = get_soup(language_page_url)

    out = []
    seen = set()

    for a in soup.select("a[href]"):
        href = (a.get("href") or "").strip()
        text = a.get_text(" ", strip=True)

        is_a4_link = (text == "A4") or bool(re.search(r"A4\.pdf$", href, re.IGNORECASE))
        if not is_a4_link:
            continue

        pdf_url = urljoin(language_page_url, href)

        li = a.find_parent("li")
        label = li.get_text(" ", strip=True) if li else text

        key = (label, pdf_url)
        if key not in seen:
            seen.add(key)
            out.append((label, pdf_url))

    return out


# 3) OCR + nettoyage

def clean_ocr(text: str) -> str:
    """
    Normalise le texte brut produit par Tesseract.

    Corrections appliquées (dans l'ordre) :
    - Remplacement des espaces insécables (\\xa0) et des
      zero-width spaces (\\u200b) par des espaces normaux.
    - Réduction des séquences de plusieurs espaces/tabulations en
      un seul espace.
    - Réduction des sauts de ligne multiples (≥ 3) en deux sauts.
    - Suppression des espaces de début et de fin.

    Parameters
    ----------
    text : str
        Texte OCR brut à nettoyer.

    Returns
    -------
    str
        Texte normalisé.
    """
    text = text.replace("\xa0", " ").replace("\u200b", " ")
    text = re.sub(r"[ \t]{2,}", " ", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def ocr_page(page: fitz.Page, dpi: int = DPI) -> str:
    """
    Effectue l'OCR d'une page PDF via Tesseract.

    La page est d'abord rastérisée en image PNG à la résolution
    dpi spécifiée, puis passée à Tesseract avec les paramètres
    globaux OCR_LANG et OCR_CONFIG.

    Parameters
    ----------
    page : fitz.Page
        Page PDF ouverte avec PyMuPDF.
    dpi : int, optional
        Résolution de rastérisation en points par pouce.
        Par défaut : valeur globale ``DPI`` (450).
        Une valeur plus élevée améliore la reconnaissance des
        caractères IPA fins, mais augmente le temps de traitement.

    Returns
    -------
    str
        Texte brut reconnu par Tesseract pour cette page.
    """
    pix = page.get_pixmap(dpi=dpi)
    img = Image.open(io.BytesIO(pix.tobytes("png")))
    return pytesseract.image_to_string(img, lang=OCR_LANG, config=OCR_CONFIG)


# 4) Correction IPA (UNIQUEMENT dans [ ... ])


def fix_ipa_in_brackets(text: str) -> str:
    """
    Corrige les confusions OCR fréquentes dans les transcriptions IPA.

    Seuls les segments délimités par des crochets [ ... ] sont
    modifiés, afin de ne pas altérer le texte français environnant.

    Parameters
    ----------
    text : str
        Texte OCR (potentiellement multilingue) contenant des
        transcriptions phonétiques entre crochets.

    Returns
    -------
    str
        Texte avec les confusions IPA corrigées dans les crochets.
    """
    subs = [
        (r"\[9\]", "[ø]"),
        (r"\[ce\]", "[œ]"),
        (r"\[€\]", "[ɛ̃]"),
        (r"\[6\]", "[ɔ̃]"),
        (r"\[O\]", "[ɔ]"),
        (r"\[a\]", "[ɑ̃]"),
        (r"\[e\]", "[ɛ]"),
    ]

    def fix_segment(seg: str) -> str:
        out = seg
        for pat, rep in subs:
            out = re.sub(pat, rep, out)
        return out

    return re.sub(r"\[[^\]]+\]", lambda m: fix_segment(m.group(0)), text)


def fix_contextual_nasals(text: str) -> str:
    """
    Corrige [a] → [ɑ̃] uniquement sur les lignes mentionnant
    les voyelles nasales.

    Cette approche plus prudente réduit les faux positifs de la
    substitution générale [a] → [ɑ̃] présente dans
    fix_ipa_in_brackets : la correction n'est appliquée que
    lorsque la ligne contient explicitement l'expression
    « voyelles nasales » (insensible à la casse).

    Parameters
    ----------
    text : str
        Texte OCR après un premier passage de correction IPA.

    Returns
    -------
    str
        Texte avec correction contextuelle des nasales, ligne par ligne.
    """
    lines = text.splitlines()
    out = []
    for line in lines:
        if re.search(r"voyelles\s+nasales", line, re.IGNORECASE):
            line = re.sub(r"\[a\]", "[ɑ̃]", line)
        out.append(line)
    return "\n".join(out)


# 5) Extraction phonologie par OCR


def extract_phonologie_ocr(pdf_bytes: bytes, dpi: int = DPI) -> str:
    """
    Extrait la section phonologie d'un PDF via OCR page par page.

    Algorithme
    ----------
    1. Ouvre le PDF en mémoire avec PyMuPDF.
    2. OCR chaque page avec Tesseract.
    3. Cherche une ligne contenant un marqueur de début
       (``START_MARKS``) pour activer la collecte de texte.
    4. Arrête la collecte dès qu'un marqueur de fin
       (``END_MARKS``) est rencontré.
    5. Nettoie et corrige le texte collecté.

    Parameters
    ----------
    pdf_bytes : bytes
        Contenu brut du fichier PDF (tel que retourné par
        ``requests.Response.content``).
    dpi : int, optional
        Résolution OCR en points par pouce. Par défaut : ``DPI`` (450).

    Returns
    -------
    str
        Texte de la section phonologie, nettoyé et corrigé en IPA.
        Retourne une chaîne vide si aucun marqueur de début n'est trouvé.
    """
    doc = fitz.open(stream=pdf_bytes, filetype="pdf")

    collecting = False
    out_lines = []

    for pno in range(len(doc)):
        page_text = ocr_page(doc[pno], dpi=dpi)
        lines = page_text.splitlines()

        for line in lines:
            s = line.strip()
            if not s:
                if collecting and out_lines and out_lines[-1] != "":
                    out_lines.append("")
                continue

            if not collecting:
                if any(mark in s for mark in START_MARKS):
                    collecting = True
                    continue
            else:
                if any(mark in s for mark in END_MARKS):
                    collecting = False
                    break
                out_lines.append(s)

        if not collecting and out_lines:
            break

    text = clean_ocr("\n".join(out_lines))
    text = fix_ipa_in_brackets(text)
    text = fix_contextual_nasals(text)

    return text


# 6) MAIN

def main_all_languages_ocr_ipa(
    max_lang_pages: int | None = None,
    sleep_s: float = 0.3,
    dpi: int = DPI,
    output_csv: str = "lgidf_phonologie_ALL_OCR_IPA.csv",
) -> None:
    """
    Pipeline principal : scrape toutes les langues LGIDF et exporte
    les sections phonologie dans un CSV.

    Étapes
    ------
    1. Récupère la liste des fiches langue depuis /langues.
    2. Pour chaque fiche, trouve les PDFs A4 disponibles.
    3. Télécharge chaque PDF et en extrait la phonologie via OCR.
    4. Écrit les résultats dans un fichier CSV UTF-8.

    En cas d'erreur sur une langue (réseau, PDF corrompu, etc.),
    un message est affiché et le traitement continue avec la suivante.

    Parameters
    ----------
    max_lang_pages : int or None, optional
        Nombre maximum de fiches langue à traiter. None (défaut)
        signifie toutes les fiches. Utile pour tester :
        max_lang_pages=10.
    sleep_s : float, optional
        Délai d'attente en secondes entre deux requêtes HTTP,
        pour ne pas surcharger le serveur. Par défaut : 0.3 s.
    dpi : int, optional
        Résolution OCR transmise à extract_phonologie_ocr.
        Par défaut : DPI (450).
    output_csv : str, optional
        Chemin du fichier CSV de sortie.
        Par défaut : "lgidf_phonologie_ALL_OCR_IPA.csv".

    Returns
    -------
    None
        La fonction ne retourne rien ; les résultats sont écrits
        sur le disque.

    CSV columns
    -----------
    - language_name  : nom de la langue (depuis <h1>).
    - language_page  : URL de la fiche langue.
    - a4_label       : libellé du lien A4 (contexte du <li>).
    - a4_pdf         : URL du PDF A4.
    - method         : toujours "ocr_ipa" ici.
    - dpi            : résolution utilisée pour l'OCR.
    - phonologie     : texte extrait et corrigé.

    Examples
    --------
    Test rapide sur 10 langues :

    >>> main_all_languages_ocr_ipa(max_lang_pages=10)

    Extraction complète avec résolution réduite :

    >>> main_all_languages_ocr_ipa(dpi=350, output_csv="out.csv")
    """
    lang_pages = extract_language_pages()
    print("Pages langues trouvées:", len(lang_pages))

    if max_lang_pages is not None:
        lang_pages = lang_pages[:max_lang_pages]

    rows = []
    for i, lang_url in enumerate(lang_pages, start=1):
        try:
            lang_name = get_language_name(lang_url)
            a4_list = find_a4_pdfs(lang_url)

            if not a4_list:
                print(f"[{i}] Pas de A4: {lang_name}")
                continue

            for (a4_label, a4_pdf) in a4_list:
                pdf_resp = SESSION.get(a4_pdf, timeout=90)
                pdf_resp.raise_for_status()

                phonologie = extract_phonologie_ocr(pdf_resp.content, dpi=dpi)

                rows.append({
                    "language_name": lang_name,
                    "language_page": lang_url,
                    "a4_label": a4_label,
                    "a4_pdf": a4_pdf,
                    "method": "ocr_ipa",
                    "dpi": dpi,
                    "phonologie": phonologie,
                })

                print(f"[{i}] OK {lang_name} ({a4_label}) chars={len(phonologie)}")
                time.sleep(sleep_s)

        except Exception as e:
            print(f"[{i}] ERREUR {lang_url}: {e}")

    with open(output_csv, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=["language_name", "language_page", "a4_label", "a4_pdf", "method", "dpi", "phonologie"]
        )
        w.writeheader()
        w.writerows(rows)

    print("Terminé ->", output_csv, "| lignes:", len(rows))


# RUN

main_all_languages_ocr_ipa()
