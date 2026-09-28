---
title: P5.5 Interface
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_UserInterfaces_P5.5
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_UserInterfaces_P5.5
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: P5.5 Interface

Example for p5.5.js by Kris Heyse, a p5 plugin that adds a UI, panning and
zooming and PNG export. You work in real-world units (millimetres) with
`mmpx()`: the sketch draws random coloured lines on a 200 × 100 mm canvas
that has the right physical size on screen and can be exported at print
resolution.

## Installation

Requirements: a current browser, browser zoom at 100 %.

1. Adjust `p5.initMetrics()` at the top of `sketch.js` to your display
   (see below).
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Use the mouse buttons and mouse wheel to pan and zoom.

`p5.initMetrics(displayDiagonalInInches, exportPPI)`: the first value is
the diagonal of your screen in inches, the second the resolution of the
exported image (0 = screen resolution). The example uses `31.5, 300`.

Keyboard shortcuts (p5.5 defaults): **F** zoom to fit, **O** zoom 1:1,
**M** max zoom, **E** export PNG, **L** toggle loop, **+** single step,
**Tab** show/hide the panel, **Shift+F** fullscreen.

Libraries (in `libraries/`): p5.js 1.10.0, p5.5.js 0.1.0, p5.sound 1.0.1
(included, not loaded).

## Coding Help

- **`sketch.js` → `p5.initMetrics()`**: must be called before the sketch
  starts; this is where you set the display diagonal and export PPI.
- **Variables**: `lineWeightInMillimeters` and `textSizeInMullimeters` –
  sizes in mm, converted to pixels with `mmpx()`.
- **`setup()`**: `createCanvas(mmpx(200), mmpx(100), { seed: 1234 })`
  sets the canvas size in mm; the `seed` option (from p5.5) makes the
  random values repeatable. Then the help text is written onto the canvas.
- **`draw()`**: draws one line per frame with random position and colour
  and a stroke weight of `mmpx(lineWeightInMillimeters)`.
- **`index.html`**: loads p5.js, p5.5.js and `sketch.js` with `defer`.
  The help text on the canvas mentions `artwork.js` – in this example the
  file is `sketch.js`.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: P5.5 Interface

Beispiel für p5.5.js von Kris Heyse, ein p5-Plugin, das eine Oberfläche,
Verschieben und Zoomen sowie PNG-Export hinzufügt. Gearbeitet wird in
realen Einheiten (Millimeter) mit `mmpx()`: Der Sketch zeichnet zufällige
farbige Linien auf eine 200 × 100 mm grosse Zeichenfläche, die am
Bildschirm die richtige physische Grösse hat und in Druckauflösung
exportiert werden kann.

## Installation

Voraussetzungen: ein aktueller Browser, Browser-Zoom auf 100 %.

1. `p5.initMetrics()` zuoberst in `sketch.js` an den eigenen Bildschirm
   anpassen (siehe unten).
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Mit den Maustasten und dem Mausrad verschieben und zoomen.

`p5.initMetrics(displayDiagonalInInches, exportPPI)`: Der erste Wert ist
die Bildschirmdiagonale in Zoll, der zweite die Auflösung des exportierten
Bildes (0 = Bildschirmauflösung). Das Beispiel verwendet `31.5, 300`.

Tastenkürzel (p5.5-Standard): **F** einpassen, **O** Zoom 1:1, **M**
maximaler Zoom, **E** PNG exportieren, **L** Loop ein/aus, **+** einzelner
Schritt, **Tab** Panel ein-/ausblenden, **Shift+F** Vollbild.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.5.js 0.1.0, p5.sound
1.0.1 (vorhanden, nicht geladen).

## Coding-Hilfe

- **`sketch.js` → `p5.initMetrics()`**: muss vor dem Start des Sketches
  aufgerufen werden; hier werden Bildschirmdiagonale und Export-PPI
  gesetzt.
- **Variablen**: `lineWeightInMillimeters` und `textSizeInMullimeters` –
  Grössen in mm, die mit `mmpx()` in Pixel umgerechnet werden.
- **`setup()`**: `createCanvas(mmpx(200), mmpx(100), { seed: 1234 })`
  setzt die Grösse der Zeichenfläche in mm; die Option `seed` (von p5.5)
  macht die Zufallswerte wiederholbar. Danach wird der Hilfetext auf die
  Zeichenfläche geschrieben.
- **`draw()`**: zeichnet pro Frame eine Linie mit zufälliger Position und
  Farbe und der Strichstärke `mmpx(lineWeightInMillimeters)`.
- **`index.html`**: lädt p5.js, p5.5.js und `sketch.js` mit `defer`. Der
  Hilfetext auf der Zeichenfläche erwähnt `artwork.js` – in diesem
  Beispiel heisst die Datei `sketch.js`.

</div>
