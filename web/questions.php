<?php
session_start();

// Get request body from resetGame
$request = json_decode(file_get_contents("php://input"), true);
$gameOver = isset($request["gameOver"]) && $request["gameOver"] === true;

$json = file_get_contents("data.json");
$data = json_decode($json, true);
$preguntes = $data['preguntes'];

// Only generate new questions if first fetch OR gameOver is true
if (!isset($_SESSION['preguntes']) || $gameOver) {
    // Completely reset session
    $_SESSION['preguntes'] = [];

    // Select 10 random questions
    $seleccionades_keys = array_rand($preguntes, 10);
    foreach ($seleccionades_keys as $i) {
        $_SESSION['preguntes'][] = $preguntes[$i];
    }
}

// Prepare questions for frontend (remove correct answers)
$toFrontend = $_SESSION['preguntes'];
foreach ($toFrontend as &$q) {
    unset($q['resposta_correcta']);
}

// Send JSON response once
header('Content-Type: application/json');
echo json_encode($toFrontend);
exit;
?>
