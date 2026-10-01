---
title: WebLLM
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_WebLLM
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_WebLLM
screenshot: "/assets/examples/p5-input-ki-webllm/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: WebLLM

Runs two instances of a small language model (`Llama-3.2-1B-Instruct`)
directly in the browser using [WebLLM](https://github.com/mlc-ai/web-llm).
The two models discuss with each other in German; the conversation is drawn
as a scrolling chat with left and right speech boxes. A starting point for
using a language model without any server.

## Installation

Requirements: a browser with WebGPU support (Chrome or Edge) and enough GPU
memory for two copies of the model. The model is downloaded on first start,
which can take a while.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), WebLLM 0.2.79 (`@mlc-ai/web-llm`, jsDelivr bundle `webllm.js`).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Wait until both models are loaded (the progress is shown at the bottom
   of the page), then click on the canvas to start the conversation. Clicks
   before that, and further clicks, are ignored.

## Coding Help

- **`index.html`**: imports `libraries/webllm.js` as an ES module, stores it
  in `window.webllm` and only then loads `sketch.js`.
- **`setup()`**: creates the canvas and the layout values, then calls
  `loadModels()`.
- **`loadModels()`**: creates two engines with
  `webllm.CreateMLCEngine(selectedModel, { initProgressCallback })`; the
  callback writes the progress into `loadingText`, which `draw()` shows.
  When both are loaded, `modelsReady` is set to true. Change
  `selectedModel` to use another model from the WebLLM model list.
- **`chat(actor, lastSentence)`**: builds a `messages` array with a system
  prompt depending on the persona – `engine1` ("DR", left) asks short,
  critical questions, `engine2` ("EM", right) answers provocatively – and
  the last sentence as user message. It calls
  `actor.chat.completions.create()` (OpenAI-style API, `stream: true`,
  `temperature` from the global variable, default `0.5`), appends the streamed chunks to a new entry in `stack`
  and then calls itself with the other engine.
- **`mouseClicked()`**: starts the conversation once with `chat(engine2)`,
  using `defaultSentence` as first prompt – only when `modelsReady` is true
  and the conversation has not `started` yet.
- **`draw()`**: draws every entry of `stack` as a box (left or right by
  `align`) and scrolls down automatically. Until the conversation starts it
  shows `loadingText` at the bottom. `textHeight()` computes the box height
  for wrapped text.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: WebLLM

Führt zwei Instanzen eines kleinen Sprachmodells (`Llama-3.2-1B-Instruct`)
direkt im Browser mit [WebLLM](https://github.com/mlc-ai/web-llm) aus. Die
beiden Modelle diskutieren auf Deutsch miteinander; die Unterhaltung wird
als scrollender Chat mit Sprechboxen links und rechts gezeichnet. Ein
Ausgangspunkt, um ein Sprachmodell ganz ohne Server zu verwenden.

## Installation

Voraussetzungen: ein Browser mit WebGPU-Unterstützung (Chrome oder Edge)
und genug GPU-Speicher für zwei Kopien des Modells. Das Modell wird beim
ersten Start heruntergeladen, das kann eine Weile dauern.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), WebLLM 0.2.79 (`@mlc-ai/web-llm`, jsDelivr-Bundle
`webllm.js`).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Warten, bis beide Modelle geladen sind (der Fortschritt wird unten auf
   der Seite angezeigt), dann auf die Zeichenfläche klicken, um die
   Unterhaltung zu starten. Klicks davor und weitere Klicks werden
   ignoriert.

## Coding-Hilfe

- **`index.html`**: importiert `libraries/webllm.js` als ES-Modul, legt es
  in `window.webllm` ab und lädt erst dann `sketch.js`.
- **`setup()`**: erstellt die Zeichenfläche und die Layout-Werte und ruft
  dann `loadModels()` auf.
- **`loadModels()`**: erstellt zwei Engines mit
  `webllm.CreateMLCEngine(selectedModel, { initProgressCallback })`; der
  Callback schreibt den Fortschritt in `loadingText`, das `draw()` anzeigt.
  Sind beide geladen, wird `modelsReady` auf true gesetzt. `selectedModel`
  ändern, um ein anderes Modell aus der WebLLM-Modellliste zu verwenden.
- **`chat(actor, lastSentence)`**: baut ein `messages`-Array mit einem
  System-Prompt je nach Persona – `engine1` ("DR", links) stellt kurze,
  kritische Fragen, `engine2` ("EM", rechts) antwortet provokant – und dem
  letzten Satz als User-Nachricht. Ruft `actor.chat.completions.create()`
  auf (API im OpenAI-Stil, `stream: true`, `temperature` aus der globalen
  Variable, Standard `0.5`), hängt die
  gestreamten Teile an einen neuen Eintrag in `stack` an und ruft sich dann
  mit der anderen Engine selbst auf.
- **`mouseClicked()`**: startet die Unterhaltung einmal mit `chat(engine2)`,
  mit `defaultSentence` als erstem Prompt – nur wenn `modelsReady` true ist
  und die Unterhaltung noch nicht `started` ist.
- **`draw()`**: zeichnet jeden Eintrag von `stack` als Box (links oder
  rechts je nach `align`) und scrollt automatisch nach unten. Bis die
  Unterhaltung startet, zeigt es unten `loadingText` an. `textHeight()`
  berechnet die Boxhöhe für umbrochenen Text.

</div>
