<?php
session_start();

$json = file_get_contents("data.json");
$data = json_decode($json, true);

$preguntes = $data['preguntes'];

// Select 10 random questions
$seleccionades_keys = array_rand($preguntes, 10);

$_SESSION['preguntes'] = [];
foreach ($seleccionades_keys as $i) {
    $_SESSION['preguntes'][] = $preguntes[$i];
}
// Send only questions & options (no correct answer) to frontend
$toFrontend = $_SESSION['preguntes'];
foreach ($toFrontend as &$q) {
    unset($q['resposta_correcta']);
}
header('Content-Type: application/json');
echo json_encode($toFrontend);
?>
