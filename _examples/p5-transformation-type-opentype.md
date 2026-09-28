---
title: OpenType
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Type_Opentype
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Type_Opentype
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: OpenType

Works directly with the [opentype.js](https://opentype.js.org) font that
sits underneath a p5 font: `font.getPath()` returns the raw path commands,
which are drawn as vector outline and sampled into points per contour. A
raster slider snaps the points to a grid. Gives more control over glyph
shapes than `textToPoints()`.

## Installation

Requirements: a current browser.

To use another font, put the file (ttf/otf/woff) into `assets/` and change
`FONT_PATH` in `sketch.js`.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used). opentype.js is part of p5.js and needs no extra file.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Enter a text and adjust font size, sampling step, points per line and
   raster.
3. Press **O** to toggle the outlines (click outside the text field
   first).

## Coding Help

- **`sketch.js` → globals**: `FONT_PATH` (default `assets/cmunrb.otf`) and
  the start values `sampleStep`, `fontSize`, `sampleLineSub` and
  `rasterSize`.
- **`preload()`**: loads the font with `loadFont()` and stores the
  opentype.js object (`theFont.font`) in `otFont`.
- **`setup()`**: connects the controls in `index.html` and calls
  `noLoop()` – every change triggers `regen()`, which only calls
  `redraw()`.
- **`draw()`**: gets the path with `otFont.getPath(txt, x, y, fontSize)`.
  If `showOutlines` is on, it draws the commands `M`, `L`, `C`, `Q`, `Z`
  with `vertex()`, `bezierVertex()` and `quadraticVertex()`. Then it
  samples the path, updates the contour and point counter in `index.html`
  (`#contCount`, `#ptCount`) and draws one circle per point, snapped to a grid of
  `rasterSize` (which is also the circle diameter).
- **`pathhelper.js` → `sampleOpentypePath()`**: walks through the path
  commands, starts a new contour at each `M`, subdivides lines
  (`lineSub`) and samples curves in steps of `step` with `cubicAt()` /
  `quadAt()`. Returns a flat list of `{x, y, contour}` points.
- **`keyPressed()`**: **O** toggles the outlines. While the text field has
  the focus, the shortcut is ignored, so you can type an "o".

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: OpenType

Arbeitet direkt mit der [opentype.js](https://opentype.js.org)-Schrift,
die unter einer p5-Schrift liegt: `font.getPath()` liefert die rohen
Pfadbefehle, die als Vektorkontur gezeichnet und pro Kontur in Punkte
abgetastet werden. Ein Raster-Slider rastet die Punkte auf ein Gitter ein.
Gibt mehr Kontrolle über Glyphenformen als `textToPoints()`.

## Installation

Voraussetzungen: ein aktueller Browser.

Für eine andere Schrift die Datei (ttf/otf/woff) in `assets/` legen und
`FONT_PATH` in `sketch.js` ändern.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet). opentype.js ist in p5.js enthalten und braucht keine
eigene Datei.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Einen Text eingeben und Schriftgrösse, Abtastschritt, Punkte pro Linie
   und Raster einstellen.
3. **O** drücken, um die Konturen ein- und auszublenden (vorher ausserhalb
   des Textfelds klicken).

## Coding-Hilfe

- **`sketch.js` → globale Variablen**: `FONT_PATH` (Standard
  `assets/cmunrb.otf`) und die Startwerte `sampleStep`, `fontSize`,
  `sampleLineSub` und `rasterSize`.
- **`preload()`**: lädt die Schrift mit `loadFont()` und speichert das
  opentype.js-Objekt (`theFont.font`) in `otFont`.
- **`setup()`**: verbindet die Bedienelemente aus `index.html` und ruft
  `noLoop()` auf – jede Änderung löst `regen()` aus, das nur `redraw()`
  aufruft.
- **`draw()`**: holt den Pfad mit `otFont.getPath(txt, x, y, fontSize)`.
  Ist `showOutlines` aktiv, werden die Befehle `M`, `L`, `C`, `Q`, `Z` mit
  `vertex()`, `bezierVertex()` und `quadraticVertex()` gezeichnet. Danach
  wird der Pfad abgetastet, der Konturen- und Punktezähler in `index.html`
  (`#contCount`, `#ptCount`) aktualisiert und pro Punkt ein Kreis
  gezeichnet, eingerastet
  auf ein Gitter der Grösse `rasterSize` (das ist auch der
  Kreisdurchmesser).
- **`pathhelper.js` → `sampleOpentypePath()`**: geht die Pfadbefehle
  durch, beginnt bei jedem `M` eine neue Kontur, unterteilt Linien
  (`lineSub`) und tastet Kurven in Schritten von `step` mit `cubicAt()` /
  `quadAt()` ab. Gibt eine flache Liste von `{x, y, contour}`-Punkten
  zurück.
- **`keyPressed()`**: **O** blendet die Konturen ein und aus. Solange das
  Textfeld den Fokus hat, wird die Taste ignoriert, so lässt sich ein "o"
  tippen.

</div>
