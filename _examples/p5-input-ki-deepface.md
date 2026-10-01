---
title: Deepface
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_Deepface
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_Deepface
screenshot: "/assets/examples/p5-input-ki-deepface/screenshot.png"
related:
- Servers_RaspberriPi
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

Requirements: a webcam.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## Server

Needs `deepface` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(HTTP, port 7777), running on a Raspberry Pi in the same network as your
computer. Start it first with `python deepface_server.py` in its folder
(or `bash run_server.sh`, which restarts it after a crash). It exposes
`POST /analyze`, takes `{ "image": "<base64 jpeg>" }` and returns age,
gender, race and emotion as JSON (with CORS). The official DeepFace API
uses a different format. Set `serverURL` in `sketch.js` to its address
(default `http://10.21.4.117:7777/analyze`).

## How to Run

1. Make sure the DeepFace server is running (see Server).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Allow webcam access.
4. Press **Space** to send a frame for analysis. A red dot is shown while
   waiting for the answer.

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

Voraussetzungen: eine Webcam.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Server

Braucht `deepface` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(HTTP, Port 7777), auf einem Raspberry Pi im selben Netzwerk wie dein
Computer. Zuerst im Ordner mit `python deepface_server.py` starten (oder
`bash run_server.sh`, das ihn nach einem Absturz neu startet). Er bietet
`POST /analyze` an, nimmt `{ "image": "<base64 jpeg>" }` entgegen und
liefert Alter, Geschlecht, Herkunft und Emotion als JSON (mit CORS). Die
offizielle DeepFace-API verwendet ein anderes Format. In `sketch.js`
`serverURL` auf seine Adresse setzen (Standard
`http://10.21.4.117:7777/analyze`).

## Ausführen

1. Sicherstellen, dass der DeepFace-Server läuft (siehe Server).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Den Zugriff auf die Webcam erlauben.
4. **Leertaste** drücken, um ein Bild zur Analyse zu schicken. Während auf
   die Antwort gewartet wird, erscheint ein roter Punkt.

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
