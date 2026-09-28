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

To use another picture, put it in `assets/` and change the path in
`preload()`.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).

## Coding Help

- **`sketch.js` → `fontCharacters`**: the characters from light to dark
  (space first, `$` last). Try shorter strings or other symbols.
- **`preload()`**: loads the image.
- **`setup()`**: creates a full-window canvas,
  sets the text style (Courier New, bold, size 6), then the grid:
  `cols = windowWidth / 4` and `rows` from the image's aspect ratio,
  corrected by the width-to-height ratio of a character cell
  (`textWidth('M') / textSize()`). Resizes the image to `cols` × `rows` and
  draws once with `noLoop()`.
- **`draw()`**: loops over all pixels of the small image, averages R, G and
  B and uses `map()` to pick the matching character. Each character is
  placed in the middle of its cell (`x * charWidth + charWidth / 2`,
  `y * textSize() + textSize() / 2`, because of `textAlign(CENTER,
  CENTER)`); change the spacing here.
- **`averageBrightness()`**: a simple average of R, G and B. It has its
  own name so p5's `brightness()` function stays available.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: ASCII

Wandelt das Bild `assets/150.jpg` in ASCII-Art um: Das Bild wird
verkleinert, die Helligkeit jedes Pixels einem Zeichen aus einer
Dichte-Zeichenkette zugeordnet und als Text gezeichnet. Ein Ausgangspunkt
für textbasierte Bildeffekte.

## Installation

Für ein anderes Bild dieses in `assets/` ablegen und den Pfad in
`preload()` ändern.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).

## Coding-Hilfe

- **`sketch.js` → `fontCharacters`**: die Zeichen von hell nach dunkel
  (zuerst das Leerzeichen, zuletzt `$`). Kürzere Zeichenketten oder andere
  Symbole ausprobieren.
- **`preload()`**: lädt das Bild.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, setzt den
  Textstil (Courier New, fett, Grösse 6) und legt dann das Raster fest:
  `cols = windowWidth / 4` und `rows` aus dem Seitenverhältnis des Bildes,
  korrigiert um das Breite-zu-Höhe-Verhältnis einer Zeichenzelle
  (`textWidth('M') / textSize()`). Verkleinert das Bild auf `cols` ×
  `rows` und zeichnet mit `noLoop()` einmal.
- **`draw()`**: geht alle Pixel des kleinen Bildes durch, mittelt R, G und
  B und wählt mit `map()` das passende Zeichen. Jedes Zeichen wird in der
  Mitte seiner Zelle platziert (`x * charWidth + charWidth / 2`,
  `y * textSize() + textSize() / 2`, wegen `textAlign(CENTER, CENTER)`);
  hier die Abstände anpassen.
- **`averageBrightness()`**: ein einfacher Mittelwert aus R, G und B. Sie
  hat einen eigenen Namen, damit die p5-Funktion `brightness()` verfügbar
  bleibt.

</div>
