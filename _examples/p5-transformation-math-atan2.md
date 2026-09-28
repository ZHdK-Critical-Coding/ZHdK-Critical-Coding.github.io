---
title: Atan2
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Math_Atan2
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Math_Atan2
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Atan2

Demonstrates `atan2()`: the angle from the canvas centre to the mouse is
computed and used to rotate three crosses. The angle is shown in degrees.
A starting point for anything that should turn towards a point, such as
eyes, arrows or turrets.

## Installation

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Move the mouse over the canvas.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## Coding Help

- **`sketch.js` → `boxWidth` / `boxHeight`**: size of the two bars that
  form each cross.
- **`setup()`**: creates a 400 × 400 canvas and switches to
  `angleMode(DEGREES)`, so `atan2()` returns degrees instead of radians.
- **`draw()`**: computes `angle = atan2(mouseY - center.y, mouseX -
  center.x)` once from the canvas centre. Each cross is drawn inside
  `push()` / `pop()` with `translate()` to its position and `rotate(angle)`.
  Because all three use the same angle, only the green one in the middle
  points exactly at the mouse. For each cross to aim at the mouse on its
  own, compute `atan2()` from that cross's position.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Atan2

Zeigt, wie `atan2()` funktioniert: Der Winkel von der Mitte der
Zeichenfläche zur Maus wird berechnet und dreht drei Kreuze. Der Winkel wird
in Grad angezeigt. Ein Ausgangspunkt für alles, was sich zu einem Punkt hin
drehen soll, etwa Augen, Pfeile oder Geschütze.

## Installation

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die Maus über die Zeichenfläche bewegen.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → `boxWidth` / `boxHeight`**: Grösse der beiden Balken, aus
  denen jedes Kreuz besteht.
- **`setup()`**: erstellt eine Zeichenfläche von 400 × 400 px und stellt
  auf `angleMode(DEGREES)` um, damit `atan2()` Grad statt Bogenmass
  liefert.
- **`draw()`**: berechnet `angle = atan2(mouseY - center.y, mouseX -
  center.x)` einmal von der Mitte aus. Jedes Kreuz wird innerhalb von
  `push()` / `pop()` mit `translate()` an seine Position verschoben und mit
  `rotate(angle)` gedreht. Weil alle drei denselben Winkel verwenden, zeigt
  nur das grüne Kreuz in der Mitte genau auf die Maus. Damit jedes Kreuz
  selbst auf die Maus zielt, `atan2()` von seiner eigenen Position aus
  berechnen.

</div>
