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
    // Connection à la bdd
    $dbfile = 'gestion.db';
    $conn = new PDO("sqlite:" . $dbfile);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Requête SQL
    $sql = "SELECT description_text 
            FROM phonology_descriptions
            WHERE id_langue = :id"; 
            
    $stmt = $conn->prepare($sql);
    $stmt->execute(['id' => $langue_id]);
    
    $info = $stmt->fetch(PDO::FETCH_ASSOC);

    // Renvoi du texte contenu dans la bdd en json 
    if ($info) {
        echo json_encode([
            'success' => true,
            'description' => $info['description_text']
        ], JSON_UNESCAPED_UNICODE);
    } else {
        echo json_encode([
            'success' => true, 
            'description' => "Aucune description disponible pour cette langue."
        ]);
    }

    // Gestion des erreurs
} catch(PDOException $e) {
    http_response_code(500); 
    echo json_encode([
        'success' => false,
        'message' => "Erreur base de données: " . $e->getMessage()
    ]);
}
?>