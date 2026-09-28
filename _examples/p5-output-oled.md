---
title: OLED
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_OLED
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_OLED
related: []
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

Requirements: a Raspberry Pi with a 128 × 32 SSD1306 OLED on I2C running
`oled-websockets` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(port 8200), and a browser on the same network.

1. Start the server on the Pi. The OLED shows its IP address and port.
2. Enter that address in `connection` at the top of `sketch.js`, e.g.
   `ws://192.168.2.7:8200`.
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. The frames are sent as soon as the connection is open.

Libraries (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (included, not used).

License: MIT

## Coding Help

- **`sketch.js` → `connection`, `crt`**: server address and canvas size
  (64 × 16). The server does not resize: the PNG must match the OLED
  (128 × 32). The canvas is exported at the screen's pixel density, so on
  a Retina screen 64 × 16 becomes 128 × 32. On other screens, set the size
  to 128 × 32.
- **`setup()`**: creates the canvas, sets 25 fps and opens the WebSocket.
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

Voraussetzungen: ein Raspberry Pi mit einem 128 × 32 SSD1306-OLED an I2C,
auf dem `oled-websockets` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
läuft (Port 8200), und ein Browser im selben Netzwerk.

1. Den Server auf dem Pi starten. Das OLED zeigt IP-Adresse und Port.
2. Diese Adresse oben in `sketch.js` bei `connection` eintragen, z. B.
   `ws://192.168.2.7:8200`.
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. Die Frames werden gesendet, sobald die Verbindung steht.

Bibliotheken (in `libraries/`): p5.js 1.11.10, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Coding-Hilfe

- **`sketch.js` → `connection`, `crt`**: Server-Adresse und Grösse der
  Zeichenfläche (64 × 16). Der Server skaliert nicht: Das PNG muss so gross
  wie das OLED sein (128 × 32). Die Zeichenfläche wird in der Pixeldichte
  des Bildschirms exportiert, auf einem Retina-Bildschirm wird 64 × 16 also
  zu 128 × 32. Auf anderen Bildschirmen die Grösse auf 128 × 32 setzen.
- **`setup()`**: erstellt die Zeichenfläche, setzt 25 fps und öffnet den
  WebSocket. `onopen` schickt den ersten Frame, jedes `ok` vom Server löst
  den nächsten aus.
- **`sendFrame()`**: kodiert die Zeichenfläche als PNG und schickt die
  Bytes. Der Server wandelt sie in 1 Bit um, sinnvoll sind also nur
  Schwarz und Weiss.
- **`draw()`**: schwarzer Hintergrund, ein weisser Kreis, der von links
  nach rechts wandert, und ein 1-px-Rahmen. Hier die eigene Zeichnung
  einsetzen.

</div>
