---
title: PNG Export
maincategory: code-samples
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Files_PNG
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Files_PNG
screenshot: "/assets/examples/p5-output-files-png/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: PNG Export

Draws a circle on a canvas and saves the current frame as a PNG file when
you press **s**. A minimal starting point for exporting images from a
sketch, e.g. for print or documentation.

## Installation

Requirements: Visual Studio Code with the Live Server extension and a
browser.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

License: MIT

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Press **s** to download the current frame as `<timestamp>-out.png`.

## Coding Help

- **`sketch.js` → `setup()`**: creates a 500×500 canvas. The saved PNG
  uses the screen's pixel density, so on a Retina display it is 1000×1000
  pixels. Add `pixelDensity(1)` for exactly 500×500, or a higher value for
  a larger file.
- **`draw()`**: draws the background and the circle. Replace this part
  with your own drawing.
- **`keyPressed()`**: on **s**, `save()` downloads the canvas. The file
  name is built from `Date.now()`, so every file gets a unique name. Add
  more `case`s for other keys.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: PNG Export

Zeichnet einen Kreis auf die Zeichenfläche und speichert den aktuellen
Frame als PNG-Datei, wenn du **s** drückst. Ein minimaler Ausgangspunkt,
um Bilder aus einem Sketch zu exportieren, z. B. für Druck oder
Dokumentation.

## Installation

Voraussetzungen: Visual Studio Code mit der Erweiterung Live Server und ein
Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

Lizenz: MIT

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. **s** drücken, um den aktuellen Frame als `<zeitstempel>-out.png`
   herunterzuladen.

## Coding-Hilfe

- **`sketch.js` → `setup()`**: erstellt eine Zeichenfläche von 500×500. Das
  gespeicherte PNG verwendet die Pixeldichte des Bildschirms, auf einem
  Retina-Display ist es also 1000×1000 Pixel gross. Mit `pixelDensity(1)`
  wird es genau 500×500, mit einem höheren Wert grösser.
- **`draw()`**: zeichnet Hintergrund und Kreis. Diesen Teil durch eigene
  Zeichnungen ersetzen.
- **`keyPressed()`**: bei **s** lädt `save()` die Zeichenfläche herunter.
  Der Dateiname wird aus `Date.now()` gebildet, jede Datei bekommt also
  einen eigenen Namen. Für weitere Tasten zusätzliche `case`s ergänzen.

</div>
