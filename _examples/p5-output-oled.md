---
title: OLED
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_OLED
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_OLED
related:
- Servers_RaspberriPi
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: OLED

Streams a tiny p5 canvas as PNG frames over a WebSocket to a Raspberry Pi,
which shows them on a monochrome SSD1306 OLED display. The demo draws a
white circle moving across a black background inside a frame. A starting
point for small status displays or pixel animations driven from a sketch.

## Installation

Requirements: a browser on the same network as the Pi (see Server).

Libraries (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (included, not used).

License: MIT

## Server

Needs `oled-websockets` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
running on a Raspberry Pi with a 128 × 32 SSD1306 OLED on I2C (enable I2C
in `sudo raspi-config`), port 8200. Start it first with `bash run.sh` in
the folder on the Pi; the OLED shows IP and port. It takes PNG frames of
exactly 128 × 32 and answers `ok` after each one. Put its address in
`connection` at the top of `sketch.js`.

## How to Run

1. Start the server on the Pi (see Server). The OLED shows its IP address and port.
2. Enter that address in `connection` at the top of `sketch.js`, e.g.
   `ws://192.168.2.7:8200`.
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. The frames are sent as soon as the connection is open.

## Coding Help

- **`sketch.js` → `connection`, `crt`**: server address and canvas size
  (128 × 32). The server does not resize: the PNG must match the OLED
  (128 × 32) exactly.
- **`setup()`**: sets `pixelDensity(1)` so the canvas has exactly 128 × 32
  pixels on every screen (also Retina), creates the canvas, turns off
  smoothing with `noSmooth()`, sets 25 fps and opens the WebSocket.
  `onopen` sends the first frame, every `ok` from the server triggers the
  next one.
- **`sendFrame()`**: encodes the canvas as PNG and sends the bytes. The
  server converts them to 1 bit, so only black and white make sense.
- **`draw()`**: black background, a white circle moving left to right and
  a 1 px frame. Replace this with your own drawing.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: OLED

Streamt eine winzige p5-Zeichenfläche als PNG-Frames über einen WebSocket
an einen Raspberry Pi, der sie auf einem einfarbigen SSD1306-OLED-Display
zeigt. Die Demo zeichnet einen weissen Kreis, der sich in einem Rahmen über
den schwarzen Hintergrund bewegt. Ein Ausgangspunkt für kleine
Statusanzeigen oder Pixel-Animationen aus einem Sketch.

## Installation

Voraussetzungen: ein Browser im selben Netzwerk wie der Pi (siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Server

Braucht `oled-websockets` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
auf einem Raspberry Pi mit einem 128 × 32 SSD1306-OLED an I2C (I2C in
`sudo raspi-config` aktivieren), Port 8200. Zuerst mit `bash run.sh` im
Ordner auf dem Pi starten; das OLED zeigt IP und Port. Er nimmt PNG-Frames
von genau 128 × 32 an und antwortet nach jedem mit `ok`. Seine Adresse
oben in `sketch.js` bei `connection` eintragen.

## Ausführen

1. Den Server auf dem Pi starten (siehe Server). Das OLED zeigt IP-Adresse und Port.
2. Diese Adresse oben in `sketch.js` bei `connection` eintragen, z. B.
   `ws://192.168.2.7:8200`.
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. Die Frames werden gesendet, sobald die Verbindung steht.

## Coding-Hilfe

- **`sketch.js` → `connection`, `crt`**: Server-Adresse und Grösse der
  Zeichenfläche (128 × 32). Der Server skaliert nicht: Das PNG muss genau
  so gross wie das OLED sein (128 × 32).
- **`setup()`**: setzt `pixelDensity(1)`, damit die Zeichenfläche auf jedem
  Bildschirm (auch Retina) genau 128 × 32 Pixel hat, erstellt die
  Zeichenfläche, schaltet mit `noSmooth()` die Kantenglättung aus, setzt
  25 fps und öffnet den WebSocket. `onopen` schickt den ersten Frame, jedes `ok` vom Server löst
  den nächsten aus.
- **`sendFrame()`**: kodiert die Zeichenfläche als PNG und schickt die
  Bytes. Der Server wandelt sie in 1 Bit um, sinnvoll sind also nur
  Schwarz und Weiss.
- **`draw()`**: schwarzer Hintergrund, ein weisser Kreis, der von links
  nach rechts wandert, und ein 1-px-Rahmen. Hier die eigene Zeichnung
  einsetzen.

</div>
