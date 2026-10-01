---
title: E-Ink
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_EInk
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_EInk
screenshot: "/assets/examples/p5-output-eink/screenshot.png"
related:
- Servers_RaspberriPi
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: E-Ink

Sends the canvas of a p5 sketch as a PNG over a WebSocket to a Raspberry
Pi, which shows it on a Waveshare 4.2" e-ink display in four grey levels.
Each mouse click raises a counter and sends a new frame. A starting point
for slow, paper-like displays that only update now and then.

## Installation

Requirements: a browser on the same network as the Pi (see Server).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

License: MIT

## Server

Needs `screen-websocket` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
running on a Raspberry Pi with a Waveshare 4.2" e-paper display on SPI
(enable SPI in `sudo raspi-config`), port 8765. Start it first with
`python screen.py` in the folder on the Pi (there is no `run.sh`); the
display shows its address. It takes a PNG, resizes it to 400 × 300 and
shows it in four grey levels; it sends no answer. Put its address in
`displayConnection` at the top of `sketch.js`.

## How to Run

1. Start the server on the Pi (see Server). The display shows its address.
2. Enter that address in `displayConnection` at the top of `sketch.js`,
   e.g. `ws://192.168.138.96:8765`.
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. Click into the canvas. The counter goes up and the frame is sent. An
   e-ink refresh takes a few seconds.

## Coding Help

- **`sketch.js` → `displayConnection`, `display`**: server address and
  canvas size (400 × 300, the size of the display).
- **`setup()`**: creates the canvas with `pixelDensity(1)` and
  `noSmooth()` and opens the WebSocket. Connection state and server
  messages are stored in `displayState` and shown in a text line
  (`statusLabel`) below the canvas.
- **`sendFrame()`**: encodes the canvas as PNG and sends it if the socket
  is open. The server resizes it to the display and converts it to grey
  levels.
- **`draw()`**: frame, diagonals, four grey concentric circles and the
  counter in the middle, plus an update of the status line (an HTML
  element, so it is not sent to the display). Use black, white and a few
  greys — the display shows only four levels.
- **`mousePressed()`**: raises `count` and sends the next frame. Frames
  are only sent here, not every frame; call `sendFrame()` elsewhere to
  update on other events.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: E-Ink

Schickt die Zeichenfläche eines p5-Sketches als PNG über einen WebSocket an
einen Raspberry Pi, der sie auf einem Waveshare-4.2"-E-Ink-Display in vier
Graustufen zeigt. Jeder Mausklick erhöht einen Zähler und schickt einen
neuen Frame. Ein Ausgangspunkt für langsame, papierartige Anzeigen, die
sich nur ab und zu ändern.

## Installation

Voraussetzungen: ein Browser im selben Netzwerk wie der Pi (siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Server

Braucht `screen-websocket` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
auf einem Raspberry Pi mit einem Waveshare-4.2"-E-Paper-Display an SPI
(SPI in `sudo raspi-config` aktivieren), Port 8765. Zuerst mit
`python screen.py` im Ordner auf dem Pi starten (es gibt kein `run.sh`);
das Display zeigt seine Adresse. Er nimmt ein PNG an, skaliert es auf
400 × 300 und zeigt es in vier Graustufen; er schickt keine Antwort. Seine
Adresse oben in `sketch.js` bei `displayConnection` eintragen.

## Ausführen

1. Den Server auf dem Pi starten (siehe Server). Das Display zeigt seine Adresse.
2. Diese Adresse oben in `sketch.js` bei `displayConnection` eintragen,
   z. B. `ws://192.168.138.96:8765`.
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. In die Zeichenfläche klicken. Der Zähler steigt und der Frame wird
   gesendet. Ein E-Ink-Refresh dauert einige Sekunden.

## Coding-Hilfe

- **`sketch.js` → `displayConnection`, `display`**: Server-Adresse und
  Grösse der Zeichenfläche (400 × 300, die Grösse des Displays).
- **`setup()`**: erstellt die Zeichenfläche mit `pixelDensity(1)` und
  `noSmooth()` und öffnet den WebSocket. Verbindungsstatus und
  Server-Nachrichten landen in `displayState` und werden in einer
  Textzeile (`statusLabel`) unter der Zeichenfläche angezeigt.
- **`sendFrame()`**: kodiert die Zeichenfläche als PNG und schickt sie, wenn
  der Socket offen ist. Der Server skaliert sie aufs Display und wandelt sie
  in Graustufen um.
- **`draw()`**: Rahmen, Diagonalen, vier graue konzentrische Kreise und der
  Zähler in der Mitte, dazu wird die Statuszeile aktualisiert (ein
  HTML-Element, sie wird also nicht ans Display geschickt). Schwarz, Weiss
  und wenige Grautöne verwenden – das Display zeigt nur vier Stufen.
- **`mousePressed()`**: erhöht `count` und schickt den nächsten Frame.
  Frames werden nur hier gesendet, nicht in jedem Frame; `sendFrame()`
  anderswo aufrufen, um bei anderen Ereignissen zu aktualisieren.

</div>
