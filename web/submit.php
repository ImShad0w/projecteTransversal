<?php
session_start();
//Set the score
$score = 0;
//Get the user answers
$raw = file_get_contents("php://input");
$userAnswers = json_decode($raw, true);

foreach($userAnswers as $answer){
  $preguntaID = $answer["id"];
  $respostaID = $answer["resposta"];
  foreach($_SESSION["preguntes"] as $q){
    if($q["id"] == $preguntaID){
      $correctIndex = $q["resposta_correcta"];
      if($respostaID == $correctIndex){
        $score++;
      }break;
    }
  }
}

header('Content-Type: application/json');
echo json_encode([
    'score' => $score,
]);
?>

