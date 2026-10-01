---
title: Line Printer
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Printers_LinePrinter
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter
screenshot: "/assets/examples/p5-output-printers-lineprinter/screenshot.png"
related:
- Servers_RaspberriPi
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

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

License: MIT

## Server

Needs `lp-websockets` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(WebSocket, port 8090), running on a Raspberry Pi with an ESC/P line
printer on USB, in the same network as your computer. Start it first with
`bash run.sh` (or `node printer.js`) in its folder. It prints text, feeds
the paper and prints images, answering with `ok` (or `printed_image`). Set
`printerConnection` in `sketch.js` to its address (default
`ws://10.21.12.76:8090`).

## How to Run

1. Make sure the printer server is running (see Server).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Type into the text field and click **Print Text**. **Print Bitmap**
   prints the canvas, the arrow buttons feed the paper by the number of
   steps in the input field.

The connection status is shown on the canvas.

## Coding Help

- **`sketch.js` → `printerConnection`**: WebSocket address of the printer
  server.
- **`communicateWithPrinter()`**: sends data and returns a Promise that
  resolves when the server answers `ok` or `printed_image`. Any other
  answer (e.g. `busy`), a closed connection or a missing connection rejects
  it; the button handlers log such errors to the console with
  `printError()`.
- **`sendText(text, w, h, style)`**: sends
  `{ text, w, h, style }` as JSON. `w` 0/1 = normal/wide, `h` 0/1 =
  normal/double height, `style` `'b'` bold, `'u'` underlined, `'bu'` both.
  Not every combination works on every printer.
- **`paperFeed(direction, steps)`**: sends `{ direction, steps }` with
  `'up'` or `'down'`. One step is a micro-feed unit, often 1/203 inch.
- **`printBitmap()`**: converts the canvas to a PNG with `canvas.toBlob()`
  and sends it as binary data.
- **`setup()`**: opens the WebSocket and creates the text field
  (`textInput`) and buttons. The commented-out `sendText()` calls in the
  **Print Text** handler show the other styles.
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

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Server

Braucht `lp-websockets` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(WebSocket, Port 8090), auf einem Raspberry Pi mit einem
ESC/P-Zeilendrucker an USB, im selben Netzwerk wie dein Computer. Zuerst im
Ordner mit `bash run.sh` (oder `node printer.js`) starten. Er druckt Text,
bewegt das Papier und druckt Bilder und antwortet mit `ok` (oder
`printed_image`). In `sketch.js` `printerConnection` auf seine Adresse
setzen (Standard `ws://10.21.12.76:8090`).

## Ausführen

1. Sicherstellen, dass der Drucker-Server läuft (siehe Server).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Text ins Textfeld schreiben und auf **Print Text** klicken. **Print
   Bitmap** druckt die Zeichenfläche, die Pfeil-Knöpfe schieben das Papier
   um die Anzahl Schritte im Eingabefeld vor oder zurück.

Der Verbindungsstatus wird auf der Zeichenfläche angezeigt.

## Coding-Hilfe

- **`sketch.js` → `printerConnection`**: WebSocket-Adresse des
  Drucker-Servers.
- **`communicateWithPrinter()`**: sendet Daten und gibt ein Promise zurück,
  das erfüllt wird, wenn der Server `ok` oder `printed_image` antwortet.
  Jede andere Antwort (z.B. `busy`), eine geschlossene oder fehlende
  Verbindung lehnt es ab; die Knopf-Handler melden solche Fehler mit
  `printError()` in der Konsole.
- **`sendText(text, w, h, style)`**: sendet `{ text, w, h, style }` als
  JSON. `w` 0/1 = normal/breit, `h` 0/1 = normal/doppelt hoch, `style`
  `'b'` fett, `'u'` unterstrichen, `'bu'` beides. Nicht jede Kombination
  funktioniert auf jedem Drucker.
- **`paperFeed(direction, steps)`**: sendet `{ direction, steps }` mit
  `'up'` oder `'down'`. Ein Schritt ist eine Mikro-Vorschub-Einheit, oft
  1/203 Zoll.
- **`printBitmap()`**: wandelt die Zeichenfläche mit `canvas.toBlob()` in
  ein PNG um und sendet es als Binärdaten.
- **`setup()`**: öffnet den WebSocket und erstellt Textfeld (`textInput`)
  und Knöpfe. Die auskommentierten `sendText()`-Aufrufe im Handler von
  **Print Text** zeigen die anderen Stile.
- **`draw()`**: zeichnet ein Raster und den Verbindungsstatus – genau das
  druckt auch **Print Bitmap**.

</div>
