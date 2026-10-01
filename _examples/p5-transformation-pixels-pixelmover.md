---
title: Pixelmover
maincategory: code-samples
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Pixels_Pixelmover
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Pixels_Pixelmover
screenshot: "/assets/examples/p5-transformation-pixels-pixelmover/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Pixelmover

Samples the pixels of an image on a grid and turns each one into a coloured
square particle. Squares near the mouse are magnified; a click lets all
pixels fall, bounce on the bottom edge and disappear. A starting point for
image-based particle effects.

## Installation

Requirements: a current browser.

To use another image, replace `assets/150.jpg` or change the path in
`preload()`.

Libraries (in `libraries/`): p5.js 1.10.0.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Move the mouse over the image to magnify the pixels.
3. Click on the canvas to let the pixels fall down.

## Coding Help

- **`sketch.js` → globals**: `gridSize` (size of a pixel square in canvas
  pixels), `gravity` and `damping` (how fast the squares fall and how much
  they bounce) are the values to play with.
- **`createCharParticles()`**: scales the image down to
  `windowWidth / gridSize` pixels wide, reads `img.pixels` (4 values per
  pixel: r, g, b, a) and creates one `CharParticle` per pixel. Fully
  transparent pixels (alpha 0, only in PNG images) are skipped.
- **`draw()`**: sorts the particles by `getScale()` so magnified squares are
  drawn on top, updates them once `falling` is true and removes dead ones.
- **`mousePressed()`**: sets `falling = true`.
- **`CharParticle`**: `update()` applies gravity and bounces the square at
  the bottom edge; once the bounce speed drops below 0.3 it is marked
  `dead`. `getScale()` enlarges squares within `scaleBounds` (100 px) of the
  mouse; `show()` draws the square centred on its position.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Pixelmover

Tastet die Pixel eines Bildes in einem Raster ab und macht aus jedem ein
farbiges, quadratisches Partikel. Quadrate in der Nähe der Maus werden
vergrössert; ein Klick lässt alle Pixel fallen, am unteren Rand abprallen
und verschwinden. Ein Ausgangspunkt für bildbasierte Partikeleffekte.

## Installation

Voraussetzungen: ein aktueller Browser.

Für ein anderes Bild `assets/150.jpg` ersetzen oder den Pfad in `preload()`
ändern.

Bibliotheken (in `libraries/`): p5.js 1.10.0.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die Maus über das Bild bewegen, um die Pixel zu vergrössern.
3. Auf die Zeichenfläche klicken, um die Pixel fallen zu lassen.

## Coding-Hilfe

- **`sketch.js` → globale Variablen**: `gridSize` (Grösse eines
  Pixel-Quadrats in Canvas-Pixeln), `gravity` und `damping` (wie schnell die
  Quadrate fallen und wie stark sie abprallen) sind die Werte zum
  Ausprobieren.
- **`createCharParticles()`**: skaliert das Bild auf `windowWidth /
  gridSize` Pixel Breite, liest `img.pixels` (4 Werte pro Pixel: r, g, b, a)
  und erzeugt pro Pixel ein `CharParticle`. Vollständig transparente Pixel
  (Alpha 0, nur bei PNG-Bildern) werden übersprungen.
- **`draw()`**: sortiert die Partikel nach `getScale()`, damit vergrösserte
  Quadrate zuoberst liegen, bewegt sie, sobald `falling` wahr ist, und
  entfernt tote Partikel.
- **`mousePressed()`**: setzt `falling = true`.
- **`CharParticle`**: `update()` wendet die Schwerkraft an und lässt das
  Quadrat am unteren Rand abprallen; fällt die Abprallgeschwindigkeit unter
  0.3, wird es als `dead` markiert. `getScale()` vergrössert Quadrate im
  Umkreis von `scaleBounds` (100 px) um die Maus; `show()` zeichnet das
  Quadrat zentriert auf seiner Position.

</div>
