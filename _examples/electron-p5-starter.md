---
title: Fullscreen App
category: output
technology: Electron
author: Urs Hofer
date: 2026-09-16
repo: Electron_P5_Starter
repo_url: https://github.com/ZHdK-Critical-Coding/Electron_P5_Starter
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Electron: Fullscreen App

A minimal p5.js sketch packaged in an [Electron](https://www.electronjs.org/)
app that opens fullscreen without any browser interface — for installations
and exhibitions. Includes a develop mode with live reload and ready-made
builds for macOS, Windows and Linux that run without Node.js or VS Code.

## Installation

Requirements: [Node.js](https://nodejs.org/) (LTS) and
[Visual Studio Code](https://code.visualstudio.com/).

1. Open the folder in Visual Studio Code.
2. Open a terminal (`Terminal → New Terminal`) and install the dependencies
   (only needed once):
   ```sh
   npm install
   ```
3. Start the develop mode:
   ```sh
   npm run dev
   ```

`npm run dev` opens the app in a window, with the developer tools in a
separate window (for `console.log()` output and errors). Saving a file in
`sketch/` reloads the sketch; changing `main.js` restarts the app.
`npm start` runs the app as in the exhibition: fullscreen, no dev tools, no
reload, and the display is kept from going to sleep.

Keys: `Escape` quits the app, `Cmd/Ctrl` + `F` toggles fullscreen, `F12`
toggles the developer tools.

Dependencies (`package.json`): Electron 44, electron-builder 26. Libraries
in `sketch/libraries/`: p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

### Building the App

A build turns the project into a standalone app. All results are saved in
`dist/`.

| Command               | Result                                                                        |
| --------------------- | ----------------------------------------------------------------------------- |
| `npm run pack`        | Quick test build for your own computer, no installer                          |
| `npm run build`       | Build for the computer you are working on                                     |
| `npm run build:mac`   | macOS: `.dmg` and `.zip` (runs on Apple Silicon and Intel)                    |
| `npm run build:win`   | Windows: installer (`Setup.exe`) and `portable.exe` (runs without installing) |
| `npm run build:linux` | Linux: `.AppImage`                                                            |
| `npm run build:all`   | All of the above                                                              |

All platforms can be built from a Mac. The first build takes a while,
because the needed tools are downloaded.

- **Name and version:** change `productName` in the `build` section and
  `version` in `package.json`. Both appear in the file names of the build.
- **App icon:** create a folder `build/` with a square `icon.png` (at least
  1024 × 1024 px). Without it, the default Electron icon is used.
- **Opening the app on another computer:** the builds are not signed, so
  the system warns the first time. macOS: right-click the app → *Open* →
  *Open*; if macOS says the app is "damaged", run
  `xattr -cr "/Applications/Electron P5 Starter.app"`. Windows: in the
  SmartScreen dialog, click *More info* → *Run anyway*. Linux:
  `chmod +x *.AppImage`.

## Coding Help

### Project Structure

```
Electron_P5_Starter/
├── .vscode/                # VS Code settings, p5.js autocomplete
├── build/                  # (optional) app icon
├── dist/                   # Built apps end up here
├── sketch/
│   ├── libraries/
│   │   ├── p5.min.js
│   │   └── p5.sound.min.js
│   ├── index.html          # Loads libraries + sketch
│   ├── sketch.js           # Your sketch — edit this file
│   └── style.css
├── main.js                 # Electron main process (creates the window)
└── package.json            # Scripts and build configuration
```

### What Happens Where

- **`sketch/sketch.js`**: `setup()` creates a canvas the size of the
  window, `draw()` paints it white and draws an "X" across it,
  `windowResized()` keeps the canvas in sync with the screen size. Replace
  this with your own sketch. For an installation, add `noCursor();` in
  `setup()` to hide the mouse pointer.
- **`main.js` → `createWindow()`**: opens a 1280×800 window, fullscreen
  unless started with `--dev`, and loads `sketch/index.html`. The
  `before-input-event` handler implements the keys.
- **`main.js` → `watchForChanges()`**: only in dev mode. Reloads the page
  when a file in `sketch/` changes and restarts the app when `main.js`
  changes.
- **`main.js` (end)**: allows only one running instance and, outside dev
  mode, keeps the display awake with `powerSaveBlocker`.
- **`package.json` → `build`**: electron-builder settings (app id, product
  name, which files go into the app, targets per platform).

</div>

<div class="lang" lang="de" markdown="1">

# Electron: Fullscreen App

Ein minimaler p5.js-Sketch in einer
[Electron](https://www.electronjs.org/)-App, die im Vollbild ohne
Browser-Oberfläche startet – für Installationen und Ausstellungen. Mit
Entwicklungsmodus inklusive Live-Reload und fertigen Builds für macOS,
Windows und Linux, die ohne Node.js oder VS Code laufen.

## Installation

Voraussetzungen: [Node.js](https://nodejs.org/) (LTS) und
[Visual Studio Code](https://code.visualstudio.com/).

1. Den Ordner in Visual Studio Code öffnen.
2. Ein Terminal öffnen (`Terminal → New Terminal`) und die Abhängigkeiten
   installieren (nur einmal nötig):
   ```sh
   npm install
   ```
3. Entwicklungsmodus starten:
   ```sh
   npm run dev
   ```

`npm run dev` öffnet die App in einem Fenster, die Entwicklertools in einem
eigenen Fenster (für `console.log()`-Ausgaben und Fehler). Beim Speichern
einer Datei in `sketch/` lädt der Sketch neu; bei Änderungen an `main.js`
startet die App neu. `npm start` zeigt die App wie in der Ausstellung:
Vollbild, ohne Entwicklertools und Reload, und der Bildschirm geht nicht in
den Ruhezustand.

Tasten: `Escape` beendet die App, `Cmd/Ctrl` + `F` schaltet Vollbild
ein/aus, `F12` die Entwicklertools.

Abhängigkeiten (`package.json`): Electron 44, electron-builder 26.
Bibliotheken in `sketch/libraries/`: p5.js 1.10.0, p5.sound 1.0.1
(eingebunden, nicht verwendet).

### App bauen

Ein Build macht aus dem Projekt eine eigenständige App. Alle Ergebnisse
landen in `dist/`.

| Befehl                | Ergebnis                                                                      |
| --------------------- | ----------------------------------------------------------------------------- |
| `npm run pack`        | Schneller Test-Build für den eigenen Computer, ohne Installer                 |
| `npm run build`       | Build für den Computer, auf dem gearbeitet wird                               |
| `npm run build:mac`   | macOS: `.dmg` und `.zip` (läuft auf Apple Silicon und Intel)                  |
| `npm run build:win`   | Windows: Installer (`Setup.exe`) und `portable.exe` (läuft ohne Installation) |
| `npm run build:linux` | Linux: `.AppImage`                                                            |
| `npm run build:all`   | Alle oben genannten                                                           |

Alle Plattformen lassen sich auf einem Mac bauen. Der erste Build dauert
länger, weil die nötigen Werkzeuge heruntergeladen werden.

- **Name und Version:** `productName` im Abschnitt `build` und `version` in
  `package.json` anpassen. Beides erscheint in den Dateinamen des Builds.
- **App-Icon:** einen Ordner `build/` mit einem quadratischen `icon.png`
  (mindestens 1024 × 1024 px) anlegen. Ohne Icon erscheint das
  Standard-Icon von Electron.
- **App auf einem anderen Computer öffnen:** Die Builds sind nicht
  signiert, deshalb warnt das System beim ersten Start. macOS: Rechtsklick
  auf die App → *Öffnen* → *Öffnen*; meldet macOS, die App sei
  «beschädigt», `xattr -cr "/Applications/Electron P5 Starter.app"`
  ausführen. Windows: im SmartScreen-Dialog auf *Weitere Informationen* →
  *Trotzdem ausführen* klicken. Linux: `chmod +x *.AppImage`.

## Coding-Hilfe

### Projektstruktur

```
Electron_P5_Starter/
├── .vscode/                # VS-Code-Einstellungen, p5.js-Autovervollständigung
├── build/                  # (optional) App-Icon
├── dist/                   # Hier landen die gebauten Apps
├── sketch/
│   ├── libraries/
│   │   ├── p5.min.js
│   │   └── p5.sound.min.js
│   ├── index.html          # Lädt Bibliotheken + Sketch
│   ├── sketch.js           # Dein Sketch — diese Datei bearbeiten
│   └── style.css
├── main.js                 # Electron-Hauptprozess (erstellt das Fenster)
└── package.json            # Scripts und Build-Konfiguration
```

### Was passiert wo

- **`sketch/sketch.js`**: `setup()` erstellt eine Zeichenfläche in
  Fenstergrösse, `draw()` füllt sie weiss und zeichnet ein «X» darüber,
  `windowResized()` passt die Zeichenfläche an die Bildschirmgrösse an. Das
  durch den eigenen Sketch ersetzen. Für eine Installation `noCursor();` in
  `setup()` einfügen, um den Mauszeiger auszublenden.
- **`main.js` → `createWindow()`**: öffnet ein Fenster mit 1280×800, im
  Vollbild, ausser mit `--dev`, und lädt `sketch/index.html`. Der Handler
  `before-input-event` setzt die Tasten um.
- **`main.js` → `watchForChanges()`**: nur im Entwicklungsmodus. Lädt die
  Seite neu, wenn sich eine Datei in `sketch/` ändert, und startet die App
  neu, wenn sich `main.js` ändert.
- **`main.js` (Ende)**: erlaubt nur eine laufende Instanz und hält
  ausserhalb des Entwicklungsmodus den Bildschirm mit `powerSaveBlocker`
  wach.
- **`package.json` → `build`**: Einstellungen für electron-builder (App-ID,
  Produktname, welche Dateien in die App kommen, Ziele pro Plattform).

</div>
