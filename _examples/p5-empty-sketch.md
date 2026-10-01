---
title: Empty Sketch
maincategory: code-samples
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-05-15
repo: P5_Empty_Sketch
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Empty_Sketch
screenshot: "/assets/examples/p5-empty-sketch/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Empty Sketch

An empty starter template for [p5.js](https://p5js.org/): the p5.js
library, the p5.sound add-on, a minimal HTML page and a pre-configured
Visual Studio Code workspace. The sketch only draws an "X" across the
canvas. Copy it as a fresh starting point for every new sketch or exercise.

## Installation

Requirements: [Visual Studio Code](https://code.visualstudio.com/) and a
browser (Live Server is configured to open Chrome).

1. Open the folder in Visual Studio Code.
2. Install the recommended extensions when prompted (or run
   `Extensions: Show Recommended Extensions` from the Command Palette):
   `samplavigne.p5-vscode` (p5.js snippets), `ritwickdey.liveserver`
   (local server with auto-reload) and `continue.continue` (AI coding
   assistant, optional).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used — sound functions work without adding a `<script>` tag).

## How to Run

Start Live Server (click **Go Live** in the status bar). The sketch opens
at `http://127.0.0.1:5500` and reloads whenever you save a file.

## Coding Help

### Project Structure

```
P5_Empty_Sketch/
├── .continue/              # Configuration for the Continue AI assistant
├── .vscode/
│   ├── extensions.json     # Recommended VS Code extensions
│   ├── global.d.ts         # p5.js type definitions for autocomplete
│   └── settings.json       # Live Server configuration
├── libraries/
│   ├── p5.min.js
│   └── p5.sound.min.js
├── index.html              # Loads libraries + sketch
├── jsconfig.json           # JS IntelliSense configuration
├── sketch.js               # Your sketch — edit this file
└── style.css               # Removes margins
```

### What Happens Where

- **`sketch.js` → `setup()`**: runs once and creates a 448×256 canvas.
  Change the size in `createCanvas(width, height)`.
- **`sketch.js` → `draw()`**: runs about 60 times per second, fills the
  canvas light grey and draws two diagonal lines.
- **`sketch.js` → `keyPressed()`**: pressing **F** toggles fullscreen.
- **`index.html`**: loads `p5.min.js`, `p5.sound.min.js` and `sketch.js`.
  Add further libraries or scripts here.
- **Autocomplete**: `.vscode/global.d.ts` and `jsconfig.json` give code
  completion and parameter hints for p5.js functions.
- **Console**: open the browser's developer tools (⌥⌘I on macOS) to see
  `console.log()` output and errors.

More: [p5.js reference](https://p5js.org/reference/),
[p5.js examples](https://p5js.org/examples/),
[The Coding Train](https://thecodingtrain.com/).

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Empty Sketch

Ein leeres Starter-Template für [p5.js](https://p5js.org/): die
p5.js-Bibliothek, das p5.sound-Add-on, eine minimale HTML-Seite und eine
vorkonfigurierte Visual-Studio-Code-Umgebung. Der Sketch zeichnet nur ein
«X» über die Zeichenfläche. Als sauberen Ausgangspunkt für jeden neuen
Sketch und jede Übung kopieren.

## Installation

Voraussetzungen: [Visual Studio Code](https://code.visualstudio.com/) und
ein Browser (Live Server ist so eingestellt, dass Chrome öffnet).

1. Den Ordner in Visual Studio Code öffnen.
2. Die empfohlenen Erweiterungen installieren, wenn VS Code danach fragt
   (oder in der Befehlspalette `Extensions: Show Recommended Extensions`):
   `samplavigne.p5-vscode` (p5.js-Snippets), `ritwickdey.liveserver`
   (lokaler Server mit automatischem Neuladen) und `continue.continue`
   (KI-Coding-Assistent, optional).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet – Sound-Funktionen gehen ohne zusätzlichen
`<script>`-Tag).

## Ausführen

Live Server starten (in der Statusleiste auf **Go Live** klicken). Der
Sketch öffnet sich unter `http://127.0.0.1:5500` und lädt bei jedem
Speichern neu.

## Coding-Hilfe

### Projektstruktur

```
P5_Empty_Sketch/
├── .continue/              # Konfiguration für den KI-Assistenten Continue
├── .vscode/
│   ├── extensions.json     # Empfohlene VS-Code-Erweiterungen
│   ├── global.d.ts         # p5.js-Typdefinitionen für Autovervollständigung
│   └── settings.json       # Live-Server-Konfiguration
├── libraries/
│   ├── p5.min.js
│   └── p5.sound.min.js
├── index.html              # Lädt Bibliotheken + Sketch
├── jsconfig.json           # JS-IntelliSense-Konfiguration
├── sketch.js               # Dein Sketch — diese Datei bearbeiten
└── style.css               # Entfernt die Ränder
```

### Was passiert wo

- **`sketch.js` → `setup()`**: läuft einmal und erstellt eine
  Zeichenfläche mit 448×256 Pixeln. Die Grösse in
  `createCanvas(breite, höhe)` ändern.
- **`sketch.js` → `draw()`**: läuft etwa 60 Mal pro Sekunde, füllt die
  Zeichenfläche hellgrau und zeichnet zwei Diagonalen.
- **`sketch.js` → `keyPressed()`**: Die Taste **F** schaltet Vollbild
  ein/aus.
- **`index.html`**: lädt `p5.min.js`, `p5.sound.min.js` und `sketch.js`.
  Weitere Bibliotheken oder Scripts hier einbinden.
- **Autovervollständigung**: `.vscode/global.d.ts` und `jsconfig.json`
  sorgen für Vervollständigung und Parameter-Hinweise zu p5.js-Funktionen.
- **Konsole**: Die Entwicklertools des Browsers öffnen (⌥⌘I auf macOS),
  um `console.log()`-Ausgaben und Fehler zu sehen.

Mehr: [p5.js-Referenz](https://p5js.org/reference/),
[p5.js-Beispiele](https://p5js.org/examples/),
[The Coding Train](https://thecodingtrain.com/).

</div>
