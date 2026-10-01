---
title: CRT
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_CRT
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_CRT
screenshot: "/assets/examples/p5-output-crt/screenshot.png"
related:
- Servers_RaspberriPi
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: CRT

Streams the canvas of a p5 sketch as JPEG frames over a WebSocket to a
Raspberry Pi, which shows them on a CRT TV (composite video, PAL). The demo
draws the webcam image with three moving circles in red, green and blue on
top. A starting point for using an old TV as an output for a sketch.

## Installation

Requirements: a webcam and a browser on the same network as the Pi (see
Server).

Libraries (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (included, not used).

License: MIT

## Server

Needs `crt-websocket` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
running on a Raspberry Pi with a CRT TV on its composite output (PAL),
port 8100. Start it first with `bash run.sh` in the folder on the Pi; it
shows the Pi's IP on the TV. It takes JPEG frames of exactly 720 × 576 and
answers `ok` after each one. Put its address in `connection` at the top of
`sketch.js`.

## How to Run

1. Start the server on the Pi (see Server). It shows its IP address on the TV.
2. Enter that address in `connection` at the top of `sketch.js`, e.g.
   `ws://10.21.14.32:8100`.
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. Allow camera access. The frames are sent as soon as the connection is
   open.

## Coding Help

- **`sketch.js` → `connection`, `crt`**: server address and the PAL size
  720 × 576. The server writes each frame directly into a 720 × 576
  framebuffer, so the frames it receives must have exactly that size.
- **`setup()`**: sets `pixelDensity(1)`, creates a window-sized canvas and
  a buffer `camCanvas1` of exactly 720 × 576 pixels (also with
  `pixelDensity(1)`, so retina screens don't change its size), starts the
  webcam, sets 25 fps and opens the WebSocket (`binaryType = "arraybuffer"`). `onopen` sends the first frame, and every
  `ok` from the server triggers the next one — so the sketch never sends
  faster than the TV can show.
- **`sendFrame()`**: copies the top-left 720 × 576 pixels of the canvas
  into `camCanvas1`, encodes it as JPEG (quality 0.9) and sends the bytes.
  Only this area appears on the TV; if the browser window is smaller, the
  rest stays black.
- **`draw()`**: draws the webcam image at 720 × 576 and three circles that
  move at different speeds. Replace this with your own drawing.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: CRT

Streamt die Zeichenfläche eines p5-Sketches als JPEG-Frames über einen
WebSocket an einen Raspberry Pi, der sie auf einem Röhrenfernseher zeigt
(Composite-Video, PAL). Die Demo zeichnet das Webcam-Bild und darüber drei
bewegte Kreise in Rot, Grün und Blau. Ein Ausgangspunkt, um einen alten
Fernseher als Ausgabe für einen Sketch zu verwenden.

## Installation

Voraussetzungen: eine Webcam und ein Browser im selben Netzwerk wie der Pi
(siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Server

Braucht `crt-websocket` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
auf einem Raspberry Pi mit einem Röhrenfernseher am Composite-Ausgang
(PAL), Port 8100. Zuerst mit `bash run.sh` im Ordner auf dem Pi starten;
er zeigt die IP des Pi auf dem Fernseher. Er nimmt JPEG-Frames von genau
720 × 576 an und antwortet nach jedem mit `ok`. Seine Adresse oben in
`sketch.js` bei `connection` eintragen.

## Ausführen

1. Den Server auf dem Pi starten (siehe Server). Er zeigt seine IP-Adresse auf dem
   Fernseher.
2. Diese Adresse oben in `sketch.js` bei `connection` eintragen, z. B.
   `ws://10.21.14.32:8100`.
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. Den Kamerazugriff erlauben. Die Frames werden gesendet, sobald die
   Verbindung steht.

## Coding-Hilfe

- **`sketch.js` → `connection`, `crt`**: Server-Adresse und die PAL-Grösse
  720 × 576. Der Server schreibt jeden Frame direkt in einen
  720 × 576-Framebuffer, die empfangenen Frames müssen also genau so gross
  sein.
- **`setup()`**: setzt `pixelDensity(1)`, erstellt eine fenstergrosse
  Zeichenfläche und einen Buffer `camCanvas1` von genau 720 × 576 Pixeln
  (ebenfalls mit `pixelDensity(1)`, damit Retina-Bildschirme seine Grösse
  nicht verändern), startet die Webcam, setzt 25 fps und öffnet
  den WebSocket (`binaryType = "arraybuffer"`). `onopen` schickt den ersten
  Frame, und jedes `ok` vom Server löst den nächsten aus – so sendet der
  Sketch nie schneller, als der Fernseher anzeigen kann.
- **`sendFrame()`**: kopiert die oberen linken 720 × 576 Pixel der
  Zeichenfläche in `camCanvas1`, kodiert sie als JPEG (Qualität 0.9) und
  schickt die Bytes. Nur dieser Bereich erscheint auf dem Fernseher; ist
  das Browserfenster kleiner, bleibt der Rest schwarz.
- **`draw()`**: zeichnet das Webcam-Bild in 720 × 576 und drei Kreise, die
  sich unterschiedlich schnell bewegen. Hier die eigene Zeichnung einsetzen.

</div>
