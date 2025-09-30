let preguntes = [];


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
const dashboard = document.getElementById("dashboard");
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
    text.textContent = resposta["resposta"];

    // Create the image element instead of using background
    const img = document.createElement("img");
    img.src = resposta["imatge"];
    img.style.width = "75px";
    img.style.height = "75px";
    img.style.objectFit = "contain"; // keeps aspect ratio without stretching
    img.style.marginLeft = "10px"; // space between text and image

    // Layout flex to position text left and image right
    resp.style.display = "flex";
    resp.style.alignItems = "center";
    resp.style.justifyContent = "space-between"; // text left, image right

    //Add the class
    resp.classList.add("resposta");

    resp.appendChild(text);
    resp.appendChild(img); // append image after text
    respostes.appendChild(resp);
    container.appendChild(respostes);

    resp.addEventListener("click", () => {
      gameState.userAnswers.push({ id: preguntaID, resposta: answers.indexOf(resposta) });
      gameState.currQuestion++;
      checkGameState();
    });
  });

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
    mainMenu.classList.add("hidden");
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
  currentScore.textContent = `Pregunta ${gameState.currQuestion + 1} de: ${preguntes.length}`;
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
  loginForm.classList.remove("hidden");
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

  btnDiv.appendChild(cancel);
  btnDiv.appendChild(submit);
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
        if (data.success) {
          renderDashboard();
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
  dashboard.innerHTML = "";
  loginForm.classList.remove("loginForm");
  loginForm.classList.add("hidden");
  loginBtn.classList.remove("hidden");
}

function renderDashboard() {
  fetch('admin.php')
    .then(response => response.json())
    .then(data => {
      loginForm.innerHTML = ""; // hide login form
      dashboard.innerHTML = ""; // clear previous content
      loginForm.classList.remove("loginForm");
      loginForm.classList.add("hidden");
      dashboard.classList.remove("hidden");

      const buttonDiv = document.createElement("div");
      const createBtn = document.createElement("button");
      const logoutBtn = document.createElement("button");
      const pContainer = document.createElement("div");

      pContainer.classList.add("questions");
      createBtn.textContent = "Create...";
      logoutBtn.textContent = "Logout";

      buttonDiv.classList.add("buttonsDiv");
      buttonDiv.appendChild(createBtn);
      buttonDiv.appendChild(logoutBtn);
      dashboard.appendChild(buttonDiv);

      //Creates a new question
      createBtn.addEventListener("click", () => {
        renderCreateForm();
      });
      logoutBtn.addEventListener("click", () => {
        logoutFromAdmin();
      })
      data.forEach(pregunta => {
        const card = document.createElement("div");
        card.classList.add("card");
        const pID = document.createElement("p");
        const pPregunta = document.createElement("h3");
        const pRespCorr = document.createElement("p");
        const respsDiv = document.createElement("div");
        const editButton = document.createElement("button");
        const deleteButton = document.createElement("button");

        pID.textContent = `ID: ${pregunta.id}`;
        pPregunta.textContent = pregunta.pregunta;
        pRespCorr.textContent = `Correct: ${pregunta.resposta_correcta}`;
        editButton.textContent = "Edit";
        deleteButton.textContent = "Delete";
        pregunta.respostes.forEach(resposta => {
          const resp = document.createElement("p");
          resp.textContent = resposta.resposta;
          resp.dataset.id = resposta.id;
          respsDiv.appendChild(resp);
        });
        editButton.addEventListener("click", () => {
          editQuestion(pregunta);
        });
        card.appendChild(pID);
        card.appendChild(pPregunta);
        card.appendChild(pRespCorr);
        card.appendChild(respsDiv);
        card.appendChild(editButton);
        card.appendChild(deleteButton);
        pContainer.appendChild(card);

        //Delete the pregunta
        deleteButton.addEventListener("click", () => {
          fetch('delete.php', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id: pregunta.id })
          })
            .then(response => response.json())
            .then(data => {
              console.log(data);
              if (data.success) {
                renderDashboard();
              } else {
                alert(data.message)
                renderDashboard();
              }
            })
            .catch(err => console.error(err));
        });
      });
      dashboard.appendChild(pContainer);
    })
    .catch(err => console.error(err));
}

