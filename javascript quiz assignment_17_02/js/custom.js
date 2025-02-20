    let questionForUser = document.getElementById("questionForUser");
    let optionsForUser = document.getElementById("optionForUser");
    let startButton = document.getElementById("startButton");
    let nextButton = document.getElementById("nextButton");
    let currentIndex = 0;
    let countTrue = 0;
    const questionsobj = [
        {
            question: "what is capital city of india?",
            choice: ["Gujrat", "delhi", "mumbai"],
            correct: 1
        },
        {
            question: " What has a face and two hands, but no arms or legs?",
            choice: ["hand", "leg", "clock"],
            correct: 2
        },
        {
            question: "What is the tallest land animal in the world?",
            choice: ["giraffe", "elephant", "lion"],
            correct: 0
        }
    ];
    nextButton.style.display="none"
    function startTest() {  
        currentIndex = 0;
        nextFunction();
        nextButton.style.display="block"
    }
    function nextFunction() {
        if (currentIndex < questionsobj.length) {
            questionForUser.textContent=questionsobj[currentIndex].question;
            optionsForUser.innerHTML = "";
            questionsobj[currentIndex].choice.forEach((choice,index)=>{
            let option = document.createElement("button");
            option.textContent=choice;
            option.className="option";
            option.onclick = () => checkAnswer(option,index) ;
            optionsForUser.appendChild(option);
         })
        }
         else{
            questionForUser.innerHTML="<h2> Your Quiz is completed </h2>";
            optionsForUser.textContent="";
            startButton.style.display="none"
            nextButton.style.display="none"
            optionsForUser.innerHTML="<h2>your score is" + count   +" out of " + questionsobj.length + "</h2>"
         }
        currentIndex++;
    }
    let count = 0;

    function checkAnswer(option,selectedIndex,) {
        let correctIndex = questionsobj[currentIndex - 1].correct;
        let allOptions = optionsForUser.querySelectorAll("button");
        allOptions.forEach((btn)=>{
            btn.disabled=true
        });
        if (selectedIndex === correctIndex) {
            option.style.backgroundColor = "green";
            option.style.color="black";
            count++;   
        } 
        else{
            option.style.backgroundColor="red";
            allOptions[correctIndex].style.backgroundColor="green";
            allOptions[correctIndex].style.color="black";
        }
    }
    