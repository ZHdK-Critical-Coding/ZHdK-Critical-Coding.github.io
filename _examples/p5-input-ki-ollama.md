---
title: Ollama
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_Ollama
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_Ollama
screenshot: "/assets/examples/p5-input-ki-ollama/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Ollama

Two AI personas talk to each other endlessly via an Ollama server. Each
answer is streamed and becomes the prompt for the other side; the dialogue
(in German) is drawn as a scrolling chat with left and right speech boxes.
A starting point for using a local language model in a sketch.

## Installation

Requirements: a running Ollama server (see Server).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), ollama-js 0.5.17 (browser build, `ollama_browser.mjs`).

## Server

Needs an [Ollama](https://ollama.com) server on port 11434 with the model
`gpt-oss` (`ollama pull gpt-oss`), on the same computer or on another
machine in the network. Start it before the sketch (Ollama app or
`ollama serve`). On another machine it must listen on the network
(`OLLAMA_HOST=0.0.0.0 ollama serve`); `OLLAMA_ORIGINS` (e.g. `"*"`) allows
browser requests from other origins. Set `ollama_host` at the top of
`sketch.js` to the server address (default `http://192.168.2.8:11434`,
e.g. `http://127.0.0.1:11434` for a local install).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. If the browser blocks the requests (CORS), allow the origin on the server
   (`OLLAMA_ORIGINS`, see Server) or start the debugger configuration
   **Launch Chrome (no Security)** (Run and Debug panel).
3. The conversation starts automatically with "Wie denkst du über den Mars?".

## Coding Help

- **`index.html`**: imports `Ollama` from `libraries/ollama_browser.mjs` as
  an ES module, stores it in `window.ollama` and only then loads
  `sketch.js`.
- **Config at the top of `sketch.js`**: `ollama_host`, `defaultSentence`
  (first line of the dialogue) and `temperature`. Two clients are created:
  `ollama` ("DR", left) and `ollama2` ("EM", right).
- **`chat(actor, lastSentence)`**: calls `actor.generate()` with the model
  `gpt-oss`, `stream: true` and a system prompt depending on the persona:
  DR asks short, critical questions, EM answers provocatively. Change model
  and system prompts here. Sampling options (`top_k`, `top_p`,
  `repeat_penalty`) are slightly randomised on each call. The streamed
  parts are appended to a new entry in `stack`; when the answer is complete,
  `chat()` calls itself with the other persona.
- **`setup()`**: sets up the layout values and starts the conversation with
  `chat(ollama2)`.
- **`draw()`**: shows a waiting message until the first answer arrives,
  then draws every entry of `stack` as a box (left or right by `align`) and
  scrolls down automatically. `textHeight()` computes the box height for
  wrapped text.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Ollama

Zwei KI-Personas unterhalten sich endlos über einen Ollama-Server. Jede
Antwort wird gestreamt und wird zum Prompt für die andere Seite; der Dialog
(auf Deutsch) wird als scrollender Chat mit Sprechboxen links und rechts
gezeichnet. Ein Ausgangspunkt, um ein lokales Sprachmodell in einem Sketch
zu verwenden.

## Installation

Voraussetzungen: ein laufender Ollama-Server (siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), ollama-js 0.5.17 (Browser-Build, `ollama_browser.mjs`).

## Server

Braucht einen [Ollama](https://ollama.com)-Server auf Port 11434 mit dem
Modell `gpt-oss` (`ollama pull gpt-oss`), auf demselben Computer oder auf
einem anderen Rechner im Netzwerk. Vor dem Sketch starten (Ollama-App
oder `ollama serve`). Auf einem anderen Rechner muss er im Netzwerk
erreichbar sein (`OLLAMA_HOST=0.0.0.0 ollama serve`); `OLLAMA_ORIGINS`
(z. B. `"*"`) erlaubt Browser-Anfragen von anderen Origins. `ollama_host`
oben in `sketch.js` auf die Adresse des Servers setzen (Standard
`http://192.168.2.8:11434`, z. B. `http://127.0.0.1:11434` bei einer
lokalen Installation).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Blockiert der Browser die Anfragen (CORS), den Origin auf dem Server
   erlauben (`OLLAMA_ORIGINS`, siehe Server) oder die Debugger-Konfiguration
   **Launch Chrome (no Security)** starten (Panel Run and Debug).
3. Die Unterhaltung startet automatisch mit "Wie denkst du über den Mars?".

## Coding-Hilfe

- **`index.html`**: importiert `Ollama` aus `libraries/ollama_browser.mjs`
  als ES-Modul, legt es in `window.ollama` ab und lädt erst dann
  `sketch.js`.
- **Konfiguration oben in `sketch.js`**: `ollama_host`, `defaultSentence`
  (erste Zeile des Dialogs) und `temperature`. Es werden zwei Clients
  erstellt: `ollama` ("DR", links) und `ollama2` ("EM", rechts).
- **`chat(actor, lastSentence)`**: ruft `actor.generate()` mit dem Modell
  `gpt-oss`, `stream: true` und einem System-Prompt je nach Persona auf: DR
  stellt kurze, kritische Fragen, EM antwortet provokant. Modell und
  System-Prompts hier ändern. Die Sampling-Optionen (`top_k`, `top_p`,
  `repeat_penalty`) werden bei jedem Aufruf leicht zufällig variiert.
  Die gestreamten Teile werden an einen neuen Eintrag in `stack` angehängt;
  ist die Antwort fertig, ruft sich `chat()` mit der anderen Persona selbst
  auf.
- **`setup()`**: setzt die Layout-Werte und startet die Unterhaltung mit
  `chat(ollama2)`.
- **`draw()`**: zeigt einen Wartehinweis, bis die erste Antwort da ist, und
  zeichnet dann jeden Eintrag von `stack` als Box (links oder rechts je nach
  `align`) und scrollt automatisch nach unten. `textHeight()` berechnet die
  Boxhöhe für umbrochenen Text.

</div>
