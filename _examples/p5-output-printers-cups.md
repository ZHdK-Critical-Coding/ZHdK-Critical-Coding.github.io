---
title: CUPS Printer
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-10-20
repo: P5_Output_Printers_CUPS
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_CUPS
screenshot: "/assets/examples/p5-output-printers-cups/screenshot.png"
related:
- Servers_Printer
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: CUPS Printer

Draws a generative graphic in A4 proportions and prints it on a normal
office or inkjet printer with every click: the canvas is sent as a PNG to
the Printer Server, which places it on a page and passes it to the printer.
A starting point for printing posters, flyers or series from a sketch.

## Installation

Libraries (in `libraries/`): p5.js 1.10.0.

License: MIT

## Server

Needs the macOS app **Printer Server** from
[Servers_Printer](https://github.com/ZHdK-Critical-Coding/Servers_Printer)
(download it under *Releases*). It runs on the Mac the printer is set up on
(*System Settings → Printers*) and accepts images on port 8070. In the app,
set the printer's mode to **CUPS image** and check it. It answers every
image with `ok` once the job is handed to the printer, `busy` while the
previous job is still being handed over, or `error: …`.

If the server runs on the same Mac, the default address in `sketch.js` works
(`ws://localhost:8070`). Otherwise put the address shown in the app into
`printerConnection`. If port 8070 is taken, the app uses the next free port
and shows it.

## How to Run

1. Start Printer Server and check a printer in **CUPS image** mode (see
   Server).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Click on the canvas: the graphic is printed and a new one is drawn.

The connection status is shown below the canvas.

## Coding Help

- **`sketch.js` → `printerConnection`**: WebSocket address of the Printer
  Server.
- **`sketch.js` → `pageOptions`**: page options, sent once after
  connecting. `media` (`'A3'`, `'A4'`, `'A5'`, `'A6'`, `'Letter'`,
  `'Legal'`), `orientation` (`'auto'` follows the image, `'portrait'`,
  `'landscape'`), `fit` (fill the page inside the margin, or with `false`
  print at `dpi`), `margin` in mm, `copies`, `dither` (black and white dots
  like on the line printer). All fields are optional.
- **`communicateWithPrinter()`**: sends data and returns a Promise that
  resolves when the server answers `ok`. Any other answer or a closed
  connection rejects it.
- **`printCanvas()`**: converts the canvas to a PNG with `canvas.toBlob()`
  and sends it as binary data.
- **`setup()`**: creates the canvas in A4 proportions (420 × 594) with
  `pixelDensity(3)`, so the PNG has 1260 × 1782 pixels and prints sharply.
  Opens the WebSocket and sends `pageOptions` when it is connected.
- **`draw()`**: draws the graphic from the random seed `seed`, so it stays
  the same until it is printed. Replace this part with your own drawing.
- **`mousePressed()`**: prints on a click inside the canvas and then
  increases `seed` for the next graphic.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: CUPS Printer

Zeichnet eine generative Grafik im A4-Format und druckt sie bei jedem
Klick auf einem normalen Büro- oder Tintenstrahldrucker: Die Zeichenfläche
geht als PNG an den Printer Server, der sie auf eine Seite setzt und an den
Drucker weitergibt. Ein Ausgangspunkt, um Plakate, Flyer oder Serien aus
einem Sketch zu drucken.

## Installation

Bibliotheken (in `libraries/`): p5.js 1.10.0.

Lizenz: MIT

## Server

Braucht die macOS-App **Printer Server** aus
[Servers_Printer](https://github.com/ZHdK-Critical-Coding/Servers_Printer)
(Download unter *Releases*). Sie läuft auf dem Mac, auf dem der Drucker
eingerichtet ist (*Systemeinstellungen → Drucker*), und nimmt Bilder auf
Port 8070 entgegen. In der App den Modus des Druckers auf **CUPS image**
stellen und ihn anhaken. Sie antwortet auf jedes Bild mit `ok`, sobald der
Auftrag beim Drucker ist, mit `busy`, solange der vorherige Auftrag noch
übergeben wird, oder mit `error: …`.

Läuft der Server auf demselben Mac, funktioniert die Standardadresse in
`sketch.js` (`ws://localhost:8070`). Sonst die in der App angezeigte
Adresse in `printerConnection` eintragen. Ist Port 8070 belegt, nimmt die
App den nächsten freien Port und zeigt ihn an.

## Ausführen

1. Printer Server starten und einen Drucker im Modus **CUPS image**
   anhaken (siehe Server).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Auf die Zeichenfläche klicken: Die Grafik wird gedruckt und eine neue
   gezeichnet.

Der Verbindungsstatus steht unter der Zeichenfläche.

## Coding-Hilfe

- **`sketch.js` → `printerConnection`**: WebSocket-Adresse des Printer
  Servers.
- **`sketch.js` → `pageOptions`**: Seitenoptionen, einmal nach dem
  Verbinden gesendet. `media` (`'A3'`, `'A4'`, `'A5'`, `'A6'`, `'Letter'`,
  `'Legal'`), `orientation` (`'auto'` wie das Bild, `'portrait'`,
  `'landscape'`), `fit` (Seite innerhalb des Rands füllen, oder mit
  `false` in der Grösse aus `dpi` drucken), `margin` in mm, `copies`,
  `dither` (schwarz-weisse Punkte wie beim Nadeldrucker). Alle Felder sind
  optional.
- **`communicateWithPrinter()`**: sendet Daten und gibt ein Promise zurück,
  das erfüllt wird, wenn der Server `ok` antwortet. Jede andere Antwort
  oder eine geschlossene Verbindung lehnt es ab.
- **`printCanvas()`**: wandelt die Zeichenfläche mit `canvas.toBlob()` in
  ein PNG um und sendet es als Binärdaten.
- **`setup()`**: erstellt die Zeichenfläche im A4-Format (420 × 594) mit
  `pixelDensity(3)`, damit das PNG 1260 × 1782 Pixel hat und scharf
  gedruckt wird. Öffnet den WebSocket und sendet `pageOptions`, sobald er
  verbunden ist.
- **`draw()`**: zeichnet die Grafik aus der Zufallszahl `seed`, damit sie
  gleich bleibt, bis sie gedruckt wird. Diesen Teil durch eine eigene
  Zeichnung ersetzen.
- **`mousePressed()`**: druckt bei einem Klick in die Zeichenfläche und
  erhöht danach `seed` für die nächste Grafik.

</div>
