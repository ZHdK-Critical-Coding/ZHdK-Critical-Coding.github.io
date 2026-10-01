---
title: Watch Image Folder
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Files_WatchImageFolder
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Files_WatchImageFolder
screenshot: "/assets/examples/p5-input-files-watchimagefolder/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Watch Image Folder

Displays all images from the folder `assets/files` in a grid. Images added
to or removed from the folder appear or disappear while the sketch is
running. Useful for installations where new pictures arrive in a folder,
e.g. from a camera, a scanner or another program.

## Installation

Requirements: macOS or Linux (the watcher is a bash script; on Windows use
Git Bash or WSL) and a current browser.

Put images (e.g. `.jpg`, `.png`) into `assets/files` (seven sample images
are included).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. In a terminal, run the watcher script from the project folder:
   `bash watch.sh` (leave it running).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Add or remove images in `assets/files`.

A browser cannot list the contents of a folder. That is why `watch.sh`
writes the file list into `assets/list.txt`, which the sketch then reads.

## Coding Help

- **`watch.sh`**: checks `assets/files` every second and rewrites
  `assets/list.txt` with the file paths whenever the contents change.
  `WATCH_DIR` and `OUTPUT_FILE` at the top set the folders.
- **`sketch.js` → `watcher()`**: loads `list.txt` with `loadStrings()`,
  loads new images with `loadImage()` and removes images that are no longer
  in the list. Then it calls itself again after 1000 ms. Started once in
  `preload()`.
- **`images`**: object with one entry per file path, holding `status`
  (`loading` / `ok`) and the `source` image.
- **`setup()`**: creates a 400 × 400 canvas.
- **`draw()`**: draws every loaded image in a grid of square cells,
  `itemsPerLine` (4) per row. Each image is scaled to fit its cell and
  centred, keeping its aspect ratio. Change `itemsPerLine` or the canvas
  size to fit more images.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Watch Image Folder

Zeigt alle Bilder aus dem Ordner `assets/files` in einem Raster an. Bilder,
die dem Ordner hinzugefügt oder daraus entfernt werden, erscheinen oder
verschwinden, während der Sketch läuft. Nützlich für Installationen, bei
denen neue Bilder in einem Ordner landen, z. B. von einer Kamera, einem
Scanner oder einem anderen Programm.

## Installation

Voraussetzungen: macOS oder Linux (der Watcher ist ein Bash-Skript; unter
Windows Git Bash oder WSL verwenden) und ein aktueller Browser.

Bilder (z. B. `.jpg`, `.png`) in `assets/files` legen (sieben Beispielbilder
sind dabei).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. In einem Terminal im Projektordner das Watcher-Skript starten:
   `bash watch.sh` (laufen lassen).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Bilder in `assets/files` hinzufügen oder entfernen.

Ein Browser kann den Inhalt eines Ordners nicht auflisten. Deshalb schreibt
`watch.sh` die Dateiliste in `assets/list.txt`, die der Sketch dann liest.

## Coding-Hilfe

- **`watch.sh`**: prüft `assets/files` jede Sekunde und schreibt
  `assets/list.txt` mit den Dateipfaden neu, sobald sich der Inhalt ändert.
  `WATCH_DIR` und `OUTPUT_FILE` oben legen die Ordner fest.
- **`sketch.js` → `watcher()`**: lädt `list.txt` mit `loadStrings()`, lädt
  neue Bilder mit `loadImage()` und entfernt Bilder, die nicht mehr in der
  Liste stehen. Danach ruft es sich nach 1000 ms selbst wieder auf. Wird
  einmal in `preload()` gestartet.
- **`images`**: Objekt mit einem Eintrag pro Dateipfad, mit `status`
  (`loading` / `ok`) und dem Bild in `source`.
- **`setup()`**: erstellt eine Zeichenfläche von 400 × 400 Pixeln.
- **`draw()`**: zeichnet alle geladenen Bilder in einem Raster aus
  quadratischen Zellen, `itemsPerLine` (4) pro Zeile. Jedes Bild wird
  unter Beibehaltung des Seitenverhältnisses in seine Zelle eingepasst und
  darin zentriert. Für mehr Bilder `itemsPerLine` oder die Grösse der
  Zeichenfläche ändern.

</div>
