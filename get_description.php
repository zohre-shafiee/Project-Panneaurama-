<?php
header('Content-Type: application/json; charset=utf-8');

if (!isset($_GET['id_langue']) || empty($_GET['id_langue'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Paramètre id_langue manquant'
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$id_langue = (int) $_GET['id_langue'];

try {
    $dbfile = 'gestion.db';
    $conn = new PDO("sqlite:" . $dbfile);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "SELECT description_text
            FROM phonology_descriptions
            WHERE id_langue = :id_langue";

    $stmt = $conn->prepare($sql);
    $stmt->bindValue(':id_langue', $id_langue, PDO::PARAM_INT);
    $stmt->execute();

    $description = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$description) {
        echo json_encode([
            'success' => false,
            'message' => 'Aucune description disponible pour cette langue.'
        ], JSON_UNESCAPED_UNICODE);
        exit;
    }

    echo json_encode($description, JSON_UNESCAPED_UNICODE);

} catch(PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Erreur BDD: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
?>
