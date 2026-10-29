<?php
header('Content-Type: application/json; charset=utf-8');

//Récupère langue sélectionnée
if (!isset($_GET['id_langue']) || empty($_GET['id_langue'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Paramètre id_langue manquant'
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$id_langue = (int) $_GET['id_langue'];

try {\n    require_once __DIR__ . '/db_connect.php';\n    $conn = panneaux_db();

    //Récupération des descriptions phonologiques
    $sql = "SELECT description_text
            FROM phonology_descriptions
            WHERE id_langue = :id_langue";

    $stmt = $conn->prepare($sql);
    $stmt->bindValue(':id_langue', $id_langue, PDO::PARAM_INT);
    $stmt->execute();

    $description = $stmt->fetch(PDO::FETCH_ASSOC);

    // Si pas de description pour la langue sélectionnée
    if (!$description) {
        echo json_encode([
            'success' => false,
            'message' => 'Aucune description disponible pour cette langue.'
        ], JSON_UNESCAPED_UNICODE);
        exit;
    }

    echo json_encode($description, JSON_UNESCAPED_UNICODE);

// Gestion des erreurs
} catch(Throwable $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Database request failed. Check the server error log.'
    ], JSON_UNESCAPED_UNICODE);
}
?>