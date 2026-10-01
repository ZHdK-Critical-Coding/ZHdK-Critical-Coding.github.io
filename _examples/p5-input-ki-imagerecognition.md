---
title: Image Recognition
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_ImageRecognition
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ImageRecognition
screenshot: "/assets/examples/p5-input-ki-imagerecognition/screenshot.png"
related:
- Servers_RaspberriPi
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Image Recognition

Classifies a live video image with the ml5.js image classifier (Darknet
model) and lists the recognised labels with their confidence next to the
video. Works with the webcam or an MJPEG network stream. A starting point
for reacting to objects in front of a camera.

## Installation

Requirements: a webcam (or an MJPEG stream) and an internet connection –
the model is downloaded on first start.

Optional, MJPEG stream instead of webcam: set `videoSrc` to the stream URL
and `useWebcam = false` (`true`, the default, uses the webcam). The stream
needs a proxy (see Server).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), ml5.js 1.2.2.

## Server

Only needed for the MJPEG stream (`useWebcam = false`): `stream-proxy` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(HTTP, port 5000), running on a Raspberry Pi in the same network as your
computer. Start it first with `bash run.sh` (or `python server.py`) in its
folder. It fetches the camera stream and passes it on with CORS headers,
so the classifier can read its pixels. Set `proxyUrl` in `sketch.js` to
`http://<pi-ip>:5000/stream?url=`.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow webcam access. The webcam image appears top left, the
   classification results on the right.

## Coding Help

- **Config at the top of `sketch.js`**: `videoSrc` (MJPEG stream URL),
  `proxyUrl` (CORS proxy) and `useWebcam` (source switch, see above).
- **`preload()`**: loads the classifier with
  `ml5.imageClassifier("darknet")`. Other models (e.g. `"MobileNet"`) can be
  set here.
- **`setup()`**: creates a full-window canvas and either the webcam capture
  (640 × 480) or an `<img>` element with the proxied stream. Then
  `classifier.classifyStart()` classifies the incoming frames continuously
  and writes the result array into `label`.
- **`draw()`**: draws the video into the top left quarter and prints each
  entry of `label` (`label` and `confidence`) as text on the right. To
  react to a specific object, check e.g. `label[0].label` here.
- **`wait()`**: shows the stream URL while the stream is not ready yet.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Image Recognition

Klassifiziert ein Live-Videobild mit dem Image Classifier von ml5.js
(Darknet-Modell) und listet die erkannten Labels mit ihrer Konfidenz neben
dem Video auf. Funktioniert mit der Webcam oder einem MJPEG-Netzwerkstream.
Ein Ausgangspunkt, um auf Objekte vor einer Kamera zu reagieren.

## Installation

Voraussetzungen: eine Webcam (oder ein MJPEG-Stream) und eine
Internetverbindung – das Modell wird beim ersten Start heruntergeladen.

Optional, MJPEG-Stream statt Webcam: `videoSrc` auf die Stream-URL und
`useWebcam = false` setzen (`true`, der Standard, verwendet die Webcam).
Der Stream braucht einen Proxy (siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), ml5.js 1.2.2.

## Server

Nur für den MJPEG-Stream nötig (`useWebcam = false`): `stream-proxy` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(HTTP, Port 5000), auf einem Raspberry Pi im selben Netzwerk wie dein
Computer. Zuerst im Ordner mit `bash run.sh` (oder `python server.py`)
starten. Er holt den Kamerastream und reicht ihn mit CORS-Headern weiter,
damit der Classifier seine Pixel lesen kann. In `sketch.js` `proxyUrl` auf
`http://<pi-ip>:5000/stream?url=` setzen.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Den Zugriff auf die Webcam erlauben. Oben links erscheint das
   Webcam-Bild, rechts die Klassifizierungsergebnisse.

## Coding-Hilfe

- **Konfiguration oben in `sketch.js`**: `videoSrc` (MJPEG-Stream-URL),
  `proxyUrl` (CORS-Proxy) und `useWebcam` (Umschalter für die Quelle, siehe
  oben).
- **`preload()`**: lädt den Classifier mit `ml5.imageClassifier("darknet")`.
  Andere Modelle (z. B. `"MobileNet"`) lassen sich hier setzen.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche und entweder
  die Webcam-Aufnahme (640 × 480) oder ein `<img>`-Element mit dem Stream
  über den Proxy. Danach klassifiziert `classifier.classifyStart()` die
  eingehenden Bilder laufend und schreibt das Ergebnis-Array in `label`.
- **`draw()`**: zeichnet das Video ins obere linke Viertel und schreibt
  jeden Eintrag von `label` (`label` und `confidence`) rechts als Text hin.
  Um auf ein bestimmtes Objekt zu reagieren, hier z. B. `label[0].label`
  prüfen.
- **`wait()`**: zeigt die Stream-URL an, solange der Stream noch nicht
  bereit ist.

</div>
