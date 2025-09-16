//Import the JSON as a module
import data from "./data.js";

//Get the base fields for rendering
const container = document.querySelector(".container");
const preg = document.querySelector(".pregunta");
const respostes = document.querySelector(".respostes");
const startGame = document.getElementById("startGame");

//Game state object with answers
const gameState = {
  gameOver: false,
  currQuestion: 0,
  userAnswers: [],
};
//let gameOver = true;
//let currQuestion = 0;
//let correctAnswers = 0;
//Get the questions
let preguntes = data["preguntes"];

//TODO: Create a way for rendering one question and it's responses at a time

startGame.addEventListener("click", () => {
  gameStart();
})

function gameStart() {
  gameState.gameOver = false;
  generateQuestion();
}

function generateQuestion() {
  //Clear out the fields before creating a question
  preg.innerHTML = "";
  respostes.innerHTML = "";
  //Get the current question
  const pregunta = preguntes[gameState.currQuestion].pregunta;
  const preguntaID = preguntes[gameState.currQuestion].id;
  const answers = preguntes[gameState.currQuestion].respostes;
  //Create the text for the question
  const question = document.createElement("p");
  question.textContent = pregunta;
  preg.appendChild(question);
  //Append the question to the container
  container.appendChild(preg);
  answers.forEach(resposta => {
    const resp = document.createElement("div");
    const text = document.createElement("p");
    text.textContent = resposta;
    //Add the class
    resp.classList.add("resposta")
    resp.appendChild(text);
    respostes.appendChild(resp);
    container.appendChild(respostes);
    resp.addEventListener("click", () => {
      gameState.currQuestion++;
      generateQuestion();
      gameState.userAnswers.push({ id: preguntaID, resposta: answers.indexOf(resposta) });
    })
  })
}

