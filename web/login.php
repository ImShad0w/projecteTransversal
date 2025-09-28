<?php
session_start();
require 'connection.php'; // $pdo is available

header('Content-Type: application/json');

try {
    // Get JSON request from frontend
    $request = json_decode(file_get_contents("php://input"), true);

    if (!isset($request['username'], $request['password'])) {
        echo json_encode([
            "success" => false,
            "message" => "Empty request"
        ]);
        exit;
    }

    $username = $request["username"];
    $password = $request["password"];
    // Fetch single user row
    $stmt = $pdo->prepare("SELECT username, password FROM users WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && $password === $user["password"]) {
        // Login success
        $_SESSION["login"] = true;

        echo json_encode([
            "success" => true
        ]);
    } else {
        // Login failed
        $_SESSION["login"] = false;
        echo json_encode([
      "success" => false,
      "Message" => "Invalid credentials"

        ]);
    }
    exit;

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "error"   => "Server error"
    ]);
    exit;
}
?>
