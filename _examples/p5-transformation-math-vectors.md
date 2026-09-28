---
title: Vectors
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Math_Vectors
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Math_Vectors
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Vectors

Two eyes follow the mouse. `p5.Vector` is used to limit the pupil movement
to the eyeball, and helper lines and points show the vectors involved. A
starting point for working with directions and distances using vectors.

Further reading: [Nature of Code – Vectors](https://natureofcode.com/vectors/),
[p5.Vector reference](https://p5js.org/reference/p5/p5.Vector/)

## Installation

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Move the mouse over the canvas.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## Coding Help

- **`sketch.js` → `draw()`**: computes the sizes from the canvas width:
  `eyeRadius` (width / 8), `pupilRadius` (eyeRadius / 6) and `maxOffset`,
  the furthest the pupil may move from the centre. Creates the two eye
  positions with `createVector()` and calls `drawEye()` for each.
- **`drawEye()`**: draws the eyeball, then builds `dir`, the vector from
  the eye centre to the mouse. If `dir.mag()` is larger than `maxOffset`,
  `dir.setMag(maxOffset)` shortens it without changing its direction. The
  pupil is drawn at `p5.Vector.add(center, dir)`.
- **Visualisation**: the line from the eye centre to the mouse, and red
  dots at the centre, at the mouse and where that line crosses the eyeball
  (the same direction scaled to `eyeRadius`). Remove this block for plain
  eyes.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Vectors

Zwei Augen folgen der Maus. Mit `p5.Vector` wird die Bewegung der Pupille
auf den Augapfel begrenzt, Hilfslinien und Punkte zeigen die beteiligten
Vektoren. Ein Ausgangspunkt, um mit Richtungen und Abständen als Vektoren
zu arbeiten.

Weiterlesen: [Nature of Code – Vectors](https://natureofcode.com/vectors/),
[p5.Vector-Referenz](https://p5js.org/reference/p5/p5.Vector/)

## Installation

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die Maus über die Zeichenfläche bewegen.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → `draw()`**: berechnet die Grössen aus der Breite der
  Zeichenfläche: `eyeRadius` (Breite / 8), `pupilRadius` (eyeRadius / 6)
  und `maxOffset`, wie weit sich die Pupille höchstens von der Mitte
  entfernen darf. Erstellt die zwei Augenpositionen mit `createVector()` und
  ruft für jede `drawEye()` auf.
- **`drawEye()`**: zeichnet den Augapfel und bildet dann `dir`, den Vektor
  von der Augenmitte zur Maus. Ist `dir.mag()` grösser als `maxOffset`,
  kürzt `dir.setMag(maxOffset)` ihn, ohne die Richtung zu ändern. Die
  Pupille wird bei `p5.Vector.add(center, dir)` gezeichnet.
- **Visualisierung**: die Linie von der Augenmitte zur Maus sowie rote
  Punkte in der Mitte, bei der Maus und dort, wo die Linie den Augapfel
  schneidet (dieselbe Richtung, auf `eyeRadius` skaliert). Für schlichte
  Augen diesen Block entfernen.

</div>
