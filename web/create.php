<?php
session_start();
require_once "connection.php";

header('Content-Type: application/json');
$request = json_decode(file_get_contents("php://input"), true);

if (!empty($_SESSION["login"]) && $_SESSION["login"] === true) {
    if (!empty($request)) {
        // Insert pregunta
        $stmt = $pdo->prepare("INSERT INTO preguntes (pregunta, resposta_correcta) VALUES (?, ?)");
        $stmt->execute([$request["pregunta"], $request["resposta_correcta"]]);
        $pregunta_id = $pdo->lastInsertId();

        // Insert responses
        foreach ($request["respostes"] as $resposta) {
            if (isset($resposta["imatge"]) && $resposta["imatge"] != null) {
                $stmt = $pdo->prepare("INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES (?, ?, ?)");
                $stmt->execute([$pregunta_id, $resposta["resposta"], $resposta["imatge"]]);
            } else {
                $stmt = $pdo->prepare("INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES (?, ?, ?)");
                $stmt->execute([$pregunta_id, $resposta["resposta"], null]);
            }
        }

        echo json_encode(["success" => true]);
        exit;
    }
}

// If unauthorized or empty
echo json_encode(["success" => false, "message" => "Unauthorized or empty request"]);
exit;

