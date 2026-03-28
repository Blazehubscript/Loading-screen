<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Ultimate Hacker UI</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: monospace;
}

body {
    background: #000;
    overflow: hidden;
    color: #00ff9f;
}

/* BACKGROUND */
.stars {
    position: absolute;
    width: 100%;
    height: 100%;
    background-image: radial-gradient(#003322 1px, transparent 1px);
    background-size: 40px 40px;
    opacity: 0.5;
}

/* ROCKET */
.rocket {
    position: absolute;
    left: 8%;
    bottom: -60px;
    font-size: 40px;
    animation: fly 4s linear infinite;
}

.fire {
    position: absolute;
    left: 8.5%;
    bottom: -20px;
    font-size: 20px;
    animation: fireAnim 0.3s infinite alternate;
}

@keyframes fly {
    0% { transform: translateY(0); opacity: 0; }
    20% { opacity: 1; }
    100% { transform: translateY(-120vh); opacity: 0; }
}

@keyframes fireAnim {
    from { transform: scale(1); }
    to { transform: scale(1.4); }
}

/* EMOJI */
.emoji {
    position: absolute;
    font-size: 18px;
    animation: floatEmoji linear infinite;
}

@keyframes floatEmoji {
    from { transform: translateY(100vh); opacity: 0; }
    to { transform: translateY(-10vh); opacity: 1; }
}

/* LAYOUT */
.container {
    display: flex;
    height: 100vh;
    align-items: center;
    justify-content: space-between;
    padding: 40px;
}

.side {
    width: 20%;
    text-align: center;
    font-size: 28px;
}

/* HACKER TEXT */
.hacker-text {
    position: relative;
    font-weight: bold;
    letter-spacing: 3px;
    color: #00ff9f;
    text-shadow: 0 0 8px #00ff9f;
    animation: flicker 1.5s infinite, moveText 3s ease-in-out infinite;
}

@keyframes moveText {
    0% { transform: translateX(0); }
    50% { transform: translateX(15px); }
    100% { transform: translateX(0); }
}

.hacker-text::before,
.hacker-text::after {
    content: attr(data-text);
    position: absolute;
    left: 0;
    width: 100%;
}

.hacker-text::before {
    color: #00ffaa;
    animation: glitchTop 1s infinite;
}

.hacker-text::after {
    color: #00cc88;
    animation: glitchBottom 1.2s infinite;
}

@keyframes glitchTop {
    0% { transform: translate(-2px,-2px); }
    50% { transform: translate(2px,2px); }
    100% { transform: translate(-1px,1px); }
}

@keyframes glitchBottom {
    0% { transform: translate(2px,2px); }
    50% { transform: translate(-2px,-2px); }
    100% { transform: translate(1px,-1px); }
}

@keyframes flicker {
    0%,100% { opacity: 1; }
    50% { opacity: 0.6; }
}

/* CENTER */
.center {
    width: 50%;
    background: #050505;
    border-radius: 15px;
    padding: 20px;
    box-shadow: 0 0 20px #00ff9f33;
}

.title {
    text-align: center;
    margin-bottom: 15px;
}

/* TERMINAL */
.terminal {
    background: #000;
    border-radius: 10px;
    padding: 15px;
    height: 250px;
    overflow: hidden;
    font-size: 13px;
    border: 1px solid #00ff9f33;
}

/* CURSOR */
.terminal p::after {
    content: "_";
    animation: blink 1s infinite;
}

@keyframes blink {
    0%,50%,100% { opacity: 1; }
    25%,75% { opacity: 0; }
}

/* PROGRESS */
.progress-container {
    margin-top: 15px;
    height: 8px;
    background: #003322;
    border-radius: 10px;
}

.progress-bar {
    height: 100%;
    width: 0%;
    background: #00ff9f;
    box-shadow: 0 0 10px #00ff9f;
}

.percent {
    text-align: center;
    margin-top: 8px;
}
</style>
</head>

<body>

<div class="stars"></div>

<!-- ROCKET -->
<div class="rocket">🚀</div>
<div class="fire">🔥</div>

<!-- EMOJI -->
<div class="emoji" style="left:20%; animation-duration:6s;">⭐</div>
<div class="emoji" style="left:40%; animation-duration:8s;">✨</div>
<div class="emoji" style="left:60%; animation-duration:7s;">⭐</div>
<div class="emoji" style="left:80%; animation-duration:9s;">✨</div>

<div class="container">
    <div class="side">
        <span class="hacker-text" data-text="> BYPASS">> BYPASS</span>
    </div>

    <div class="center">
        <div class="title hacker-text" data-text="> SYSTEM LOADING _">
            > SYSTEM LOADING _
        </div>

        <div class="terminal" id="terminal"></div>

        <div class="progress-container">
            <div class="progress-bar" id="progress"></div>
        </div>

        <div class="percent" id="percent">0%</div>
    </div>

    <div class="side">
        <span class="hacker-text" data-text="PROCESSING >">PROCESSING ></span>
    </div>
</div>

<script>
const lines = [
"> Establishing connection...",
"> Verifying system integrity...",
"> Initializing modules...",
"> Loading core engine...",
"> Decrypting data...",
"> Allocating memory...",
"> Syncing server...",
"> Bypassing firewall...",
"> Finalizing..."
];

let lineIndex = 0;
let charIndex = 0;
let progress = 0;

const terminal = document.getElementById("terminal");

function typeLine() {
    if (lineIndex >= lines.length) return;

    let currentLine = lines[lineIndex];

    if (!terminal.lastChild || terminal.lastChild.dataset.done === "true") {
        const p = document.createElement("p");
        p.textContent = "";
        p.dataset.done = "false";
        terminal.appendChild(p);
    }

    let p = terminal.lastChild;

    if (charIndex < currentLine.length) {
        p.textContent += currentLine.charAt(charIndex);
        charIndex++;
        setTimeout(typeLine, 30);
    } else {
        p.dataset.done = "true";
        lineIndex++;
        charIndex = 0;
        setTimeout(typeLine, 300);
    }

    terminal.scrollTop = terminal.scrollHeight;
}

function updateProgress() {
    if (progress <= 100) {
        document.getElementById("progress").style.width = progress + "%";
        document.getElementById("percent").textContent = Math.floor(progress) + "%";
        progress += Math.random() * 8;
    }
}

typeLine();
setInterval(updateProgress, 500);
</script>

</body>
</html>
