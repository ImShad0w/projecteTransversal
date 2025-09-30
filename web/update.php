<?php
session_start();
require "connection.php";

header('Content-Type: application/json');
$request = json_decode(file_get_contents("php://input"), true);

if (!empty($_SESSION["login"]) && $_SESSION["login"] === true) {
    if (!empty($request)) {
        // Update the main question
        $stmt = $pdo->prepare("UPDATE preguntes SET pregunta = ?, resposta_correcta = ? WHERE id = ?");
        $stmt->execute([$request["pregunta"], $request["resposta_correcta"], $request["id"]]);

        // Update each resposta individually
        if (!empty($request["respostes"]) && is_array($request["respostes"])) {
            $stmt = $pdo->prepare("UPDATE respostes SET resposta = ? WHERE id = ?");
            foreach ($request["respostes"] as $resposta) {
                $stmt->execute([$resposta["resposta"], $resposta["id"]]);
            }
        }

        echo json_encode(["success" => true]);
        exit;
    }
}

echo json_encode(["success" => false, "message" => "Unauthorized or empty request"]);
?>
