---
title: Image Morph
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Pixels_Morph
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Pixels_Morph
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Image Morph

Morphs one bitmap into another. A morph is more than a fade: matching
features travel from one image to the other (the warp) while the pixels
cross-blend (the dissolve). The example turns a caterpillar (`2.png`) into
a cocoon (`1.png`), rendered as dithered 1-bit black and white; a slider
scrubs between the two.

![caterpillar ↔ cocoon](../../assets/examples/p5-transformation-pixels-morph/2.png)

## Installation

Requirements: a browser and an internet connection (p5.js is loaded from a
CDN). The sketch reads image pixels, which only works over HTTP – opening
`index.html` directly from `file://` does not work.

Libraries: p5.js 1.9.4 (from jsDelivr, linked in `index.html`).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar). Any static server works too, e.g.
   `python3 -m http.server` and then `http://localhost:8000`.
2. Drag the slider below the image.

## Coding Help

| File         | Role                                                          |
|--------------|---------------------------------------------------------------|
| `index.html` | Loads p5.js (from CDN), then `morph.js` and `sketch.js`.      |
| `morph.js`   | The morph engine: triangulation, warp, sampling, dithering.   |
| `sketch.js`  | Loads the images, sets up the slider, draws the morph.        |
| `1.png`      | Image B – cocoon (224 × 128).                                 |
| `2.png`      | Image A – caterpillar (224 × 128).                            |

- **`sketch.js` → `ptsA` / `ptsB`**: the feature points in image pixels
  (0…223 × 0…127). `ptsA[i]` on image A marks the same feature as
  `ptsB[i]` on image B. Keep both arrays the same length and list only
  interior points; the four corners are added automatically.
- **`preload()` / `IMG_W` / `IMG_H`**: the two images and their size. For
  other images change the filenames, update the size and re-place the
  feature points.
- **`setup()` / `draw()`**: create the canvas, the `Morph` and the slider.
  The morph is expensive, so `noLoop()` is set and `draw()` only runs when
  the slider moves; it passes the slider value to `morph.setAmount()` and
  draws `morph.render()`.
- **`morph.js` → `delaunay()`**: Delaunay triangulation
  ([Bowyer–Watson](https://en.wikipedia.org/wiki/Bowyer%E2%80%93Watson_algorithm))
  without an external library. `Morph.retriangulate()` triangulates the
  midpoints of the A/B pairs, so all point sets share one topology.
- **`Morph.render()` / `_rasterize()`**: interpolates every feature point
  from A to B by the morph amount `t`. For every pixel of each in-between
  triangle, [barycentric coordinates](https://en.wikipedia.org/wiki/Barycentric_coordinate_system)
  locate the matching spot in triangle A and B; both images are sampled
  there (`sampleLuma()`, bilinear) and blended by `t`.
- **`floydSteinberg()`**: reduces the grayscale result to black and white
  with error diffusion, for the stippled look.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Image Morph

Morpht eine Bitmap in eine andere. Ein Morph ist mehr als eine
Überblendung: Einander entsprechende Merkmale wandern von einem Bild zum
anderen (Warp), während die Pixel überblenden (Dissolve). Im Beispiel wird
aus einer Raupe (`2.png`) ein Kokon (`1.png`), dargestellt als geditherte
1-Bit-Schwarzweissgrafik; ein Schieberegler wechselt stufenlos zwischen den
beiden.

![Raupe ↔ Kokon](../../assets/examples/p5-transformation-pixels-morph/2.png)

## Installation

Voraussetzungen: ein Browser und eine Internetverbindung (p5.js wird von
einem CDN geladen). Der Sketch liest Bildpixel aus, was nur über HTTP
funktioniert – `index.html` direkt über `file://` zu öffnen geht nicht.

Bibliotheken: p5.js 1.9.4 (von jsDelivr, eingebunden in `index.html`).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken). Jeder andere statische Server geht
   auch, z. B. `python3 -m http.server` und dann `http://localhost:8000`.
2. Den Schieberegler unter dem Bild bewegen.

## Coding-Hilfe

| Datei        | Aufgabe                                                        |
|--------------|----------------------------------------------------------------|
| `index.html` | Lädt p5.js (vom CDN), dann `morph.js` und `sketch.js`.         |
| `morph.js`   | Die Morph-Engine: Triangulation, Warp, Abtastung, Dithering.   |
| `sketch.js`  | Lädt die Bilder, erstellt den Schieberegler, zeichnet den Morph. |
| `1.png`      | Bild B – Kokon (224 × 128).                                    |
| `2.png`      | Bild A – Raupe (224 × 128).                                    |

- **`sketch.js` → `ptsA` / `ptsB`**: die Merkmalspunkte in Bildpixeln
  (0…223 × 0…127). `ptsA[i]` auf Bild A markiert dasselbe Merkmal wie
  `ptsB[i]` auf Bild B. Beide Arrays gleich lang halten und nur innere
  Punkte eintragen; die vier Ecken werden automatisch ergänzt.
- **`preload()` / `IMG_W` / `IMG_H`**: die beiden Bilder und ihre Grösse.
  Für andere Bilder die Dateinamen ändern, die Grösse anpassen und die
  Merkmalspunkte neu setzen.
- **`setup()` / `draw()`**: erstellen die Zeichenfläche, den `Morph` und den
  Schieberegler. Der Morph ist aufwendig zu berechnen, deshalb ist
  `noLoop()` gesetzt und `draw()` läuft nur, wenn der Regler bewegt wird;
  es übergibt den Reglerwert an `morph.setAmount()` und zeichnet
  `morph.render()`.
- **`morph.js` → `delaunay()`**: Delaunay-Triangulation
  ([Bowyer–Watson](https://en.wikipedia.org/wiki/Bowyer%E2%80%93Watson_algorithm))
  ohne externe Bibliothek. `Morph.retriangulate()` trianguliert die
  Mittelpunkte der A/B-Paare, damit alle Punktmengen dieselbe Topologie
  haben.
- **`Morph.render()` / `_rasterize()`**: interpoliert jeden Merkmalspunkt
  mit dem Morph-Wert `t` von A nach B. Für jedes Pixel jedes
  Zwischendreiecks finden
  [baryzentrische Koordinaten](https://de.wikipedia.org/wiki/Baryzentrische_Koordinaten)
  die passende Stelle in Dreieck A und B; beide Bilder werden dort
  abgetastet (`sampleLuma()`, bilinear) und mit `t` gemischt.
- **`floydSteinberg()`**: reduziert das Graustufenergebnis mit
  Fehlerdiffusion auf Schwarz und Weiss, für den gepunkteten Look.

</div>
