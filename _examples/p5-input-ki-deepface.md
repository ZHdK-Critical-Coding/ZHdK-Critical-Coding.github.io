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
your computer. The sketch is made for the small Flask server `deepface` in
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(`deepface_server.py`, port 7777): it exposes `POST /analyze`, expects the
body `{ "image": "<base64 jpeg>" }` and allows cross-origin requests (CORS).
The official DeepFace API (`img` / `img_path`) uses a different format and
does not work without changes.

Set `serverURL` at the top of `sketch.js` to your server (default
`http://10.21.4.117:7777/analyze`).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow webcam access.
3. Press **Space** to send a frame for analysis. A red dot is shown while
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

Voraussetzungen: eine Webcam und ein laufender DeepFace-Server, der vom
eigenen Computer aus erreichbar ist. Der Sketch ist für den kleinen
Flask-Server `deepface` in
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
gemacht (`deepface_server.py`, Port 7777): Er bietet `POST /analyze` an,
erwartet den Body `{ "image": "<base64 jpeg>" }` und erlaubt
Cross-Origin-Anfragen (CORS). Die offizielle DeepFace-API (`img` /
`img_path`) verwendet ein anderes Format und funktioniert nicht ohne
Anpassungen.

`serverURL` oben in `sketch.js` auf den eigenen Server setzen (Standard
`http://10.21.4.117:7777/analyze`).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Den Zugriff auf die Webcam erlauben.
3. **Leertaste** drücken, um ein Bild zur Analyse zu schicken. Während auf
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
