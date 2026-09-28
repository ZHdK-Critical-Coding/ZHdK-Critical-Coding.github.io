---
title: Thermal Printer Bitmap
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Printers_ThermalPrinter_Bitmap
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Thermal Printer Bitmap

Draws a square graphic (frame, diagonals, circles and a letter of "ZHDK")
and sends it as a PNG to a thermal printer server over WebSocket on every
mouse click. After each print the paper is cut. A starting point for
printing your own p5 drawings on a receipt printer.

## Installation

Requirements: a thermal printer server that accepts PNG data over
WebSocket and answers with `ok`, reachable from your computer's network.

1. Make sure the printer server is running.
2. Set `printerConnection` in `sketch.js` to the server address (default
   `ws://10.21.3.49:8080`).
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. Click on the canvas to print the next frame.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

License: MIT

## Coding Help

- **`sketch.js` → config at the top**: `printerConnection` is the server
  address, `printerWidth` the width and height of the canvas in pixels
  (512). Match it to the print width of your printer.
- **`sendFrame(cut)`**: converts the canvas to a PNG with `canvas.toBlob()`
  and sends it as binary data. When the server answers `ok`, it sends `cut`
  if `cut` is true; any other answer rejects the Promise.
- **`setup()`**: creates the canvas with `pixelDensity(1)` and
  `noSmooth()` so one canvas pixel is one printer dot, and opens the
  WebSocket. The connection status goes to an undeclared `displayState`
  and is not shown anywhere.
- **`draw()`**: draws the graphic in black on white. Replace this part with
  your own drawing – thermal printers only print black and white.
- **`mousePressed()`**: moves on to the next letter and calls
  `sendFrame(true)` after 100 ms, so the new letter is already drawn.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Thermal Printer Bitmap

Zeichnet eine quadratische Grafik (Rahmen, Diagonalen, Kreise und ein
Buchstabe aus "ZHDK") und schickt sie bei jedem Mausklick als PNG per
WebSocket an einen Thermodrucker-Server. Nach jedem Druck wird das Papier
abgeschnitten. Ein Ausgangspunkt, um eigene p5-Zeichnungen auf einem
Bondrucker auszugeben.

## Installation

Voraussetzungen: ein Thermodrucker-Server, der PNG-Daten per WebSocket
annimmt, mit `ok` antwortet und im Netzwerk deines Computers erreichbar
ist.

1. Sicherstellen, dass der Drucker-Server läuft.
2. In `sketch.js` `printerConnection` auf die Adresse des Servers setzen
   (Standard `ws://10.21.3.49:8080`).
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. Auf die Zeichenfläche klicken, um den nächsten Frame zu drucken.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Coding-Hilfe

- **`sketch.js` → Konfiguration oben**: `printerConnection` ist die Adresse
  des Servers, `printerWidth` Breite und Höhe der Zeichenfläche in Pixeln
  (512). An die Druckbreite des eigenen Druckers anpassen.
- **`sendFrame(cut)`**: wandelt die Zeichenfläche mit `canvas.toBlob()` in
  ein PNG um und sendet es als Binärdaten. Antwortet der Server `ok`, wird
  `cut` gesendet, falls `cut` wahr ist; jede andere Antwort lässt das
  Promise scheitern.
- **`setup()`**: erstellt die Zeichenfläche mit `pixelDensity(1)` und
  `noSmooth()`, damit ein Canvas-Pixel einem Druckerpunkt entspricht, und
  öffnet den WebSocket. Der Verbindungsstatus landet in einer nicht
  deklarierten Variable `displayState` und wird nirgends angezeigt.
- **`draw()`**: zeichnet die Grafik schwarz auf weiss. Diesen Teil durch
  eigene Zeichnungen ersetzen – Thermodrucker drucken nur schwarz-weiss.
- **`mousePressed()`**: wechselt zum nächsten Buchstaben und ruft nach
  100 ms `sendFrame(true)` auf, damit der neue Buchstabe schon gezeichnet
  ist.

</div>
