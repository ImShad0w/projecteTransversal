<?php
session_start();
require "connection.php";

header('Content-Type: application/json');
$request = json_decode(file_get_contents("php://input"), true);

if (!empty($_SESSION["login"]) && $_SESSION["login"] === true) {
    if (!empty($request)) {
        if($request["login"] === false){
          unset($_SESSION["login"]);
         }
        }
        echo json_encode(["success" => true]);
        exit;
    }
// If unauthorized or empty
echo json_encode(["success" => false, "message" => "Unauthorized or empty request"]);
exit;
?>
