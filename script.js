document.addEventListener("DOMContentLoaded", function () {
    console.log("script chargé");

    const langueSelect = document.getElementById("langue-select");
    const boutonValider = document.getElementById("btn-valider");
    const boutonReset = document.getElementById("btn-reset");
    const zoneDescription = document.getElementById("description-phonologique");

    console.log("select :", langueSelect);
    console.log("btn valider :", boutonValider);
    console.log("btn reset :", boutonReset);
    console.log("zone description :", zoneDescription);

    if (!langueSelect || !boutonValider) {
        console.error("Éléments HTML introuvables");
        return;
    }

    chargerLangues();

    boutonValider.addEventListener("click", function () {
        const idLangue = langueSelect.value;

        console.log("CLICK détecté");
        console.log("id langue sélectionnée :", idLangue);

        if (!idLangue) {
            alert("Veuillez sélectionner une langue.");
            return;
        }

        chargerPhonemes(idLangue);
        chargerDescription(idLangue);
    });

    if (boutonReset) {
        boutonReset.addEventListener("click", function () {
            console.log("RESET détecté");
            langueSelect.selectedIndex = 0;
            resetAffichage();

            if (zoneDescription) {
                zoneDescription.textContent = "Aucune description chargée.";
            }
        });
    }

    function chargerLangues() {
        fetch("get_langues.php")
            .then(response => {
                console.log("status get_langues:", response.status);
                return response.json();
            })
            .then(data => {
                console.log("langues reçues :", data);

                if (!Array.isArray(data)) {
                    console.error("Réponse langues invalide :", data);
                    return;
                }

                langueSelect.innerHTML = '<option value="">-- Sélectionner une langue --</option>';

                data.forEach(langue => {
                    const option = document.createElement("option");
                    option.value = langue.id_langue;
                    option.textContent = langue.nom_langue;
                    langueSelect.appendChild(option);
                });

                console.log("menu rempli");
            })
            .catch(error => {
                console.error("Erreur get_langues :", error);
            });
    }

    function chargerPhonemes(idLangue) {
        fetch("get_phonemes.php?id_langue=" + encodeURIComponent(idLangue))
            .then(response => {
                console.log("status get_phonemes:", response.status);
                return response.json();
            })
            .then(data => {
                console.log("phonèmes reçus :", data);

                if (!Array.isArray(data)) {
                    console.error("Réponse phonèmes invalide :", data);
                    return;
                }

                resetAffichage();

                const phonemes = data
                    .map(item => (item.phoneme_label || "").trim().normalize("NFC"))
                    .filter(item => item !== "");

                console.log("liste phonèmes base :", phonemes);

                const spans = document.querySelectorAll("span");
                console.log("nombre de spans trouvés :", spans.length);

                spans.forEach(span => {
                    const symbole = span.textContent.trim().normalize("NFC");

                    if (phonemes.includes(symbole)) {
                        span.classList.add("phoneme-active");
                        console.log("match :", symbole);
                    }
                });

                phonemes.forEach(p => {
                    const existeDansHtml = Array.from(spans).some(span =>
                        span.textContent.trim().normalize("NFC") === p
                    );

                    if (!existeDansHtml) {
                        console.log("absent du HTML :", p);
                    }
                });
            })
            .catch(error => {
                console.error("Erreur get_phonemes :", error);
            });
    }

    function chargerDescription(idLangue) {
    fetch("get_description.php?id_langue=" + encodeURIComponent(idLangue))
        .then(response => {
            console.log("status get_description:", response.status);
            return response.json();
        })
        .then(data => {
            console.log("description reçue :", data);

            if (!zoneDescription) {
                console.error("Zone description introuvable");
                return;
            }

            if (data.success === false) {
                zoneDescription.textContent = data.message || "Aucune description disponible pour cette langue.";
                return;
            }

            if (
                typeof data.description_text !== "undefined" &&
                data.description_text !== null &&
                data.description_text.trim() !== ""
            ) {
                zoneDescription.textContent = data.description_text;
            } else {
                zoneDescription.textContent = "Aucune description disponible pour cette langue.";
            }
        })
        .catch(error => {
            console.error("Erreur get_description :", error);

            if (zoneDescription) {
                zoneDescription.textContent = "Erreur lors du chargement de la description.";
            }
        });
   }

    function resetAffichage() {
        document.querySelectorAll("span").forEach(span => {
            span.classList.remove("phoneme-active");
        });
    }
});
