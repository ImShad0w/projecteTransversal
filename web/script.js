let preguntes = []
let preguntesCorrectes;

//Get the data from the php file
fetch('questions.php')
  .then(response => response.json()) // Parse the JSON automatically
  .then(data => {
    preguntes = data;
  })
  .catch(err => console.error(err));

//Get the base fields for rendering
const container = document.querySelector(".container");
const preg = document.querySelector(".pregunta");
const respostes = document.querySelector(".respostes");
const startGame = document.getElementById("startGame");
const scoreboard = document.querySelector(".scoreboard");
const resetGame = document.getElementById("resetGame");
const timerDiv = document.getElementById("timerDiv");
const loginBtn = document.getElementById("login");
const loginForm = document.getElementById("loginForm");
const mainMenu = document.getElementById("mainMenu");

//Add hidden thing
mainMenu.classList.add("hidden");

//Game state object with answers
const gameState = {
  gameOver: false,
  currQuestion: 0,
  userAnswers: [],
};

const timer = {
  time: 30,
  timerID: null, // store interval ID here

  setTimer: function () {
    timerDiv.innerHTML = "";
    const time = document.createElement("h1");
    time.textContent = timer.time;
    timerDiv.appendChild(time);
  },

  resetTimer: function () {
    this.stopTimer();
    this.time = 30;
    timerDiv.innerHTML = "";
  },

  startTimer: function () {
    this.timerID = setInterval(() => {
      if (this.time > 0) {
        this.time--;
        this.setTimer();
      } else {
        this.stopTimer();
        showGameResults();
        timerDiv.innerHTML = "";
      }
    }, 1000);
  },

  stopTimer: function () {
    clearInterval(this.timerID);
    console.log("Timer stopped");
  }
};

startGame.addEventListener("click", () => {
  gameStart();
  startGame.style.display = "none";
})

function gameStart() {
  loginBtn.classList.add("hidden");
  gameState.gameOver = false;
  generateQuestion();
  timer.startTimer();
  showCurrenQuestion();
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
      gameState.userAnswers.push({ id: preguntaID, resposta: answers.indexOf(resposta) });
      gameState.currQuestion++;
      checkGameState();
    })
  })
}

function checkGameState() {
  if (gameState.currQuestion == preguntes.length || timer.time == 0) {
    showGameResults();
  } else {
    generateQuestion();
    showCurrenQuestion();
  }
}

function showGameResults() {
  //Cleanup all of the shit
  container.innerHTML = "";
  startGame.classList.add("hidden");
  getScore();
}

function getScore() {
  fetch('submit.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json' // tell PHP we are sending JSON
    },
    body: JSON.stringify(gameState.userAnswers)
  })
    .then(response => response.json())
    .then(data => {
      renderScore(data.score);
      timer.resetTimer();
    })// data returned from PHP
    .catch(err => console.error(err));
}

function renderScore(score) {
  gameState.gameOver = true;
  scoreboard.innerHTML = "";
  const scores = document.createElement("p");
  scores.innerText = `You got a score of: ${score} / ${preguntes.length}`;
  scoreboard.appendChild(scores);
  container.appendChild(scoreboard);
  resetGame.style.display = "block";
  mainMenu.classList.remove("hidden");
  mainMenu.addEventListener("click", () => {
    //FIX: Tmporal fix for being able to go to the main menu
    if (gameState.gameOver) {
      gameState.currQuestion = 0;
      fetch('questions.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json' // tell PHP we are sending JSON
        },
        body: JSON.stringify({ gameOver: gameState.gameOver })
      })
        .then(response => response.json())
        .then(data => {
          gameState.userAnswers.length = 0;
          preguntes = data;
          timer.resetTimer();
          renderMainPage();
          mainMenu.classList.add("hidden");
        })// data returned from PHP
        .catch(err => console.error(err));
    }
  })
  resetGame.addEventListener("click", () => {
    reseetGame();
    resetGame.style.display = "none";
    scoreboard.innerHTML = "";
  })
}

function reseetGame() {
  gameState.currQuestion = 0;
  fetch('questions.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json' // tell PHP we are sending JSON
    },
    body: JSON.stringify({ gameOver: gameState.gameOver })
  })
    .then(response => response.json())
    .then(data => {
      gameState.userAnswers.length = 0;
      preguntes = data;
      timer.resetTimer();
      gameStart();
    })// data returned from PHP
    .catch(err => console.error(err));
}


function showCurrenQuestion() {
  scoreboard.innerHTML = "";
  const currentScore = document.createElement("h4");
  currentScore.textContent = `Question ${gameState.currQuestion + 1} out of: ${preguntes.length}`;
  scoreboard.appendChild(currentScore);
}


//Login part
loginBtn.addEventListener("click", () => {
  renderLogin();
})

function renderLogin() {
  loginForm.innerHTML = "";
  container.style.display = "none";
  loginBtn.classList.add("hidden");
  startGame.style.display = "none";
  resetGame.style.display = "none";
  const welcome = document.createElement("h1");
  const username = document.createElement("input");
  const password = document.createElement("input");
  const submit = document.createElement("button");
  const cancel = document.createElement("button");
  const btnDiv = document.createElement("div");

  welcome.textContent = "Welcome back!";
  username.type = "text";
  password.type = "password";
  submit.textContent = "Login!";
  cancel.textContent = "Go back";

  btnDiv.appendChild(submit);
  btnDiv.appendChild(cancel);
  loginForm.appendChild(welcome);
  loginForm.appendChild(username);
  loginForm.appendChild(password);
  loginForm.appendChild(btnDiv);
  btnDiv.classList.add("loginBtns");
  loginForm.classList.add("loginForm");

  submit.addEventListener("click", () => {
    fetch('login.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json' // tell PHP we are sending JSON
      },
      body: JSON.stringify({ username: username.value, password: password.value })
    })
      .then(response => response.json())
      .then(data => {
        console.log(data);
        if (data.login) {
          //Render the dashboard
        } else {
          alert("Invalid username or password");
          username.value = "";
          password.value = "";
        }
      })// data returned from PHP
      .catch(err => console.error(err));

  })

  cancel.addEventListener("click", () => {
    loginForm.innerHTML = "";
    renderMainPage();
  })
}

function renderMainPage() {
  scoreboard.innerHTML = "";
  container.style.display = "block";
  resetGame.style.display = "none";
  startGame.style.display = "block";
  loginBtn.classList.remove("hidden");
}
