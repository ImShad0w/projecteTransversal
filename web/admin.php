<?php
session_start();
require "connection.php";

header('Content-Type: application/json');
$questions = [];

if (!empty($_SESSION["login"]) && $_SESSION["login"] === true) {
    $stmt = $pdo->query("SELECT id, pregunta, resposta_correcta FROM preguntes");
    $preguntes = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($preguntes as $q) {
        $stmt2 = $pdo->prepare("SELECT resposta FROM respostes WHERE pregunta_id = ?");
        $stmt2->execute([$q["id"]]);
        $respostes = $stmt2->fetchAll(PDO::FETCH_COLUMN);

        $questions[] = [
            "id" => $q["id"],
            "pregunta" => $q["pregunta"],
            "resposta_correcta" => $q["resposta_correcta"],
            "respostes" => $respostes
        ];
    }

    echo json_encode($questions);

} else {
    echo json_encode([
        "status" => "Failed",
        "message" => "No privileges to perform this action."
    ]);
}
?>
