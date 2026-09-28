---
title: Deepface
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_Deepface
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_Deepface
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Deepface

Captures the webcam and sends the current frame as a Base64 JPEG to a
[DeepFace](https://github.com/serengil/deepface) analysis server. The JSON
response (age, gender, emotion, …) is shown below the canvas. A starting
point for using face analysis on a server as input for a sketch.

## Installation

Requirements: a webcam, and a running DeepFace server that is reachable from
your computer and exposes `POST /analyze`. The sketch sends the body
`{ "image": "<base64 jpeg>" }` – the server has to accept this format and
allow cross-origin requests (CORS).

1. Set `serverURL` at the top of `sketch.js` to your server (default
   `http://10.21.4.117:7777/analyze`).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Allow webcam access.
4. Press **Space** to send a frame for analysis. A red dot is shown while
   waiting for the answer.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## Coding Help

- **`sketch.js` → `serverURL`**: address of the DeepFace endpoint.
- **`setup()`**: creates a 640 × 480 canvas, starts the webcam with
  `createCapture(VIDEO)` (hidden, drawn manually) and adds a `<pre>` element
  below the canvas for the response.
- **`draw()`**: draws the webcam image and the red dot while `waiting` is
  true.
- **`keyPressed()`**: Space (`keyCode 32`) calls `sendFrameToServer()`,
  unless a request is still running.
- **`sendFrameToServer()`**: converts the canvas to a Base64 JPEG with
  `canvas.toDataURL()`, posts it as JSON to `serverURL` and prints the
  response formatted into the `<pre>` element. To react to the result in
  the sketch (e.g. to the detected emotion), store `data` in a global
  variable and use it in `draw()`.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Deepface

Nimmt die Webcam auf und schickt das aktuelle Bild als Base64-JPEG an einen
[DeepFace](https://github.com/serengil/deepface)-Analyseserver. Die
JSON-Antwort (Alter, Geschlecht, Emotion, …) wird unter der Zeichenfläche
angezeigt. Ein Ausgangspunkt, um Gesichtsanalyse auf einem Server als Input
für einen Sketch zu verwenden.

## Installation

Voraussetzungen: eine Webcam und ein laufender DeepFace-Server, der vom
eigenen Computer aus erreichbar ist und `POST /analyze` anbietet. Der Sketch
schickt den Body `{ "image": "<base64 jpeg>" }` – der Server muss dieses
Format akzeptieren und Cross-Origin-Anfragen (CORS) erlauben.

1. `serverURL` oben in `sketch.js` auf den eigenen Server setzen (Standard
   `http://10.21.4.117:7777/analyze`).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Den Zugriff auf die Webcam erlauben.
4. **Leertaste** drücken, um ein Bild zur Analyse zu schicken. Während auf
   die Antwort gewartet wird, erscheint ein roter Punkt.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → `serverURL`**: Adresse des DeepFace-Endpunkts.
- **`setup()`**: erstellt eine 640 × 480 grosse Zeichenfläche, startet die
  Webcam mit `createCapture(VIDEO)` (versteckt, wird selbst gezeichnet) und
  fügt unter der Zeichenfläche ein `<pre>`-Element für die Antwort ein.
- **`draw()`**: zeichnet das Webcam-Bild und den roten Punkt, solange
  `waiting` true ist.
- **`keyPressed()`**: Die Leertaste (`keyCode 32`) ruft
  `sendFrameToServer()` auf, ausser es läuft noch eine Anfrage.
- **`sendFrameToServer()`**: wandelt die Zeichenfläche mit
  `canvas.toDataURL()` in ein Base64-JPEG um, schickt es als JSON an
  `serverURL` und schreibt die Antwort formatiert ins `<pre>`-Element. Um im
  Sketch auf das Ergebnis zu reagieren (z. B. auf die erkannte Emotion),
  `data` in einer globalen Variable speichern und in `draw()` verwenden.

</div>
