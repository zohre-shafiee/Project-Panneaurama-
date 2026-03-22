<?php
header('Content-Type: application/json');

$id_fr = 40; 
$langue_id = isset($_GET['id_langue']) ? (int)$_GET['id_langue'] : $id_fr;

if ($langue_id <= 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => "ID de langue invalide."]); 
    exit;
}

try {
    $dbfile = 'gestion.db';
    $conn = new PDO("sqlite:" . $dbfile);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // On récupère tous les phonèmes (fr + autre langue)
    $sql_all = "SELECT 
                p.phoneme_label AS label, s.categorie AS cat, i.id_langue,
                c.lieu_dart, c.mode_dart, c.voise,
                v.ferm_ouv, v.post_ant, v.arrondi,
                o.level, o.contour,
                o.description AS tone_desc 
            FROM phonemes p
            JOIN language_inventory i ON p.id_phoneme = i.id_phoneme
            LEFT JOIN ipa_symbols s ON p.phoneme_label = s.symbol
            LEFT JOIN consonant_features c ON p.id_ipa = c.id_ipa
            LEFT JOIN vowel_features v ON p.id_ipa = v.id_ipa
            LEFT JOIN other_symbols_features o ON s.id_ipa = o.id_ipa 
            WHERE i.id_langue IN (:id_fr, :id_select)";

    $stmt = $conn->prepare($sql_all);
    $stmt->execute(['id_fr' => $id_fr, 'id_select' => $langue_id]);
    $phon_all = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // On récupère les phonèmes communs aux deux langues
    $sql_communs = "SELECT p.phoneme_label 
                    FROM phonemes p
                    JOIN language_inventory i1 ON p.id_phoneme = i1.id_phoneme
                    JOIN language_inventory i2 ON p.id_phoneme = i2.id_phoneme
                    WHERE i1.id_langue = :id_select AND i2.id_langue = :id_fr";

    $stmt_c = $conn->prepare($sql_communs);
    $stmt_c->execute(['id_select' => $langue_id, 'id_fr' => $id_fr]);
    $phon_communs = $stmt_c->fetchAll(PDO::FETCH_COLUMN); 

    // Initialisation des tableaux vides pour y stocker les phonèmes
    $init = [
        'fr' => ['consonne' => [], 'voyelle' => [], 'ton' => [] ],
        'autre' => ['consonne' => [], 'voyelle' => [], 'ton' => [] ],
    ];

    // Boucle pour remplir les tableaux à partir de la requête SQL
    foreach ($phon_all as $row) {
        $is_commun = in_array($row['label'], $phon_communs);
        
        $data = [
            'label' => $row['label'],
            'is_commun' => $is_commun,
            'features' => [
                // Pour les consonnes : correspond aux attributs data-lieu, data-mode et data-voix dans le HTML
                'lieu' => $row['lieu_dart'],
                'mode' => $row['mode_dart'],
                'voix' => $row['voise'],
                // Pour les voyelles : correspond aux attributs data-aper, data-point et data-round dans le HTML
                'aper' => $row['ferm_ouv'],
                'point' => $row['post_ant'],
                'round' => $row['arrondi'],
                // Pour les tons : correspond aux attributs data-level et data-contour dans le HTML
                'level' => $row['level'],
                'contour' => $row['contour']
            ]
        ];

        $target = ($row['id_langue'] == $id_fr) ? 'fr' : 'autre';
        $cat = $row['cat']; 
        
        if (isset($init[$target][$cat])) {
            $init[$target][$cat][] = $data;
        }
    }

    echo json_encode(['success' => true, 'data' => $init], JSON_UNESCAPED_UNICODE);

} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => "Erreur BDD:" . $e->getMessage()]);
}