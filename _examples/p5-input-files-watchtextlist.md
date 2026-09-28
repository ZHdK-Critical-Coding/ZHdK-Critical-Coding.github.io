---
title: Watch Text List
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Files_WatchTextList
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Files_WatchTextList
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Watch Text List

Reads the text file `assets/list.txt` every five seconds and draws its
lines on the canvas. Edit the file while the sketch is running and the
display follows the changes – useful when another program writes data into
a text file that a sketch should show.

## Installation

Requirements: a current browser.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Open `assets/list.txt`, change, add or remove lines and save the file.
3. The canvas shows the new content within about five seconds.

## Coding Help

- **`sketch.js` → `watcher()`**: loads `assets/list.txt` with
  `loadStrings()` into the array `list`. Once the file has arrived, it
  schedules itself again with `setTimeout(..., 5000)`. Change the 5000 ms
  to poll faster or slower. Started once in `preload()`.
- **`setup()`**: creates a 400 × 400 canvas, sets the text size to 12 and
  the line spacing (`textLeading`) to 18 (1.5 × text size).
- **`draw()`**: draws the lines one below the other, starting at y = 20
  and moving down by `textLeading()` per line. If you change the text
  size, adjust `textLeading` too.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Watch Text List

Liest die Textdatei `assets/list.txt` alle fünf Sekunden und zeichnet ihre
Zeilen auf die Zeichenfläche. Wird die Datei geändert, während der Sketch
läuft, folgt die Anzeige den Änderungen – nützlich, wenn ein anderes
Programm Daten in eine Textdatei schreibt, die ein Sketch anzeigen soll.

## Installation

Voraussetzungen: ein aktueller Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. `assets/list.txt` öffnen, Zeilen ändern, hinzufügen oder löschen und die
   Datei speichern.
3. Die Zeichenfläche zeigt den neuen Inhalt nach etwa fünf Sekunden.

## Coding-Hilfe

- **`sketch.js` → `watcher()`**: lädt `assets/list.txt` mit
  `loadStrings()` in das Array `list`. Sobald die Datei da ist, plant es
  sich mit `setTimeout(..., 5000)` erneut ein. Die 5000 ms ändern, um
  schneller oder langsamer abzufragen. Wird einmal in `preload()` gestartet.
- **`setup()`**: erstellt eine Zeichenfläche von 400 × 400 Pixeln, setzt
  die Textgrösse auf 12 und den Zeilenabstand (`textLeading`) auf 18
  (1,5 × Textgrösse).
- **`draw()`**: zeichnet die Zeilen untereinander, beginnend bei y = 20,
  und rückt pro Zeile um `textLeading()` nach unten. Bei anderer
  Schriftgrösse `textLeading` mit anpassen.

</div>
