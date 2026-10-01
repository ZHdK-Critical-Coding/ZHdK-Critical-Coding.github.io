---
title: LED Matrix
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_LED
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_LED
screenshot: "/assets/examples/p5-output-led/screenshot.png"
related:
- Servers_RaspberriPi
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

Requirements: a browser on the same network as the Pi (see Server).

Libraries (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (included, not
used), `zeromq.bundle.js` (browser build of jszmq, exposes `window.zmq`).
Font: `font/pixelmix.ttf`.

License: MIT

## Server

Needs `led` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
running on a Raspberry Pi with a chain of four 64 × 32 LED panels, port
42069. It starts the external `led-matrix-zmq-server`, which must be built
on the Pi first. Start it with `bash run_zmq_server.sh` on the Pi. It takes
raw RGBA frames over a ZMQ REQ/REP WebSocket connection and replies after
each one. Put its address in `ledConnection` at the top of `sketch.js`
(default `ws://10.21.22.238:42069`) and adjust `matrix` to your panels.

## How to Run

1. Make sure the LED matrix server is running (see Server).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).

The text scrolls in the browser and on the matrix at the same time.

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
  your own drawing. The rectangle width is `width / matrix.chain`, so it
  adapts to the number of chained panels.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: LED Matrix

Zeichnet einen Lauftext über farbige Blöcke und schickt jeden Frame über
ZeroMQ per WebSocket an einen LED-Matrix-Server. Die Zeichenfläche
entspricht der Grösse einer Kette von LED-Panels (standardmässig 4 × 64×32
Pixel). Ein Ausgangspunkt, um eigene p5-Grafiken auf einer LED-Wand zu
zeigen.

## Installation

Voraussetzungen: ein Browser im selben Netzwerk wie der Pi (siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (eingebunden,
nicht verwendet), `zeromq.bundle.js` (Browser-Build von jszmq, stellt
`window.zmq` bereit). Schrift: `font/pixelmix.ttf`.

Lizenz: MIT

## Server

Braucht `led` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
auf einem Raspberry Pi mit einer Kette von vier 64 × 32-LED-Panels, Port
42069. Er startet den externen `led-matrix-zmq-server`, der zuerst auf dem
Pi gebaut werden muss. Mit `bash run_zmq_server.sh` auf dem Pi starten. Er
nimmt rohe RGBA-Frames über eine ZMQ-REQ/REP-WebSocket-Verbindung an und
antwortet nach jedem. Seine Adresse oben in `sketch.js` bei `ledConnection`
eintragen (Standard `ws://10.21.22.238:42069`) und `matrix` an die eigenen
Panels anpassen.

## Ausführen

1. Sicherstellen, dass der LED-Matrix-Server läuft (siehe Server).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).

Der Text läuft gleichzeitig im Browser und auf der Matrix.

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
  Diesen Teil durch eigene Zeichnungen ersetzen. Die Breite der Rechtecke
  ist `width / matrix.chain` und passt sich so der Anzahl verketteter Panels
  an.

</div>
