---
title: Printers
category: output
technology: Electron
author: Urs Hofer
date: 2026-09-17
repo: Electron_P5_Printers
repo_url: https://github.com/ZHdK-Critical-Coding/Electron_P5_Printers
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Electron: Printers

A p5.js sketch in an [Electron](https://www.electronjs.org/) app that prints
text and images directly on an Epson dot matrix printer (line printer) and
an Epson TM thermal printer. Unlike the browser examples, no Raspberry Pi or
WebSocket server is needed: the printers are plugged into the computer
running the app. Based on
[Electron_P5_Starter](https://github.com/ZHdK-Critical-Coding/Electron_P5_Starter).

## Installation

Requirements: [Node.js](https://nodejs.org/) (LTS), Visual Studio Code, an
Epson ESC/P dot matrix printer and/or an Epson TM thermal printer (ESC/POS)
connected via USB. Without printers, the app runs in simulation mode.

The browser versions
([P5_Output_Printers_LinePrinter](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter),
[P5_Output_Printers_ThermalPrinter_Lines](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines),
[P5_Output_Printers_ThermalPrinter_Bitmap](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap))
need a Raspberry Pi running
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi).
This app does the same image conversion (scaling, dithering) itself, so
nothing else has to be installed.

1. Open the folder in Visual Studio Code and install the dependencies (only
   needed once):
   ```sh
   npm install
   ```
2. Plug in the printers and check that they are found:
   ```sh
   npm run list-printers
   ```
3. Start the develop mode:
   ```sh
   npm run dev
   ```

The example sketch shows the connection status of both printers, a graphic
to print (click it to change the letter) and a panel with buttons for all
modes.

Dependencies (`package.json`): Electron 44, electron-builder 26, `usb`
(libusb access), `iconv-lite` (text encoding). Libraries in
`sketch/libraries/`: p5.js 1.10.0, p5.sound 1.0.1 (included, not used),
`printers.js` (printer functions for the sketch).

### Without a Printer: Simulation

```sh
npm run dev:simulate
```

Every job is saved to `simulated-output/` instead of being printed: the raw
printer bytes (`.bin`) and, for images, a `.png` showing exactly the dots
the printer would print. A built app started with `--simulate` saves the
jobs to `Documents/simulated-output/`.

### Printer Connection

`printers/config.js` defines how each printer is connected. The printers
are told apart by their USB ids: the thermal printer has `0x04b8:0x0e02`,
the line printer has no ids and uses the first other printer. With more
printers connected, enter the ids shown by `npm run list-printers`.

| Connection | Where | How |
| --- | --- | --- |
| `{ type: 'file', vendorId, productId }` | Linux (default) | Writes to the device file of the Linux printer driver: `/dev/usb/lp0`, `/dev/usb/lp1`, … for USB, `/dev/lp0`, … for the parallel port. The right file is found by the USB ids, so the plug-in order does not matter. |
| `{ type: 'file', path: '/dev/usb/lp0' }` | Linux | Always this file. `path` can be a list, the first existing file is used. |
| `{ type: 'usb', vendorId, productId }` | macOS, Windows (default), Linux | Talks to the printer directly over USB (libusb). |
| `{ type: 'cups', queue: 'EPSON_TM_T88V' }` | macOS, Linux | Sends the jobs unchanged ("raw") to a CUPS printer queue. |

- **Linux / Raspberry Pi:** the device files belong to the group `lp`. Add
  your user once, then log out and in again:
  `sudo usermod -aG lp $USER`. Parallel port printers have no USB ids —
  use `{ type: 'file', path: '/dev/lp0' }` for them.
- **macOS:** there are no printer device files; the app talks USB directly,
  which works as long as no system print job is running on the printer. If
  the printer is set up in *System Settings → Printers* and USB access
  fails, use its queue instead: `{ type: 'cups', queue: '...' }` —
  `npm run list-printers` shows the queue names.
- **Windows:** USB printers belong to the Windows printer driver, which the
  app cannot use. Install the WinUSB driver for the printer with
  [Zadig](https://zadig.akeo.ie/).

### Keys, Develop and Build

`Escape` quits the app, `Cmd/Ctrl` + `F` toggles fullscreen, `F12` toggles
the developer tools.

| Command                  | Result                                                                |
| ------------------------ | --------------------------------------------------------------------- |
| `npm run dev`            | Window, dev tools, reload on save (restart on changes in `printers/`) |
| `npm run dev:simulate`   | Same, but jobs go to `simulated-output/`                              |
| `npm start`              | Fullscreen, as in the exhibition                                      |
| `npm run start:simulate` | Fullscreen with simulation                                            |
| `npm run list-printers`  | List connected printers, device files and CUPS queues                 |
| `npm run pack`           | Quick test build for your own computer                                |
| `npm run build:mac`      | macOS `.dmg` and `.zip`                                               |
| `npm run build:win`      | Windows installer and portable `.exe`                                 |
| `npm run build:linux`    | Linux `.AppImage` (x64)                                               |
| `npm run build:pi`       | Linux `.AppImage` for Raspberry Pi (arm64)                            |
| `npm run build:all`      | macOS, Windows and Linux x64                                          |

For app icon, signing warnings and more build details, see
[Electron_P5_Starter](https://github.com/ZHdK-Critical-Coding/Electron_P5_Starter).

## Coding Help

### Project Structure

```
Electron_P5_Printers/
├── printers/
│   ├── config.js           # Printer connections and settings — adjust here
│   ├── connections.js      # Device file, USB, CUPS and simulation
│   ├── image.js            # PNG → black and white dots (dithering, bit image bands)
│   ├── index.js            # IPC handlers, job queue, printer status
│   ├── lineprinter.js      # ESC/P commands for the dot matrix printer
│   └── thermalprinter.js   # ESC/POS commands for the thermal printer
├── scripts/
│   └── list-printers.js    # Lists printers, device files and CUPS queues
├── sketch/
│   ├── libraries/
│   │   ├── p5.min.js
│   │   ├── p5.sound.min.js
│   │   └── printers.js     # lineprinter / thermalprinter for the sketch
│   ├── index.html
│   ├── sketch.js           # Example sketch — edit this file
│   └── style.css
├── main.js                 # Electron main process
├── preload.js              # Bridge between sketch and main process
└── package.json            # Scripts and build configuration
```

### Printer Functions in the Sketch

All functions return a promise that resolves when the printer has received
the job. Jobs for the same printer are queued, so there is no "busy" state.

| Mode                     | Function                                          |
| ------------------------ | ------------------------------------------------- |
| Line printer, text       | `lineprinter.text(text, { w, h, style })`         |
| Line printer, feed       | `lineprinter.feed(direction, steps)`              |
| Line printer, image      | `lineprinter.image(canvas)`                       |
| Thermal printer, text    | `thermalprinter.text(text, { w, h, style, cut })` |
| Thermal printer, image   | `thermalprinter.image(canvas, { cut })`           |
| Thermal printer, cut     | `thermalprinter.cut()`                            |
| Status                   | `printers.status()`, `printers.onStatus(fn)`      |

```js
// Text: style '' | 'b' | 'u' | 'bu', w and h: 0 = normal, 1 = double
await lineprinter.text('Hello', { style: 'b', w: 1, h: 0 });
await thermalprinter.text('Hello', { style: 'bu', w: 1, h: 1, cut: true });

// Paper feed on the line printer: 'up' or 'down', 1 step = 1/216 inch
await lineprinter.feed('down', 36);

// Images: the sketch canvas (default), a p5.Graphics or a p5.Image
await lineprinter.image();
await thermalprinter.image(myGraphics, { cut: true });

// Errors (e.g. printer not connected) can be caught
try {
  await thermalprinter.text('Hello');
} catch (e) {
  console.log(e.message);
}
```

### What Happens Where

- **`sketch/sketch.js`**: the example. `setup()` creates the canvas, a
  512×512 `p5.Graphics` (`bild`) and the button panel (`createPanel()`),
  and subscribes to the printer status. `drawBild()` draws the black on
  white graphic that gets printed; `draw()` shows it together with status
  and last message. `run()` wraps every print job and shows "ok" or the
  error. The UI texts are in German.
- **`sketch/libraries/printers.js`**: defines `lineprinter`,
  `thermalprinter` and `printers`. Images are converted to PNG with
  `toPng()` and sent via `window.printerBridge` (from **`preload.js`**)
  to the main process.
- **`main.js`**: creates the window (fullscreen unless `--dev`), handles
  the keys, live reload in dev mode, and calls `setupPrinters()`.
- **`printers/index.js`**: registers the IPC handlers, runs one `Queue`
  per printer and checks the printer status every 2 seconds.
- **`printers/lineprinter.js` / `thermalprinter.js`**: build the raw ESC/P
  and ESC/POS bytes for text, feed, image and cut.
- **`printers/image.js`**: scales the PNG and turns it into black and white
  dots (`toDots()`), then into bit image bands (`toBands()`).
- **`printers/config.js`**: the place to change connections, text encoding
  and image settings. The line printer prints at most 480 dots wide (8
  inches at 60 dpi, `mode: 0`) with Floyd-Steinberg dithering; the thermal
  printer prints full width (256 dots with `density: 's8'`, 512 with
  `'d24'`) with a hard threshold of 128.

</div>

<div class="lang" lang="de" markdown="1">

# Electron: Printers

Ein p5.js-Sketch in einer [Electron](https://www.electronjs.org/)-App, der
Text und Bilder direkt auf einem Epson-Nadeldrucker (Line Printer) und einem
Epson-TM-Thermodrucker druckt. Anders als bei den Browser-Beispielen braucht
es keinen Raspberry Pi und keinen WebSocket-Server: Die Drucker sind am
Computer angeschlossen, auf dem die App läuft. Basiert auf
[Electron_P5_Starter](https://github.com/ZHdK-Critical-Coding/Electron_P5_Starter).

## Installation

Voraussetzungen: [Node.js](https://nodejs.org/) (LTS), Visual Studio Code,
ein Epson-Nadeldrucker (ESC/P) und/oder ein Epson-TM-Thermodrucker
(ESC/POS) per USB. Ohne Drucker läuft die App im Simulationsmodus.

Die Browser-Versionen
([P5_Output_Printers_LinePrinter](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter),
[P5_Output_Printers_ThermalPrinter_Lines](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines),
[P5_Output_Printers_ThermalPrinter_Bitmap](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap))
brauchen einen Raspberry Pi mit
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi).
Diese App erledigt die Bildumwandlung (Skalieren, Dithering) selbst, es
muss nichts zusätzlich installiert werden.

1. Den Ordner in Visual Studio Code öffnen und die Abhängigkeiten
   installieren (nur einmal nötig):
   ```sh
   npm install
   ```
2. Drucker einstecken und prüfen, ob sie gefunden werden:
   ```sh
   npm run list-printers
   ```
3. Entwicklungsmodus starten:
   ```sh
   npm run dev
   ```

Der Beispiel-Sketch zeigt den Verbindungsstatus beider Drucker, eine Grafik
zum Drucken (Klick darauf wechselt den Buchstaben) und ein Panel mit Knöpfen
für alle Modi.

Abhängigkeiten (`package.json`): Electron 44, electron-builder 26, `usb`
(USB-Zugriff über libusb), `iconv-lite` (Textkodierung). Bibliotheken in
`sketch/libraries/`: p5.js 1.10.0, p5.sound 1.0.1 (eingebunden, nicht
verwendet), `printers.js` (Druckerfunktionen für den Sketch).

### Ohne Drucker: Simulation

```sh
npm run dev:simulate
```

Jeder Auftrag wird in `simulated-output/` gespeichert statt gedruckt: die
Druckerdaten (`.bin`) und bei Bildern ein `.png`, das genau die Punkte
zeigt, die der Drucker drucken würde. Eine gebaute App, die mit
`--simulate` gestartet wird, speichert die Aufträge in
`Dokumente/simulated-output/`.

### Druckerverbindung

In `printers/config.js` steht, wie die Drucker angeschlossen sind. Die
Drucker werden über ihre USB-IDs unterschieden: Der Thermodrucker hat
`0x04b8:0x0e02`, der Nadeldrucker hat keine IDs und verwendet den ersten
anderen Drucker. Sind mehr Drucker angeschlossen, die IDs aus
`npm run list-printers` eintragen.

| Verbindung | Wo | Wie |
| --- | --- | --- |
| `{ type: 'file', vendorId, productId }` | Linux (Standard) | Schreibt in die Gerätedatei des Linux-Druckertreibers: `/dev/usb/lp0`, `/dev/usb/lp1`, … für USB, `/dev/lp0`, … für die Parallelschnittstelle. Die richtige Datei wird über die USB-IDs gefunden, die Reihenfolge beim Einstecken spielt keine Rolle. |
| `{ type: 'file', path: '/dev/usb/lp0' }` | Linux | Immer diese Datei. `path` kann eine Liste sein, die erste vorhandene Datei wird verwendet. |
| `{ type: 'usb', vendorId, productId }` | macOS, Windows (Standard), Linux | Spricht direkt per USB mit dem Drucker (libusb). |
| `{ type: 'cups', queue: 'EPSON_TM_T88V' }` | macOS, Linux | Schickt die Aufträge unverändert («raw») an eine CUPS-Druckerwarteschlange. |

- **Linux / Raspberry Pi:** Die Gerätedateien gehören der Gruppe `lp`. Den
  eigenen Benutzer einmalig hinzufügen, danach ab- und wieder anmelden:
  `sudo usermod -aG lp $USER`. Drucker an der Parallelschnittstelle haben
  keine USB-IDs – für sie `{ type: 'file', path: '/dev/lp0' }` verwenden.
- **macOS:** Es gibt keine Gerätedateien für Drucker; die App spricht direkt
  per USB mit dem Drucker. Das klappt, solange kein Druckauftrag des Systems
  auf dem Drucker läuft. Ist der Drucker unter *Systemeinstellungen →
  Drucker* eingerichtet und der USB-Zugriff klappt nicht, stattdessen seine
  Warteschlange verwenden: `{ type: 'cups', queue: '...' }` –
  `npm run list-printers` zeigt die Namen.
- **Windows:** USB-Drucker gehören dem Windows-Druckertreiber, den die App
  nicht verwenden kann. Mit [Zadig](https://zadig.akeo.ie/) den
  WinUSB-Treiber für den Drucker installieren.

### Tasten, Entwickeln und Bauen

`Escape` beendet die App, `Cmd/Ctrl` + `F` schaltet Vollbild ein/aus, `F12`
die Entwicklertools.

| Befehl                   | Ergebnis                                                                                 |
| ------------------------ | ---------------------------------------------------------------------------------------- |
| `npm run dev`            | Fenster, Entwicklertools, Reload beim Speichern (Neustart bei Änderungen in `printers/`) |
| `npm run dev:simulate`   | Dasselbe, Aufträge landen in `simulated-output/`                                         |
| `npm start`              | Vollbild, wie in der Ausstellung                                                         |
| `npm run start:simulate` | Vollbild mit Simulation                                                                  |
| `npm run list-printers`  | Angeschlossene Drucker, Gerätedateien und CUPS-Warteschlangen                            |
| `npm run pack`           | Schneller Test-Build für den eigenen Computer                                            |
| `npm run build:mac`      | macOS `.dmg` und `.zip`                                                                  |
| `npm run build:win`      | Windows-Installer und portable `.exe`                                                    |
| `npm run build:linux`    | Linux-`.AppImage` (x64)                                                                  |
| `npm run build:pi`       | Linux-`.AppImage` für Raspberry Pi (arm64)                                               |
| `npm run build:all`      | macOS, Windows und Linux x64                                                             |

App-Icon, Warnungen wegen fehlender Signatur und weitere Build-Details:
siehe
[Electron_P5_Starter](https://github.com/ZHdK-Critical-Coding/Electron_P5_Starter).

## Coding-Hilfe

### Projektstruktur

```
Electron_P5_Printers/
├── printers/
│   ├── config.js           # Druckerverbindungen und Einstellungen — hier anpassen
│   ├── connections.js      # Gerätedatei, USB, CUPS und Simulation
│   ├── image.js            # PNG → schwarze und weisse Punkte (Dithering, Bit-Image-Bänder)
│   ├── index.js            # IPC-Handler, Auftragswarteschlange, Druckerstatus
│   ├── lineprinter.js      # ESC/P-Befehle für den Nadeldrucker
│   └── thermalprinter.js   # ESC/POS-Befehle für den Thermodrucker
├── scripts/
│   └── list-printers.js    # Listet Drucker, Gerätedateien und CUPS-Warteschlangen
├── sketch/
│   ├── libraries/
│   │   ├── p5.min.js
│   │   ├── p5.sound.min.js
│   │   └── printers.js     # lineprinter / thermalprinter für den Sketch
│   ├── index.html
│   ├── sketch.js           # Beispiel-Sketch — diese Datei bearbeiten
│   └── style.css
├── main.js                 # Electron-Hauptprozess
├── preload.js              # Brücke zwischen Sketch und Hauptprozess
└── package.json            # Scripts und Build-Konfiguration
```

### Druckerfunktionen im Sketch

Alle Funktionen geben ein Promise zurück, das erfüllt wird, sobald der
Drucker den Auftrag erhalten hat. Aufträge an denselben Drucker werden
nacheinander abgearbeitet – ein «busy» gibt es nicht.

| Modus                    | Funktion                                          |
| ------------------------ | ------------------------------------------------- |
| Nadeldrucker, Text       | `lineprinter.text(text, { w, h, style })`         |
| Nadeldrucker, Vorschub   | `lineprinter.feed(direction, steps)`              |
| Nadeldrucker, Bild       | `lineprinter.image(canvas)`                       |
| Thermodrucker, Text      | `thermalprinter.text(text, { w, h, style, cut })` |
| Thermodrucker, Bild      | `thermalprinter.image(canvas, { cut })`           |
| Thermodrucker, Schneiden | `thermalprinter.cut()`                            |
| Status                   | `printers.status()`, `printers.onStatus(fn)`      |

```js
// Text: style '' | 'b' | 'u' | 'bu', w und h: 0 = normal, 1 = doppelt
await lineprinter.text('Hallo', { style: 'b', w: 1, h: 0 });
await thermalprinter.text('Hallo', { style: 'bu', w: 1, h: 1, cut: true });

// Papiervorschub am Nadeldrucker: 'up' oder 'down', 1 Step = 1/216 Zoll
await lineprinter.feed('down', 36);

// Bilder: das Canvas des Sketches (Standard), ein p5.Graphics oder ein p5.Image
await lineprinter.image();
await thermalprinter.image(meineGrafik, { cut: true });

// Fehler (z. B. Drucker nicht angeschlossen) abfangen
try {
  await thermalprinter.text('Hallo');
} catch (e) {
  console.log(e.message);
}
```

### Was passiert wo

- **`sketch/sketch.js`**: das Beispiel. `setup()` erstellt die
  Zeichenfläche, eine 512×512-`p5.Graphics` (`bild`) und das Panel mit den
  Knöpfen (`createPanel()`) und abonniert den Druckerstatus. `drawBild()`
  zeichnet die schwarz-weisse Grafik, die gedruckt wird; `draw()` zeigt sie
  zusammen mit Status und letzter Meldung. `run()` umschliesst jeden
  Druckauftrag und zeigt «ok» oder den Fehler an.
- **`sketch/libraries/printers.js`**: definiert `lineprinter`,
  `thermalprinter` und `printers`. Bilder werden mit `toPng()` in PNG
  umgewandelt und über `window.printerBridge` (aus **`preload.js`**) an den
  Hauptprozess geschickt.
- **`main.js`**: erstellt das Fenster (Vollbild, ausser mit `--dev`),
  behandelt die Tasten und den Live-Reload im Entwicklungsmodus und ruft
  `setupPrinters()` auf.
- **`printers/index.js`**: registriert die IPC-Handler, führt pro Drucker
  eine `Queue` und prüft alle 2 Sekunden den Druckerstatus.
- **`printers/lineprinter.js` / `thermalprinter.js`**: erzeugen die rohen
  ESC/P- und ESC/POS-Bytes für Text, Vorschub, Bild und Schneiden.
- **`printers/image.js`**: skaliert das PNG und wandelt es in schwarze und
  weisse Punkte um (`toDots()`), danach in Bit-Image-Bänder (`toBands()`).
- **`printers/config.js`**: hier werden Verbindungen, Textkodierung und
  Bildeinstellungen angepasst. Der Nadeldrucker druckt höchstens 480 Punkte
  breit (8 Zoll bei 60 dpi, `mode: 0`) mit Floyd-Steinberg-Dithering; der
  Thermodrucker druckt in voller Breite (256 Punkte mit `density: 's8'`,
  512 mit `'d24'`) mit harter Schwelle bei 128.

</div>
