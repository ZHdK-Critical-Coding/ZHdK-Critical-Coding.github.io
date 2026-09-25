---
title: Fullscreen App
category: output
technology: Electron
author: Urs Hofer
date: 2026-09-16
repo: Electron_P5_Starter
repo_url: https://github.com/ZHdK-Critical-Coding/Electron_P5_Starter
render_with_liquid: false
---

# Electron P5 Starter — p5.js in a Fullscreen App

> A minimal p5.js sketch packaged in an [Electron](https://www.electronjs.org/) application that opens fullscreen — ideal for installations and exhibitions. Includes a develop mode with live reload and ready-made builds for macOS, Windows and Linux.
> Ein minimaler p5.js-Sketch in einer [Electron](https://www.electronjs.org/)-Applikation, die im Vollbild startet — ideal für Installationen und Ausstellungen. Mit Entwicklungsmodus inklusive Live-Reload und fertigen Builds für macOS, Windows und Linux.

---

## 🇬🇧 English

### Overview

Instead of running the sketch in a browser via Live Server, this template runs it inside its own desktop app. The app opens fullscreen without any browser interface, and the canvas always fills the whole screen. When the sketch is finished, you can build a standalone app that runs on a computer without Node.js or VS Code.

### Project Structure

```
Electron_P5_Starter/
├── .vscode/
│   ├── extensions.json     # Recommended VS Code extensions
│   ├── global.d.ts         # p5.js type definitions for autocomplete
│   └── settings.json       # Editor settings
├── build/                  # (optional) app icon, see "App Icon"
├── dist/                   # Built apps end up here (created by the build)
├── sketch/
│   ├── libraries/
│   │   ├── p5.min.js       # p5.js core library
│   │   └── p5.sound.min.js # p5.sound add-on library
│   ├── index.html          # HTML host page (loads libraries + sketch)
│   ├── sketch.js           # Your sketch — edit this file
│   └── style.css           # Page styling
├── .gitignore
├── jsconfig.json           # JS IntelliSense configuration
├── main.js                 # Electron main process (creates the window)
└── package.json            # Scripts and build configuration
```

### Requirements

- **[Node.js](https://nodejs.org/)** (LTS version)
- **[Visual Studio Code](https://code.visualstudio.com/)** — recommended editor

### Getting Started

1. **Open the folder** in Visual Studio Code.
2. Open a terminal (`Terminal → New Terminal`) and install the dependencies (only needed once):
   ```sh
   npm install
   ```
3. Start the develop mode:
   ```sh
   npm run dev
   ```

### Develop Mode

`npm run dev` is the mode to work in:

- The app opens in a **window** instead of fullscreen.
- The **developer tools** open in a separate window, so you can see `console.log()` output and errors.
- **Live reload**: every time you save a file in `sketch/`, the sketch reloads automatically.
- When you change `main.js`, the whole app restarts.

To see the app exactly as it will run in the exhibition (fullscreen, no dev tools, no reload), use:

```sh
npm start
```

In this mode, the screen is also kept from going to sleep.

### Keys

| Key                | Action                           |
| ------------------ | -------------------------------- |
| `Escape`           | Quit the app                     |
| `Cmd/Ctrl` + `F`   | Toggle fullscreen                |
| `F12`              | Toggle developer tools (console) |

### Building the App

A build turns the project into a standalone app. All results are saved in the `dist/` folder.

| Command               | Result                                                         |
| --------------------- | -------------------------------------------------------------- |
| `npm run pack`        | Quick test build for your own computer, no installer (`dist/*-unpacked` or `dist/mac-universal`) |
| `npm run build`       | Build for the computer you are working on                      |
| `npm run build:mac`   | macOS: `.dmg` and `.zip` (runs on Apple Silicon and Intel)     |
| `npm run build:win`   | Windows: installer (`Setup.exe`) and `portable.exe` (runs without installing) |
| `npm run build:linux` | Linux: `.AppImage`                                             |
| `npm run build:all`   | All of the above                                               |

All platforms can be built from a Mac. The first build takes a while, because the needed tools are downloaded.

**Name and version:** change `productName` in the `build` section and `version` in `package.json`. Both appear in the file names of the built app.

#### App Icon

Create a folder `build/` and put a square `icon.png` (at least 1024 × 1024 px) in it. It is used automatically for all platforms. Without it, the default Electron icon is used.

#### Opening the App on Another Computer

The built apps are **not signed**, so the operating system shows a warning the first time:

- **macOS:** right-click the app → *Open* → *Open*. If macOS says the app is "damaged", run `xattr -cr "/Applications/Electron P5 Starter.app"` in the terminal.
- **Windows:** in the SmartScreen dialog, click *More info* → *Run anyway*.
- **Linux:** make the file executable: `chmod +x *.AppImage`.

### The Sketch

`sketch/sketch.js` creates a canvas the size of the window and draws an "X" across it. `windowResized()` keeps the canvas in sync with the screen size:

```js
function setup() {
  createCanvas(windowWidth, windowHeight);
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
```

Tip: for an installation, add `noCursor();` in `setup()` to hide the mouse pointer.

---

## 🇩🇪 Deutsch

### Überblick

Statt den Sketch mit Live Server im Browser auszuführen, läuft er in diesem Template in einer eigenen Desktop-App. Die App startet im Vollbild ohne Browser-Oberfläche, und die Zeichenfläche füllt immer den ganzen Bildschirm. Ist der Sketch fertig, lässt sich eine eigenständige App bauen, die auch auf einem Computer ohne Node.js oder VS Code läuft.

### Voraussetzungen

- **[Node.js](https://nodejs.org/)** (LTS-Version)
- **[Visual Studio Code](https://code.visualstudio.com/)** — empfohlener Editor

### Erste Schritte

1. **Ordner** in Visual Studio Code öffnen.
2. Ein Terminal öffnen (`Terminal → New Terminal`) und die Abhängigkeiten installieren (nur einmal nötig):
   ```sh
   npm install
   ```
3. Entwicklungsmodus starten:
   ```sh
   npm run dev
   ```

### Entwicklungsmodus

Mit `npm run dev` wird gearbeitet:

- Die App öffnet sich in einem **Fenster** statt im Vollbild.
- Die **Entwicklertools** öffnen sich in einem eigenen Fenster — dort erscheinen `console.log()`-Ausgaben und Fehler.
- **Live-Reload**: Bei jedem Speichern einer Datei in `sketch/` lädt der Sketch automatisch neu.
- Bei Änderungen an `main.js` startet die ganze App neu.

Um die App so zu sehen, wie sie in der Ausstellung läuft (Vollbild, ohne Entwicklertools und Reload):

```sh
npm start
```

In diesem Modus geht der Bildschirm zudem nicht in den Ruhezustand.

### Tasten

| Taste              | Aktion                            |
| ------------------ | --------------------------------- |
| `Escape`           | App beenden                       |
| `Cmd/Ctrl` + `F`   | Vollbild ein/aus                  |
| `F12`              | Entwicklertools (Konsole) ein/aus |

### App bauen

Ein Build macht aus dem Projekt eine eigenständige App. Alle Ergebnisse landen im Ordner `dist/`.

| Befehl                | Ergebnis                                                       |
| --------------------- | -------------------------------------------------------------- |
| `npm run pack`        | Schneller Test-Build für den eigenen Computer, ohne Installer  |
| `npm run build`       | Build für den Computer, auf dem gearbeitet wird                |
| `npm run build:mac`   | macOS: `.dmg` und `.zip` (läuft auf Apple Silicon und Intel)   |
| `npm run build:win`   | Windows: Installer (`Setup.exe`) und `portable.exe` (läuft ohne Installation) |
| `npm run build:linux` | Linux: `.AppImage`                                             |
| `npm run build:all`   | Alle oben genannten                                            |

Alle Plattformen lassen sich auf einem Mac bauen. Der erste Build dauert länger, weil die nötigen Werkzeuge heruntergeladen werden.

**Name und Version:** `productName` im Abschnitt `build` und `version` in `package.json` anpassen. Beides erscheint in den Dateinamen der gebauten App.

#### App-Icon

Einen Ordner `build/` anlegen und darin ein quadratisches `icon.png` (mindestens 1024 × 1024 px) ablegen. Es wird automatisch für alle Plattformen verwendet. Ohne Icon erscheint das Standard-Icon von Electron.

#### App auf einem anderen Computer öffnen

Die gebauten Apps sind **nicht signiert**, deshalb zeigt das Betriebssystem beim ersten Start eine Warnung:

- **macOS:** Rechtsklick auf die App → *Öffnen* → *Öffnen*. Meldet macOS, die App sei «beschädigt», im Terminal `xattr -cr "/Applications/Electron P5 Starter.app"` ausführen.
- **Windows:** Im SmartScreen-Dialog auf *Weitere Informationen* → *Trotzdem ausführen* klicken.
- **Linux:** Datei ausführbar machen: `chmod +x *.AppImage`.

### Der Sketch

`sketch/sketch.js` erstellt eine Zeichenfläche in Fenstergrösse und zeichnet ein «X» darüber. `windowResized()` passt die Zeichenfläche an die Bildschirmgrösse an.

Tipp: Für eine Installation `noCursor();` in `setup()` einfügen, um den Mauszeiger auszublenden.
