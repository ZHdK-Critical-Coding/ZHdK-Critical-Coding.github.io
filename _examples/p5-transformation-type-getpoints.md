---
title: Get Points
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Type_GetPoints
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Type_GetPoints
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Get Points

Samples the outline of a text with `font.textToPoints()` and draws the
points as small dots over the text's bounding box. Sliders control the
sample factor and the font size; the number of generated points is shown.
A starting point for generative typography based on glyph outlines.

## Installation

Requirements: a current browser.

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Adjust the sliders to change sampling density and font size.

Browsers cannot read system fonts directly – put your own font file
(ttf/otf/woff) into `assets/` and change `FONT_PATH` in `sketch.js`.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## Coding Help

- **`sketch.js` → config**: `FONT_PATH` (default `assets/pixelmix.ttf`)
  and `SAMPLE_TEXT` (`'ZHDK'`) at the top are the values to change.
  `sampleFactor` and `fontSize` hold the start values of the sliders.
- **`preload()` / `setup()`**: `preload()` loads the font. `setup()`
  connects the sliders in `index.html` (`#sampleFactor`, `#fontSize`) and
  calls `noLoop()` – the sketch only redraws when a control changes.
- **`regenPoints()`**: calls `theFont.textToPoints()` with the current
  `sampleFactor` (lower = more points) and `simplifyThreshold: 0`, updates
  the point counter and calls `redraw()`.
- **`draw()`**: draws the bounding box from `textBounds()` and one circle
  per point, offset to `x = 80` and vertically centred. Replace the
  `circle()` call to draw something else at each point.
- **`windowResized()`**: resizes the canvas and regenerates the points.
- **`index.html`**: contains the slider UI (`#ui`); ranges and start
  values are set there.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Get Points

Tastet die Kontur eines Textes mit `font.textToPoints()` ab und zeichnet
die Punkte als kleine Kreise über die Bounding Box des Textes. Mit Slidern
lassen sich Sample-Faktor und Schriftgrösse einstellen; die Anzahl der
erzeugten Punkte wird angezeigt. Ein Ausgangspunkt für generative
Typografie auf Basis von Glyphen-Konturen.

## Installation

Voraussetzungen: ein aktueller Browser.

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Mit den Slidern Abtastdichte und Schriftgrösse verändern.

Browser können Systemschriften nicht direkt lesen – eine eigene
Schriftdatei (ttf/otf/woff) in `assets/` legen und `FONT_PATH` in
`sketch.js` ändern.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → Konfiguration**: `FONT_PATH` (Standard
  `assets/pixelmix.ttf`) und `SAMPLE_TEXT` (`'ZHDK'`) zuoberst sind die
  Werte zum Anpassen. `sampleFactor` und `fontSize` enthalten die
  Startwerte der Slider.
- **`preload()` / `setup()`**: `preload()` lädt die Schrift. `setup()`
  verbindet die Slider aus `index.html` (`#sampleFactor`, `#fontSize`) und ruft
  `noLoop()` auf – der Sketch zeichnet nur neu, wenn ein Regler geändert
  wird.
- **`regenPoints()`**: ruft `theFont.textToPoints()` mit dem aktuellen
  `sampleFactor` (kleiner = mehr Punkte) und `simplifyThreshold: 0` auf,
  aktualisiert den Punktezähler und ruft `redraw()` auf.
- **`draw()`**: zeichnet die Bounding Box aus `textBounds()` und pro Punkt
  einen Kreis, verschoben nach `x = 80` und vertikal zentriert. Den
  `circle()`-Aufruf ersetzen, um an jedem Punkt etwas anderes zu zeichnen.
- **`windowResized()`**: passt die Zeichenfläche an und berechnet die
  Punkte neu.
- **`index.html`**: enthält die Slider-Oberfläche (`#ui`); Bereiche und
  Startwerte werden dort gesetzt.

</div>
