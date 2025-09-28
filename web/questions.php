<?php
session_start();
require 'connection.php'; // $pdo is available

// Fetch 10 random questions
$stmt = $pdo->query("SELECT id, pregunta, resposta_correcta FROM preguntes ORDER BY RAND() LIMIT 10");
$questions = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Prepare questions with answers
$allQuestions = [];
foreach ($questions as $q) {
    $stmt2 = $pdo->prepare("SELECT resposta, imatge FROM respostes WHERE pregunta_id = ?");
    $stmt2->execute([$q['id']]);
    $answers = $stmt2->fetchAll(PDO::FETCH_ASSOC);

    $formattedAnswers = [];
        foreach ($answers as $a) {
            $formattedAnswers[] = [
                'resposta' => $a['resposta'],
                'imatge' => $a['imatge'] // this ensures the image field is in the JSON
            ];
        }
    $allQuestions[] = [
        'id' => $q['id'],
        'pregunta' => $q['pregunta'],
        'resposta_correcta' => $q['resposta_correcta'],
        'respostes' => $answers
    ];
}

// Get JSON request from frontend
$request = json_decode(file_get_contents("php://input"), true);
$gameOver = isset($request["gameOver"]) && $request["gameOver"] === true;

// Only generate new questions if first fetch OR gameOver
if (!isset($_SESSION['preguntes']) || $gameOver) {
    $_SESSION['preguntes'] = $allQuestions; // assign directly
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
