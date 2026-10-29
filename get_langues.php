<?php

header('Content-Type: application/json');

try {\n    require_once __DIR__ . '/db_connect.php';\n    $conn = panneaux_db();
    
    // Récupération langue sélectionnée 
    $sql = "SELECT id_langue, nom_langue 
            FROM languages"; 
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $langues = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($langues, JSON_UNESCAPED_UNICODE);

// Gestion des erreurs    
} catch(Throwable $e) { 
    echo json_encode([
        'success' => false,
        'message' => 'Database request failed. Check the server error log.'
    ]);
}
?>