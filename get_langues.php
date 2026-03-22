<?php

header('Content-Type: application/json');

try {
    // Connection à la bdd SQLite
    $dbfile = 'gestion.db';
    $conn = new PDO("sqlite:" . $dbfile);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $sql = "SELECT id_langue, nom_langue 
            FROM languages"; 
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $langues = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($langues, JSON_UNESCAPED_UNICODE);

} catch(PDOException $e) { // Gestion des erreurs
    echo json_encode([
        'success' => false,
        'message' => "Erreur: " . $e->getMessage()
    ]);
}
?>
