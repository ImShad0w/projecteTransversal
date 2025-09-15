//Import the JSON as a module
import data from "./data.js";

//Get the base fields for rendering
const container = document.querySelector(".container");
const startGame = document.getElementById("startGame");

//Get the questions
let preguntes = data["preguntes"];

//TODO: Create a way for rendering one question and it's responses at a time

startGame.addEventListener("click", () => {
  preguntes.forEach(pregunta => {
    const preg = document.createElement("p");
    const resposta1 = document.createElement("p");
    const resposta2 = document.createElement("p");
    const resposta3 = document.createElement("p");
    const resposta4 = document.createElement("p");
    preg.textContent = pregunta["pregunta"];
    resposta1.textContent = pregunta["respostes"][0];
    resposta2.textContent = pregunta["respostes"][1];
    resposta3.textContent = pregunta["respostes"][2];
    resposta4.textContent = pregunta["respostes"][3];
    container.appendChild(preg);
    container.appendChild(resposta1);
    container.appendChild(resposta2);
    container.appendChild(resposta3);
    container.appendChild(resposta4);
  })
})