function editQuestion(pregunta) {
  // Find the card by its ID
  const card = [...document.querySelectorAll(".card")]
    .find(c => c.querySelector("p").textContent.includes(pregunta.id));

  //Find and delete the buttons
  const editBtn = card.querySelector("button:nth-of-type(1)");
  const delBtn = card.querySelector("button:nth-of-type(2)");

  editBtn.remove();
  delBtn.remove();
  if (!card) return;
  //Question text
  const pPregunta = card.querySelector("h3");
  const qInput = document.createElement("input");
  qInput.type = "text";
  qInput.value = pregunta.pregunta;
  pPregunta.replaceWith(qInput);

  //Correct answer
  const pRespCorr = card.querySelector("p:nth-of-type(2)");
  const rInput = document.createElement("input");
  rInput.type = "text";
  rInput.value = pregunta.resposta_correcta;
  pRespCorr.replaceWith(rInput);

  //Respostes
  const respsDiv = card.querySelector("div");
  respsDiv.innerHTML = ""; // clear current <p> list

  pregunta.respostes.forEach(resposta => {
    const respInput = document.createElement("input");
    respInput.type = "text";
    respInput.value = resposta.resposta;
    respInput.dataset.id = resposta.id;
    respsDiv.appendChild(respInput);
  });

  //Buttons 
  const updateBtn = document.createElement("button");
  const cancelBtn = document.createElement("button");

  updateBtn.textContent = "Update";
  cancelBtn.textContent = "Cancel";

  card.appendChild(updateBtn);
  card.appendChild(cancelBtn);

  cancelBtn.addEventListener("click", () => {
    renderDashboard();
  })

  updateBtn.addEventListener("click", () => {
    const card = updateBtn.closest(".card");

    // Grab the first two inputs
    const qInput = card.querySelector("input[type=text]:nth-of-type(1)");
    const rInput = card.querySelector("input[type=text]:nth-of-type(2)");

    // Extract values
    const newPregunta = qInput.value;
    const newRespCorr = rInput.value;

    //Selects all of the text inputs in the card
    const inputs = [...card.querySelectorAll("input[type=text]")];
    const newRespostes = inputs.slice(2) //Grabs the 3rd input and the following after it
      //Converts into an array of objects
      .map(input => ({
        id: input.dataset.id,
        resposta: input.value
      }));
    fetch('update.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        id: pregunta.id,
        pregunta: newPregunta,
        resposta_correcta: newRespCorr,
        respostes: newRespostes
      })
    })
      .then(response => response.json())
      .then(data => {
        console.log(data);
        if (data.success) {
          console.log(data);
          renderDashboard();
        } else {
          alert(data.message)
          renderDashboard();
        }
      })
      .catch(err => console.error(err));
  });
}

function renderCreateForm() {
  //Clear out for the form
  dashboard.innerHTML = "";

  const formDiv = document.createElement("div");
  const pInput = document.createElement("input");
  const respCorrInp = document.createElement("input");
  const respDiv = document.createElement("div");
  const acceptBtn = document.createElement("button");
  const cancelBtn = document.createElement("button");
  const title = document.createElement("h1");
  const respostesTitle = document.createElement("h2");

  title.textContent = "Crea una nova pregunta";
  respostesTitle.textContent = "Respostes: ";
  pInput.type = "text";
  respCorrInp.type = "number";
  acceptBtn.textContent = "Accept";
  cancelBtn.textContent = "Cancel";
  pInput.placeholder = "Ex: Quina marca es famosa pel fundador: Mark Zuckerberg?";

  respCorrInp.min = 0;
  respCorrInp.max = 3;
  respCorrInp.step = 1; // only allows integers 0,1,2,3
  respCorrInp.value = 0; //default value
  respDiv.appendChild(respostesTitle);
  //Append 4 input for the answers
  for (let i = 0; i < 4; i++) {
    const respInput = document.createElement("input");
    respInput.type = "text";
    respDiv.appendChild(respInput);
  }

  formDiv.classList.add("card");
  formDiv.appendChild(title);
  formDiv.appendChild(pInput);
  formDiv.appendChild(respCorrInp);
  formDiv.appendChild(respDiv);
  formDiv.appendChild(acceptBtn);
  formDiv.appendChild(cancelBtn);
  dashboard.appendChild(formDiv);
  acceptBtn.addEventListener("click", () => {
    const newResps = [...respDiv.querySelectorAll("input[type=text]")]; // Gets all answers
    const respostes = newResps.map(input => ({
      resposta: input.value
    }));
    fetch('create.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        pregunta: pInput.value,
        resposta_correcta: respCorrInp.value,
        respostes: respostes
      })
    })
      .then(response => response.json())
      .then(data => {
        console.log(data);
        if (data.success) {
          console.log(data);
          renderDashboard();
        } else {
          alert(data.message)
          renderDashboard();
        }
      })
      .catch(err => console.error(err));
  })
  cancelBtn.addEventListener("click", () => {
    renderDashboard();
  });
}

function logoutFromAdmin() {
  fetch('logout.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      login: false
    })
  })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        renderMainPage();
      } else {
        alert(data.message)
      }
    })
    .catch(err => console.error(err));

}
