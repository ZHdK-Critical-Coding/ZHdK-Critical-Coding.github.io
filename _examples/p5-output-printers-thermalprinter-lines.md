---
title: Thermal Printer Lines
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Printers_ThermalPrinter_Lines
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines
screenshot: "/assets/examples/p5-output-printers-thermalprinter-lines/screenshot.png"
related:
- Servers_RaspberriPi
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Thermal Printer Lines

Sends text from a text field to a thermal printer server over WebSocket.
One click prints the text four times in different sizes and styles and
then cuts the paper. Each command waits for the server's `ok` before the
next one is sent. A starting point for printing text output on a receipt
printer.

## Installation

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

License: MIT

## Server

Needs `printer-websockets` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(WebSocket, port 8080), running on a Raspberry Pi with an ESC/POS thermal
printer on USB, in the same network as your computer. Start it first with
`bash run.sh` (or `node printer.js`) in its folder. It prints JSON text
commands and images and answers with `ok`. Set `printerConnection` in
`sketch.js` to its address (default `ws://10.21.8.225:8080`).

## How to Run

1. Make sure the printer server is running (see Server).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Type into the text field and click **Print**.

The connection status is shown on the canvas.

## Coding Help

- **`sketch.js` → config at the top**: `printerConnection` is the server
  address. `printerWidth` only sets the size of the status canvas.
- **`sendText(text, w, h, style, cut)`**: sends
  `{ text, w, h, style, cut }` as JSON and returns a Promise that resolves
  on `ok` and rejects on any other answer. `w` 0/1 = normal/wide, `h` 0/1 =
  normal/double height, `style` `'b'` bold, `'u'` underlined, `'bu'` both,
  `cut` true cuts the paper after printing.
- **`setup()`**: opens the WebSocket and creates the text field and the
  **Print** button. The button handler calls `sendText()` four times in a
  row with `await` – change these calls to set your own layout.
- **`draw()`**: shows the connection status on the canvas.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Thermal Printer Lines

Schickt Text aus einem Textfeld per WebSocket an einen
Thermodrucker-Server. Ein Klick druckt den Text viermal in verschiedenen
Grössen und Stilen und schneidet dann das Papier ab. Jeder Befehl wartet
auf das `ok` des Servers, bevor der nächste gesendet wird. Ein
Ausgangspunkt, um Text auf einem Bondrucker auszugeben.

## Installation

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Server

Braucht `printer-websockets` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(WebSocket, Port 8080), auf einem Raspberry Pi mit einem
ESC/POS-Thermodrucker an USB, im selben Netzwerk wie dein Computer. Zuerst
im Ordner mit `bash run.sh` (oder `node printer.js`) starten. Er druckt
JSON-Textbefehle und Bilder und antwortet mit `ok`. In `sketch.js`
`printerConnection` auf seine Adresse setzen (Standard
`ws://10.21.8.225:8080`).

## Ausführen

1. Sicherstellen, dass der Drucker-Server läuft (siehe Server).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Text ins Textfeld schreiben und auf **Print** klicken.

Der Verbindungsstatus wird auf der Zeichenfläche angezeigt.

## Coding-Hilfe

- **`sketch.js` → Konfiguration oben**: `printerConnection` ist die Adresse
  des Servers. `printerWidth` bestimmt nur die Grösse der
  Status-Zeichenfläche.
- **`sendText(text, w, h, style, cut)`**: sendet
  `{ text, w, h, style, cut }` als JSON und gibt ein Promise zurück, das
  bei `ok` erfüllt wird und bei jeder anderen Antwort scheitert. `w` 0/1 =
  normal/breit, `h` 0/1 = normal/doppelt hoch, `style` `'b'` fett, `'u'`
  unterstrichen, `'bu'` beides, `cut` true schneidet das Papier nach dem
  Druck ab.
- **`setup()`**: öffnet den WebSocket und erstellt Textfeld und
  **Print**-Knopf. Der Handler des Knopfs ruft `sendText()` viermal
  nacheinander mit `await` auf – diese Aufrufe für ein eigenes Layout
  anpassen.
- **`draw()`**: zeigt den Verbindungsstatus auf der Zeichenfläche an.

</div>
