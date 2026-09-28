---
title: Vector Export
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Files_Vectors
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Files_Vectors
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Vector Export

Draws a circle with the SVG renderer and saves the drawing as an SVG file
when you press **s**. The file can be opened and edited in vector programs
like Inkscape or Illustrator – useful for plotters, laser cutters or
print.

## Installation

Requirements: Visual Studio Code with the Live Server extension and a
browser.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), `p5.svg.js` ([p5.js-svg](https://github.com/zenozeng/p5.js-svg),
SVG renderer for p5).

License: MIT

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Press **s** to download the drawing as `<timestamp>-out.svg`.

## Coding Help

- **`sketch.js` → `setup()`**: `createCanvas(500, 500, SVG)` switches to
  the SVG renderer from `p5.svg.js`. Everything drawn ends up as SVG
  elements instead of pixels.
- **`draw()`**: draws the background and the circle. Replace this part
  with your own drawing. Pixel-based functions (e.g. `loadPixels()`,
  filters) do not produce vectors.
- **`keyPressed()`**: on **s**, `save()` downloads the drawing as SVG. The
  file name is built from `Date.now()`, so every file gets a unique name.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Vector Export

Zeichnet einen Kreis mit dem SVG-Renderer und speichert die Zeichnung als
SVG-Datei, wenn du **s** drückst. Die Datei lässt sich in Vektorprogrammen
wie Inkscape oder Illustrator öffnen und bearbeiten – praktisch für
Plotter, Lasercutter oder Druck.

## Installation

Voraussetzungen: Visual Studio Code mit der Erweiterung Live Server und ein
Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), `p5.svg.js`
([p5.js-svg](https://github.com/zenozeng/p5.js-svg), SVG-Renderer für p5).

Lizenz: MIT

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. **s** drücken, um die Zeichnung als `<zeitstempel>-out.svg`
   herunterzuladen.

## Coding-Hilfe

- **`sketch.js` → `setup()`**: `createCanvas(500, 500, SVG)` schaltet auf
  den SVG-Renderer aus `p5.svg.js` um. Alles Gezeichnete landet als
  SVG-Elemente statt als Pixel.
- **`draw()`**: zeichnet Hintergrund und Kreis. Diesen Teil durch eigene
  Zeichnungen ersetzen. Pixelbasierte Funktionen (z. B. `loadPixels()`,
  Filter) ergeben keine Vektoren.
- **`keyPressed()`**: bei **s** lädt `save()` die Zeichnung als SVG
  herunter. Der Dateiname wird aus `Date.now()` gebildet, jede Datei bekommt
  also einen eigenen Namen.

</div>
