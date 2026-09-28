---
title: CRT
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_CRT
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_CRT
related: []
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

Requirements: a Raspberry Pi with a CRT on its composite output running
`crt-websocket` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(port 8100), a webcam and a browser on the same network.

1. Start the server on the Pi. It shows its IP address on the TV.
2. Enter that address in `connection` at the top of `sketch.js`, e.g.
   `ws://10.21.14.32:8100`.
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. Allow camera access. The frames are sent as soon as the connection is
   open.

Libraries (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (included, not used).

License: MIT

## Coding Help

- **`sketch.js` → `connection`, `crt`**: server address and the PAL size
  720 × 576. The server writes each frame directly into a 720 × 576
  framebuffer, so the frames it receives must have exactly that size.
- **`setup()`**: creates a window-sized canvas and a half-size buffer
  `camCanvas1`, starts the webcam, sets 25 fps and opens the WebSocket
  (`binaryType = "arraybuffer"`). `onopen` sends the first frame, and every
  `ok` from the server triggers the next one — so the sketch never sends
  faster than the TV can show.
- **`sendFrame()`**: copies the top-left part of the canvas into
  `camCanvas1`, encodes it as JPEG (quality 0.9) and sends the bytes.
  Because `pixelDensity(1)` is only set after the buffer is created, the
  real pixel size of the buffer depends on the screen's pixel density —
  check it if the TV stays dark.
- **`draw()`**: draws the webcam image at 360 × 288 and three circles that
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

Voraussetzungen: ein Raspberry Pi mit einem CRT am Composite-Ausgang, auf
dem `crt-websocket` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
läuft (Port 8100), eine Webcam und ein Browser im selben Netzwerk.

1. Den Server auf dem Pi starten. Er zeigt seine IP-Adresse auf dem
   Fernseher.
2. Diese Adresse oben in `sketch.js` bei `connection` eintragen, z. B.
   `ws://10.21.14.32:8100`.
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. Den Kamerazugriff erlauben. Die Frames werden gesendet, sobald die
   Verbindung steht.

Bibliotheken (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Coding-Hilfe

- **`sketch.js` → `connection`, `crt`**: Server-Adresse und die PAL-Grösse
  720 × 576. Der Server schreibt jeden Frame direkt in einen
  720 × 576-Framebuffer, die empfangenen Frames müssen also genau so gross
  sein.
- **`setup()`**: erstellt eine fenstergrosse Zeichenfläche und einen halb so
  grossen Buffer `camCanvas1`, startet die Webcam, setzt 25 fps und öffnet
  den WebSocket (`binaryType = "arraybuffer"`). `onopen` schickt den ersten
  Frame, und jedes `ok` vom Server löst den nächsten aus – so sendet der
  Sketch nie schneller, als der Fernseher anzeigen kann.
- **`sendFrame()`**: kopiert den oberen linken Teil der Zeichenfläche in
  `camCanvas1`, kodiert ihn als JPEG (Qualität 0.9) und schickt die Bytes.
  Weil `pixelDensity(1)` erst nach dem Buffer gesetzt wird, hängt die
  echte Pixelgrösse des Buffers von der Pixeldichte des Bildschirms ab –
  das prüfen, wenn der Fernseher dunkel bleibt.
- **`draw()`**: zeichnet das Webcam-Bild in 360 × 288 und drei Kreise, die
  sich unterschiedlich schnell bewegen. Hier die eigene Zeichnung einsetzen.

</div>
