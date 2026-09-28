---
title: LED Matrix
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_LED
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_LED
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: LED Matrix

Draws a scrolling text over coloured blocks and sends every frame to an LED
matrix server over ZeroMQ via WebSocket. The canvas matches the size of a
chain of LED panels (by default 4 × 64×32 pixels). A starting point for
showing your own p5 graphics on an LED wall.

## Installation

Requirements: an LED matrix server that accepts raw RGBA frames over a ZMQ
REQ/REP WebSocket connection, reachable from your computer's network.

1. Make sure the LED matrix server is running.
2. Set `ledConnection` in `sketch.js` to the server address (default
   `ws://10.21.22.238:42069`) and adjust `matrix` to your panel setup.
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).

The text scrolls in the browser and on the matrix at the same time.

Libraries (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (included, not
used), `zeromq.bundle.js` (browser build of jszmq, exposes `window.zmq`).
Font: `font/pixelmix.ttf`.

License: MIT

## Coding Help

- **`sketch.js` → config at the top**: `ledConnection` is the server
  address, `matrix` holds the size of one panel (`width`, `height`) and the
  number of chained panels (`chain`). `lauftext` is the scrolling text.
- **`preload()`**: loads the pixel font, creates a ZMQ `Req` socket and
  connects to the server. Each reply from the server triggers the next
  `sendFrame()` – so frames are only sent as fast as the server accepts
  them.
- **`sendFrame()`**: reads the canvas pixels with
  `drawingContext.getImageData()` and sends the raw RGBA buffer. The canvas
  must have exactly the size of the matrix, hence `pixelDensity(1)`.
- **`setup()`**: sizes the canvas to `matrix.width * matrix.chain` ×
  `matrix.height`, turns off smoothing and sends the first frame.
- **`draw()`**: fills one rectangle per panel with a colour from
  `paletteLerp()` that shifts over time, then draws the text twice side by
  side and moves `offset` to get an endless scroll. Replace this part with
  your own drawing. Note: the rectangle width is `width / 4`, which only
  matches a chain of 4 – use `matrix.width` for other setups.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: LED Matrix

Zeichnet einen Lauftext über farbige Blöcke und schickt jeden Frame über
ZeroMQ per WebSocket an einen LED-Matrix-Server. Die Zeichenfläche
entspricht der Grösse einer Kette von LED-Panels (standardmässig 4 × 64×32
Pixel). Ein Ausgangspunkt, um eigene p5-Grafiken auf einer LED-Wand zu
zeigen.

## Installation

Voraussetzungen: ein LED-Matrix-Server, der rohe RGBA-Frames über eine ZMQ
REQ/REP-WebSocket-Verbindung annimmt und im Netzwerk deines Computers
erreichbar ist.

1. Sicherstellen, dass der LED-Matrix-Server läuft.
2. In `sketch.js` `ledConnection` auf die Adresse des Servers setzen
   (Standard `ws://10.21.22.238:42069`) und `matrix` an die eigenen Panels
   anpassen.
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).

Der Text läuft gleichzeitig im Browser und auf der Matrix.

Bibliotheken (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (eingebunden,
nicht verwendet), `zeromq.bundle.js` (Browser-Build von jszmq, stellt
`window.zmq` bereit). Schrift: `font/pixelmix.ttf`.

Lizenz: MIT

## Coding-Hilfe

- **`sketch.js` → Konfiguration oben**: `ledConnection` ist die Adresse des
  Servers, `matrix` enthält die Grösse eines Panels (`width`, `height`) und
  die Anzahl verketteter Panels (`chain`). `lauftext` ist der Lauftext.
- **`preload()`**: lädt die Pixelschrift, erstellt einen ZMQ-`Req`-Socket
  und verbindet sich mit dem Server. Jede Antwort des Servers löst das
  nächste `sendFrame()` aus – Frames werden also nur so schnell gesendet,
  wie der Server sie annimmt.
- **`sendFrame()`**: liest die Pixel der Zeichenfläche mit
  `drawingContext.getImageData()` und sendet den rohen RGBA-Buffer. Die
  Zeichenfläche muss genau so gross sein wie die Matrix, deshalb
  `pixelDensity(1)`.
- **`setup()`**: setzt die Grösse der Zeichenfläche auf
  `matrix.width * matrix.chain` × `matrix.height`, schaltet die
  Kantenglättung aus und sendet den ersten Frame.
- **`draw()`**: füllt pro Panel ein Rechteck mit einer Farbe aus
  `paletteLerp()`, die sich mit der Zeit verschiebt, zeichnet dann den Text
  zweimal nebeneinander und verschiebt `offset` für einen endlosen Lauf.
  Diesen Teil durch eigene Zeichnungen ersetzen. Hinweis: Die Breite der
  Rechtecke ist `width / 4` und passt nur zu einer Kette von 4 – für andere
  Setups `matrix.width` verwenden.

</div>
