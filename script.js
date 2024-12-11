// Array of sample texts
const texts = [
    "The quick brown fox jumps over the lazy dog.",
    "A journey of a thousand miles begins with a single step.",
    "To be or not to be, that is the question.",
    "In the middle of difficulty lies opportunity.",
    "Success is not final, failure is not fatal: It is the courage to continue that counts."
];

// Selecting elements from the DOM
const startBtn = document.getElementById("start-btn");
const randomTextElement = document.getElementById("random-text");
const textInput = document.getElementById("text-input");
const timeElement = document.getElementById("time");
const accuracyElement = document.getElementById("accuracy");
const speedElement = document.getElementById("speed");

let startTime;
let isTyping = false;
let totalWords = 0;
let correctWords = 0;

// Start the game
startBtn.addEventListener("click", startGame);

function startGame() {
    isTyping = true;
    totalWords = 0;
    correctWords = 0;
    textInput.value = "";
    textInput.disabled = false;
    textInput.focus();
    startBtn.textContent = "Restart";

    const randomIndex = Math.floor(Math.random() * texts.length);
    const randomText = texts[randomIndex];

    randomTextElement.textContent = randomText;

    startTime = Date.now();

    // Reset stats
    timeElement.textContent = 0;
    accuracyElement.textContent = 0;
    speedElement.textContent = 0;

    textInput.addEventListener("input", trackTyping);
}

function trackTyping() {
    const typedText = textInput.value;
    const targetText = randomTextElement.textContent;

    // Track total words typed
    const typedWords = typedText.split(/\s+/).filter(Boolean).length;
    totalWords = typedWords;

    // Calculate the correct words typed
    correctWords = typedText.split(" ").filter((word, index) => word === targetText.split(" ")[index]).length;

    // Calculate accuracy and speed
    const accuracy = Math.round((correctWords / totalWords) * 100) || 0;
    const elapsedTime = Math.floor((Date.now() - startTime) / 1000);
    const wordsPerMinute = Math.round((totalWords / elapsedTime) * 60) || 0;

    accuracyElement.textContent = accuracy;
    timeElement.textContent = elapsedTime;
    speedElement.textContent = wordsPerMinute;

    // Check if the user has finished typing the text
    if (typedText === targetText) {
        endGame(elapsedTime);
    }
}

function endGame(elapsedTime) {
    isTyping = false;
    textInput.disabled = true;
    startBtn.textContent = "Start";
    alert(`Congratulations! Your typing speed was ${speedElement.textContent} words per minute with an accuracy of ${accuracyElement.textContent}%`);
}
