<?php
session_start();
require "connection.php";

header('Content-Type: application/json');
$request = json_decode(file_get_contents("php://input"), true);

if (!empty($_SESSION["login"]) && $_SESSION["login"] === true) {
    if (!empty($request)) {
        // Insert pregunta
        $stmt = $pdo->prepare("INSERT INTO preguntes (pregunta, resposta_correcta) VALUES (?, ?)");
        $stmt->execute([$request["pregunta"], $request["resposta_correcta"]]);
        $pregunta_id = $pdo->lastInsertId();

        // Insert respostes
        $stmt = $pdo->prepare("INSERT INTO respostes (pregunta_id, resposta) VALUES (?, ?)");
        foreach ($request["respostes"] as $resposta) {
            $stmt->execute([$pregunta_id, $resposta['resposta']]);
        }

        echo json_encode(["success" => true]);
        exit;
    }
}

// If unauthorized or empty
echo json_encode(["success" => false, "message" => "Unauthorized or empty request"]);
exit;
?>
