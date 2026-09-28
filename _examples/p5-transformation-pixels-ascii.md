---
title: ASCII
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Pixels_ASCII
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Pixels_ASCII
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: ASCII

Converts the image `assets/150.jpg` into ASCII art: the image is scaled
down, the brightness of each pixel is mapped to a character from a density
string and drawn as text. A starting point for text-based image effects.

## Installation

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).

To use another picture, put it in `assets/` and change the path in
`preload()`.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## Coding Help

- **`sketch.js` → `fontCharacters`**: the characters from light to dark
  (space first, `$` last). Try shorter strings or other symbols.
- **`preload()`**: loads the image.
- **`setup()`**: creates a full-window canvas and sets the grid:
  `cols = windowWidth / 4`, `rows = cols / 3` (fixed ratio, not the image's
  aspect ratio). Sets the text style (Courier New, bold, size 6, leading
  10), resizes the image to `cols` × `rows` and draws once with `noLoop()`.
- **`draw()`**: loops over all pixels of the small image, averages R, G and
  B and uses `map()` to pick the matching character. Each character is
  placed at `x * charWidth` and `y * textSize() - textLeading()`; change
  the spacing here.
- **`brightness()`**: a simple average of R, G and B. It replaces p5's own
  `brightness()` function in this sketch.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: ASCII

Wandelt das Bild `assets/150.jpg` in ASCII-Art um: Das Bild wird
verkleinert, die Helligkeit jedes Pixels einem Zeichen aus einer
Dichte-Zeichenkette zugeordnet und als Text gezeichnet. Ein Ausgangspunkt
für textbasierte Bildeffekte.

## Installation

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).

Für ein anderes Bild dieses in `assets/` ablegen und den Pfad in
`preload()` ändern.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → `fontCharacters`**: die Zeichen von hell nach dunkel
  (zuerst das Leerzeichen, zuletzt `$`). Kürzere Zeichenketten oder andere
  Symbole ausprobieren.
- **`preload()`**: lädt das Bild.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche und legt das
  Raster fest: `cols = windowWidth / 4`, `rows = cols / 3` (festes
  Verhältnis, nicht das Seitenverhältnis des Bildes). Setzt den Textstil
  (Courier New, fett, Grösse 6, Zeilenabstand 10), verkleinert das Bild auf
  `cols` × `rows` und zeichnet mit `noLoop()` einmal.
- **`draw()`**: geht alle Pixel des kleinen Bildes durch, mittelt R, G und
  B und wählt mit `map()` das passende Zeichen. Jedes Zeichen wird bei
  `x * charWidth` und `y * textSize() - textLeading()` platziert; hier die
  Abstände anpassen.
- **`brightness()`**: ein einfacher Mittelwert aus R, G und B. Sie ersetzt
  in diesem Sketch die p5-eigene Funktion `brightness()`.

</div>
