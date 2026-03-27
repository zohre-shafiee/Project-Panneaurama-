<?php
header('Content-Type: application/json; charset=utf-8');

$id_fr = 40; // ID du français dans la bdd

//Récupère langue sélectionnée
if (!isset($_GET['id_langue']) || empty($_GET['id_langue'])) {
    echo json_encode(['success' => false, 'message' => 'Paramètre id_langue manquant'], JSON_UNESCAPED_UNICODE);
    exit;
}

$id_select = (int) $_GET['id_langue']; 

try {
    // Connection à la bdd
    $dbfile = 'gestion.db';
    $conn = new PDO("sqlite:" . $dbfile);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // MODIFICATION DE LA REQUÊTE :
    // On passe par phoneme_sequence pour récupérer les traits du premier symbole (position 1)
    // Cela permet à 'ph' de récupérer les traits de 'p' et donc d'aller dans la même cellule.
    // Requête SQL pour tous les phonèmes (fr + autre langue)
    $sql_all = "SELECT p.phoneme_label AS label, li.id_langue, -- Symboles API pour la langue sélectionnée (+fr)
                       c.mode_dart AS mode, c.lieu_dart AS point, c.voise AS voix, -- Coordonnées des consonnes
                       v.ferm_ouv, v.post_ant, v.arrondi -- Coordonnées des voyelles

                FROM phonemes p

                JOIN language_inventory li ON p.id_phoneme = li.id_phoneme -- Jointure entre son et langue

                -- Pour les séquences de phonèmes (eg affriquées ou diphtongues): ne prend en compte que le 1er car. pour le placer dans la cellulle correspondante
                LEFT JOIN phoneme_sequence ps ON p.id_phoneme = ps.id_phoneme AND ps.position = 1    
                                                                                                    
                LEFT JOIN ipa_symbols s ON ps.id_ipa = s.id_ipa
                LEFT JOIN consonant_features c ON s.id_ipa = c.id_ipa --Récupère les traits pour les consonnes
                LEFT JOIN vowel_features v ON s.id_ipa = v.id_ipa -- Récupère les traits pour les voyelles

                WHERE li.id_langue IN (:id_fr, :id_select)"; // Pour le fr et la langue sélectionnée

    $stmt = $conn->prepare($sql_all);
    $stmt->execute(['id_fr' => $id_fr, 'id_select' => $id_select]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // On sépare les phonèmes du fr. et les phonèmes de l'autre langue
    $phons_fr_labels = [];
    $phons_autre_labels = [];
    foreach ($rows as $row) {
        if ($row['id_langue'] == $id_fr) $phons_fr_labels[] = $row['label'];
        if ($row['id_langue'] == $id_select) $phons_autre_labels[] = $row['label'];
    }

    // JSON final
    $resultat = ['fr' => [], 'autre' => []];

    foreach ($rows as $row) {
        $label = $row['label'];
        $is_commun = (in_array($label, $phons_fr_labels) && in_array($label, $phons_autre_labels)); // Booléen pour savoir si le phon. est en commun ou non
        
        $data = [
            'label'     => $label,
            'is_commun' => $is_commun,

            // IMPORTANT : S'assurer que les clés entre [] correspondent aux noms des data- dans le html 
            'mode'      => $row['mode'],
            'point'     => $row['point'],
            'voix'      => $row['voix'],
            'ferm_ouv'  => $row['ferm_ouv'],
            'post_ant'  => $row['post_ant'],
            'arrondi'   => $row['arrondi']
        ];

        if ($row['id_langue'] == $id_fr) {
            $resultat['fr'][] = $data;
        } else {
            $resultat['autre'][] = $data;
        }
    }

    echo json_encode($resultat, JSON_UNESCAPED_UNICODE);

// Gestion des erreurs 
} catch(PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Erreur BDD: ' . $e->getMessage()], JSON_UNESCAPED_UNICODE);
}
?>