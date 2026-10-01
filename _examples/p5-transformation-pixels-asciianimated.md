---
title: ASCII Animated
maincategory: code-samples
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Pixels_ASCIIAnimated
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Pixels_ASCIIAnimated
screenshot: "/assets/examples/p5-transformation-pixels-asciianimated/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: ASCII Animated

Renders the image `assets/150.jpg` as ASCII art in which every character is
a particle. A click lets all characters fall down, bounce on the bottom
edge and disappear once they come to rest. Uses [q5.js](https://q5js.org),
a faster p5.js-compatible library, instead of p5.js.

## Installation

To use another picture, put it in `assets/` and change the path in
`preload()`.

Libraries (in `libraries/`): q5.js 3.3.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Click on the canvas to let the characters fall.

## Coding Help

- **`sketch.js` → settings at the top**: `fontCharacters` (characters from
  light to dark), `gravity` (0.5), `damping` (0.7, how much of the speed
  is kept on a bounce), `fontSize` (12) and `fontClass` (Courier New).
- **`setup()`**: creates a full-window canvas, computes `cols` (one
  character per 12 px) and `rows` from the image's aspect ratio, resizes
  the image and calls `createCharParticles()`.
- **`createCharParticles()`**: centres the grid on the canvas and creates
  one `CharParticle` per pixel with the pixel's average brightness.
- **`getGlyph()`**: renders a character once into a small
  `createGraphics()` buffer and keeps it in `glyphs`, so every character
  exists only once, no matter how many particles show it.
- **`class CharParticle`**: picks the character for the brightness and
  gets its pre-rendered buffer from `getGlyph()`. Gravity and
  damping vary slightly per particle. `update()` lets it fall and bounce;
  when the bounce speed drops below 0.3 it is marked `dead`. `show()` draws
  the buffer.
- **`draw()`**: updates the particles once `falling` is set, draws them,
  removes dead ones and shows the particle count and frame rate top left.
- **`mousePressed()`**: sets `falling = true`.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: ASCII Animated

Stellt das Bild `assets/150.jpg` als ASCII-Art dar, in der jedes Zeichen
ein Partikel ist. Ein Klick lässt alle Zeichen herunterfallen, am unteren
Rand abprallen und verschwinden, sobald sie zur Ruhe kommen. Verwendet
statt p5.js [q5.js](https://q5js.org), eine schnellere, zu p5.js
kompatible Bibliothek.

## Installation

Für ein anderes Bild dieses in `assets/` ablegen und den Pfad in
`preload()` ändern.

Bibliotheken (in `libraries/`): q5.js 3.3.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Auf die Zeichenfläche klicken, um die Zeichen fallen zu lassen.

## Coding-Hilfe

- **`sketch.js` → Einstellungen oben**: `fontCharacters` (Zeichen von hell
  nach dunkel), `gravity` (0.5), `damping` (0.7, wie viel der
  Geschwindigkeit beim Abprallen erhalten bleibt), `fontSize` (12) und
  `fontClass` (Courier New).
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, berechnet
  `cols` (ein Zeichen pro 12 px) und `rows` aus dem Seitenverhältnis des
  Bildes, verkleinert das Bild und ruft `createCharParticles()` auf.
- **`createCharParticles()`**: zentriert das Raster auf der Zeichenfläche
  und erstellt pro Pixel ein `CharParticle` mit der mittleren Helligkeit des
  Pixels.
- **`getGlyph()`**: zeichnet ein Zeichen einmal in einen kleinen
  `createGraphics()`-Buffer und speichert ihn in `glyphs`, so gibt es jedes
  Zeichen nur einmal, egal wie viele Partikel es zeigen.
- **`class CharParticle`**: wählt das Zeichen zur Helligkeit und holt den
  vorab gezeichneten Buffer mit `getGlyph()`. Schwerkraft
  und Dämpfung variieren pro Partikel leicht. `update()` lässt es fallen und
  abprallen; fällt die Geschwindigkeit beim Abprallen unter 0.3, wird es als
  `dead` markiert. `show()` zeichnet den Buffer.
- **`draw()`**: aktualisiert die Partikel, sobald `falling` gesetzt ist,
  zeichnet sie, entfernt tote Partikel und zeigt oben links die Anzahl
  Partikel und die Framerate an.
- **`mousePressed()`**: setzt `falling = true`.

</div>
