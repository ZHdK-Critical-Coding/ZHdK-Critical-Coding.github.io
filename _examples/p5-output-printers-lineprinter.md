---
title: Line Printer
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Printers_LinePrinter
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Line Printer

Sends text, paper-feed commands and the canvas as a bitmap to a printer
server over WebSocket. Text can be printed bold, underlined, wide or double
height. A starting point for printing from a sketch, line by line.

## Installation

Requirements: a printer server that accepts WebSocket connections and
answers with `ok` (or `printed_image`), reachable from your computer's
network.

1. Make sure the printer server is running.
2. Set `printerConnection` in `sketch.js` to the server address (default
   `ws://10.21.12.76:8090`).
3. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
4. Type into the text field and click **Print Text**. **Print Bitmap**
   prints the canvas, the arrow buttons feed the paper by the number of
   steps in the input field.

The connection status is shown on the canvas.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

License: MIT

## Coding Help

- **`sketch.js` → `printerConnection`**: WebSocket address of the printer
  server.
- **`communicateWithPrinter()`**: sends data and returns a Promise that
  resolves when the server answers `ok` or `printed_image`. Other answers
  are ignored, so the Promise then never resolves.
- **`sendText(text, w, h, style)`**: sends
  `{ text, w, h, style }` as JSON. `w` 0/1 = normal/wide, `h` 0/1 =
  normal/double height, `style` `'b'` bold, `'u'` underlined, `'bu'` both.
  Not every combination works on every printer.
- **`paperFeed(direction, steps)`**: sends `{ direction, steps }` with
  `'up'` or `'down'`. One step is a micro-feed unit, often 1/203 inch.
- **`printBitmap()`**: converts the canvas to a PNG with `canvas.toBlob()`
  and sends it as binary data.
- **`setup()`**: opens the WebSocket and creates the text field and
  buttons. The commented-out `sendText()` calls in the **Print Text**
  handler show the other styles.
- **`draw()`**: draws a grid and the connection status – this is also what
  **Print Bitmap** prints.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Line Printer

Schickt Text, Papiervorschub-Befehle und die Zeichenfläche als Bitmap per
WebSocket an einen Drucker-Server. Text kann fett, unterstrichen, breit
oder doppelt hoch gedruckt werden. Ein Ausgangspunkt, um aus einem Sketch
Zeile für Zeile zu drucken.

## Installation

Voraussetzungen: ein Drucker-Server, der WebSocket-Verbindungen annimmt und
mit `ok` (oder `printed_image`) antwortet und im Netzwerk deines Computers
erreichbar ist.

1. Sicherstellen, dass der Drucker-Server läuft.
2. In `sketch.js` `printerConnection` auf die Adresse des Servers setzen
   (Standard `ws://10.21.12.76:8090`).
3. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
4. Text ins Textfeld schreiben und auf **Print Text** klicken. **Print
   Bitmap** druckt die Zeichenfläche, die Pfeil-Knöpfe schieben das Papier
   um die Anzahl Schritte im Eingabefeld vor oder zurück.

Der Verbindungsstatus wird auf der Zeichenfläche angezeigt.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Coding-Hilfe

- **`sketch.js` → `printerConnection`**: WebSocket-Adresse des
  Drucker-Servers.
- **`communicateWithPrinter()`**: sendet Daten und gibt ein Promise zurück,
  das erfüllt wird, wenn der Server `ok` oder `printed_image` antwortet.
  Andere Antworten werden ignoriert – das Promise wird dann nie erfüllt.
- **`sendText(text, w, h, style)`**: sendet `{ text, w, h, style }` als
  JSON. `w` 0/1 = normal/breit, `h` 0/1 = normal/doppelt hoch, `style`
  `'b'` fett, `'u'` unterstrichen, `'bu'` beides. Nicht jede Kombination
  funktioniert auf jedem Drucker.
- **`paperFeed(direction, steps)`**: sendet `{ direction, steps }` mit
  `'up'` oder `'down'`. Ein Schritt ist eine Mikro-Vorschub-Einheit, oft
  1/203 Zoll.
- **`printBitmap()`**: wandelt die Zeichenfläche mit `canvas.toBlob()` in
  ein PNG um und sendet es als Binärdaten.
- **`setup()`**: öffnet den WebSocket und erstellt Textfeld und Knöpfe. Die
  auskommentierten `sendText()`-Aufrufe im Handler von **Print Text** zeigen
  die anderen Stile.
- **`draw()`**: zeichnet ein Raster und den Verbindungsstatus – genau das
  druckt auch **Print Bitmap**.

</div>
