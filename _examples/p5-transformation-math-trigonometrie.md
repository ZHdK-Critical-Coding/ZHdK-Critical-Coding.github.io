---
title: Trigonometry
maincategory: code-samples
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Math_Trigonometrie
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Math_Trigonometrie
screenshot: "/assets/examples/p5-transformation-math-trigonometrie/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Trigonometry

Visualises `sin()`, `cos()` and `tan()` as three animated dots that run
across the screen and leave a trail behind. Each curve is an instance of a
small class, so frequency, speed and trail can be set per curve. Useful for
getting a feel for the trigonometric functions and for building
oscillating motion.

## Installation

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).

## Coding Help

- **`sketch.js` → `setup()`**: creates a full-window canvas and adds three
  curves to `curves`: `sin` in red, `cos` in green, `tan` in blue. Add,
  remove or change curves here.
- **`draw()`**: clears the background with `backgroundColor` and calls `draw()` on every curve.
- **`class trigonometryCurve`**: the constructor takes the function, the
  colour and optionally `frequency` (number of periods across the width,
  default 2), `trailSize` (number of stored points, 100), `speed` (degrees
  per frame, 2) and `dotsize` (25). It sets `angleMode(DEGREES)`.
- **`trigonometryCurve.draw()`**: computes x from `frameCount` (wrapping
  at the right edge) and y from the trig function, stores the point and
  keeps only the last `trailSize` points. Older points are drawn smaller
  and fade towards the background colour (`backgroundColor`, blended with
  `lerpColor()`). y is scaled by a quarter of the height around the middle;
  points that would land outside the canvas (`tan()` near its poles) are
  skipped.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Trigonometry

Visualisiert `sin()`, `cos()` und `tan()` als drei animierte Punkte, die
über den Bildschirm laufen und eine Spur hinter sich herziehen. Jede Kurve
ist eine Instanz einer kleinen Klasse, so lassen sich Frequenz,
Geschwindigkeit und Spur pro Kurve einstellen. Hilfreich, um ein Gefühl für
die Winkelfunktionen zu bekommen und schwingende Bewegungen zu bauen.

## Installation

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).

## Coding-Hilfe

- **`sketch.js` → `setup()`**: erstellt eine fensterfüllende Zeichenfläche
  und fügt `curves` drei Kurven hinzu: `sin` in Rot, `cos` in Grün, `tan`
  in Blau. Hier Kurven hinzufügen, entfernen oder ändern.
- **`draw()`**: löscht den Hintergrund mit `backgroundColor` und ruft `draw()` jeder Kurve auf.
- **`class trigonometryCurve`**: Der Konstruktor nimmt die Funktion, die
  Farbe und optional `frequency` (Anzahl Perioden über die Breite, Standard
  2), `trailSize` (Anzahl gespeicherter Punkte, 100), `speed` (Grad pro
  Frame, 2) und `dotsize` (25). Er setzt `angleMode(DEGREES)`.
- **`trigonometryCurve.draw()`**: berechnet x aus `frameCount` (am rechten
  Rand beginnt es wieder links) und y aus der Winkelfunktion, speichert den
  Punkt und behält nur die letzten `trailSize` Punkte. Ältere Punkte werden
  kleiner gezeichnet und gehen in die Hintergrundfarbe über
  (`backgroundColor`, gemischt mit `lerpColor()`). y wird mit einem Viertel
  der Höhe um die Mitte skaliert; Punkte, die ausserhalb der Zeichenfläche
  landen würden (`tan()` in der Nähe der Polstellen), werden übersprungen.

</div>
