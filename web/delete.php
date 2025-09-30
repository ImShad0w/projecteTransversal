<?php
session_start();
require "connection.php";

header('Content-Type: application/json');
$request = json_decode(file_get_contents("php://input"), true);

if (!empty($_SESSION["login"]) && $_SESSION["login"] === true) {
    if (!empty($request)) {
        //Delete the respostes
        $stmt = $pdo->prepare("DELETE FROM respostes WHERE pregunta_id = ?");
        $stmt->execute([$request["id"]]);
        
        $stmt = $pdo->prepare("DELETE FROM preguntes WHERE id = ?");
        $stmt->execute([$request["id"]]);
        echo json_encode(["success" => true]);
        exit;
    }
}
echo json_encode(["success" => false, "message" => "Unauthorized or empty request"]);
?>
