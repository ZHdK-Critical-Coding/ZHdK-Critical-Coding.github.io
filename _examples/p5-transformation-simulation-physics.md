---
title: Physics
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Simulation_Physics
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Simulation_Physics
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Physics

Letters as physical bodies using [matter.js](https://brm.io/matter-js/):
every key you type drops that character into the scene. Its glyph outline
is converted to points and used as a matter.js body that falls onto two
static circles. Based on examples from
[The Nature of Code](https://natureofcode.com/physics-libraries/).

## Installation

Requirements: a current browser.

To use another font, put the file (ttf/otf/woff) into `assets/` and change
`FONT_PATH` in `sketch.js`.

Libraries (in `libraries/`): p5.js 1.7.0, matter.js 0.19.0, poly-decomp 0.3.0.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Type any letter, digit or symbol to drop it into the scene.

## Coding Help

- **`sketch.js` → globals**: `FONT_PATH` points to the font
  (`assets/cmunrb.otf`), loaded in `preload()`. The matter.js modules
  (`Engine`, `Bodies`, `Composite`, `Body`, `Vector`) are unpacked at the
  top.
- **`setup()`**: creates the matter.js `engine` and two `Boundary` circles
  at the bottom edge.
- **`draw()`**: advances the physics with `Engine.update()`, draws all
  shapes and boundaries and removes shapes that fell below the canvas.
- **`keyPressed()`**: creates a `CustomShape` for `key` at the top centre.
  Only single printable characters are accepted; special keys such as
  Shift (whose `key` is "Shift") and the space bar are ignored.
- **`shape.js` → `CustomShape`**: turns the character into points with
  `font.textToPoints()` (one point every 4 px, `SAMPLE_FACTOR`), splits
  them into contours wherever there is a jump between two points (e.g. the
  stem and the dot of "i") and builds a body with `Bodies.fromVertices()`,
  with a random sideways velocity and some spin. `restitution` sets the
  bounciness. With poly-decomp (loaded in `index.html`) matter.js splits
  each concave contour into convex parts, so the body follows the letter's
  shape; holes like in "o" are filled. `show()` draws the outline of every
  part (white) and the red letter rotated
  with the body.
- **`boundary.js` → `Boundary`**: a static circular body (`isStatic: true`)
  and its drawing.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Physics

Buchstaben als physikalische Körper mit
[matter.js](https://brm.io/matter-js/): Jede getippte Taste lässt das
entsprechende Zeichen in die Szene fallen. Die Glyphen-Kontur wird in Punkte
umgewandelt und als matter.js-Körper verwendet, der auf zwei statische
Kreise fällt. Basiert auf Beispielen aus
[The Nature of Code](https://natureofcode.com/physics-libraries/).

## Installation

Voraussetzungen: ein aktueller Browser.

Für eine andere Schrift die Datei (ttf/otf/woff) in `assets/` legen und
`FONT_PATH` in `sketch.js` ändern.

Bibliotheken (in `libraries/`): p5.js 1.7.0, matter.js 0.19.0, poly-decomp
0.3.0.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Einen Buchstaben, eine Ziffer oder ein Zeichen tippen, um es fallen zu
   lassen.

## Coding-Hilfe

- **`sketch.js` → globale Variablen**: `FONT_PATH` zeigt auf die Schrift
  (`assets/cmunrb.otf`), die in `preload()` geladen wird. Die
  matter.js-Module (`Engine`, `Bodies`, `Composite`, `Body`, `Vector`)
  werden zuoberst entpackt.
- **`setup()`**: erstellt die matter.js-`engine` und zwei
  `Boundary`-Kreise am unteren Rand.
- **`draw()`**: rechnet die Physik mit `Engine.update()` weiter, zeichnet
  alle Formen und Begrenzungen und entfernt Formen, die unter die
  Zeichenfläche gefallen sind.
- **`keyPressed()`**: erzeugt oben in der Mitte eine `CustomShape` für
  `key`. Nur einzelne druckbare Zeichen werden angenommen; Sondertasten wie
  Shift (deren `key` "Shift" ist) und die Leertaste werden ignoriert.
- **`shape.js` → `CustomShape`**: wandelt das Zeichen mit
  `font.textToPoints()` in Punkte um (alle 4 px ein Punkt,
  `SAMPLE_FACTOR`), teilt sie dort, wo zwei Punkte weit auseinanderliegen,
  in Konturen auf (z. B. Stamm und Punkt des "i") und baut mit
  `Bodies.fromVertices()` einen Körper, mit zufälliger seitlicher
  Geschwindigkeit und etwas Drehung. `restitution` bestimmt, wie stark er
  abprallt. Mit poly-decomp (in `index.html` geladen) zerlegt matter.js
  jede konkave Kontur in konvexe Teile, so folgt der Körper der Form des
  Buchstabens; Löcher wie im "o" werden gefüllt. `show()` zeichnet die
  Kontur jedes Teils (weiss) und den
  roten Buchstaben, mit dem Körper gedreht.
- **`boundary.js` → `Boundary`**: ein statischer, kreisförmiger Körper
  (`isStatic: true`) und seine Darstellung.

</div>
