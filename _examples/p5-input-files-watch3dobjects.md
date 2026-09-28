---
title: Watch 3D Objects
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Files_Watch3dObjects
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Files_Watch3dObjects
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Watch 3D Objects

Displays all 3D models from the folder `assets/files` in a grid on a WEBGL
canvas. Models added to or removed from the folder appear or disappear
while the sketch is running. Useful for installations where new objects
are dropped into a folder, e.g. from a scanner or another program.

## Installation

Requirements: macOS or Linux (the watcher is a bash script; on Windows use
Git Bash or WSL) and a current browser.

Put `.obj` files into `assets/files` (a `teapot.obj` is included).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. In a terminal, run the watcher script from the project folder:
   `bash watch.sh` (leave it running).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Add or remove models in `assets/files`. Drag with the mouse to rotate
   the scene.

A browser cannot list the contents of a folder. That is why `watch.sh`
writes the file list into `assets/list.txt`, which the sketch then reads.

## Coding Help

- **`watch.sh`**: checks `assets/files` every second and rewrites
  `assets/list.txt` with the file paths whenever the contents change.
  `WATCH_DIR` and `OUTPUT_FILE` at the top set the folders.
- **`sketch.js` → `watcher()`**: loads `list.txt` with `loadStrings()`,
  loads new models with `loadModel(file, true)` (normalized to a common
  size) and removes models that are no longer in the list. Then it calls
  itself again after 1000 ms. Started once in `preload()`.
- **`models`**: object with one entry per file path, holding `status`
  (`loading` / `ok`) and the `shape`.
- **`setup()`**: creates a 600 × 600 WEBGL canvas and sets `angleMode`
  to degrees.
- **`draw()`**: enables `orbitControl()` and `lights()` and draws every
  loaded model in a grid, `itemsPerLine` (4) per row. `offset` is
  calculated from `itemsPerLine` so the grid is centred on the canvas;
  `translate()` sets each model's grid position, `rotateZ(180)` / `rotateY(180)` turn the
  models upright – adjust these for your own files.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Watch 3D Objects

Zeigt alle 3D-Modelle aus dem Ordner `assets/files` in einem Raster auf
einer WEBGL-Zeichenfläche an. Modelle, die dem Ordner hinzugefügt oder
daraus entfernt werden, erscheinen oder verschwinden, während der Sketch
läuft. Nützlich für Installationen, bei denen neue Objekte in einem Ordner
landen, z. B. von einem Scanner oder einem anderen Programm.

## Installation

Voraussetzungen: macOS oder Linux (der Watcher ist ein Bash-Skript; unter
Windows Git Bash oder WSL verwenden) und ein aktueller Browser.

`.obj`-Dateien in `assets/files` legen (ein `teapot.obj` ist dabei).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. In einem Terminal im Projektordner das Watcher-Skript starten:
   `bash watch.sh` (laufen lassen).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Modelle in `assets/files` hinzufügen oder entfernen. Mit der Maus ziehen,
   um die Szene zu drehen.

Ein Browser kann den Inhalt eines Ordners nicht auflisten. Deshalb schreibt
`watch.sh` die Dateiliste in `assets/list.txt`, die der Sketch dann liest.

## Coding-Hilfe

- **`watch.sh`**: prüft `assets/files` jede Sekunde und schreibt
  `assets/list.txt` mit den Dateipfaden neu, sobald sich der Inhalt ändert.
  `WATCH_DIR` und `OUTPUT_FILE` oben legen die Ordner fest.
- **`sketch.js` → `watcher()`**: lädt `list.txt` mit `loadStrings()`, lädt
  neue Modelle mit `loadModel(file, true)` (auf eine gemeinsame Grösse
  normalisiert) und entfernt Modelle, die nicht mehr in der Liste stehen.
  Danach ruft es sich nach 1000 ms selbst wieder auf. Wird einmal in
  `preload()` gestartet.
- **`models`**: Objekt mit einem Eintrag pro Dateipfad, mit `status`
  (`loading` / `ok`) und `shape`.
- **`setup()`**: erstellt eine WEBGL-Zeichenfläche von 600 × 600 Pixeln und
  stellt `angleMode` auf Grad.
- **`draw()`**: aktiviert `orbitControl()` und `lights()` und zeichnet alle
  geladenen Modelle in einem Raster, `itemsPerLine` (4) pro Zeile. `offset`
  wird aus `itemsPerLine` berechnet, damit das Raster auf der
  Zeichenfläche zentriert ist; `translate()` legt die Rasterposition jedes
  Modells fest, `rotateZ(180)` /
  `rotateY(180)` stellen die Modelle aufrecht – für eigene Dateien anpassen.

</div>
