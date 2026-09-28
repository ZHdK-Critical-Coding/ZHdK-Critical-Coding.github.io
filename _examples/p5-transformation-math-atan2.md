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

Demonstrates `atan2()`: for each of three crosses the angle from the cross
to the mouse is computed and used to rotate it, so all three point at the
mouse. The angle of the middle cross is shown in degrees.
A starting point for anything that should turn towards a point, such as
eyes, arrows or turrets.

## Installation

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Move the mouse over the canvas.

## Coding Help

- **`sketch.js` → `boxWidth` / `boxHeight`**: size of the two bars that
  form each cross.
- **`setup()`**: creates a 400 × 400 canvas and switches to
  `angleMode(DEGREES)`, so `atan2()` returns degrees instead of radians.
- **`draw()`**: computes `angle = atan2(mouseY - center.y, mouseX -
  center.x)` from the canvas centre, and in the same way `angleLeft` and
  `angleRight` from the positions of the other two crosses. Each cross is
  drawn inside `push()` / `pop()` with `translate()` to its position and
  `rotate()` by its own angle, so every cross points at the mouse.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Atan2

Zeigt, wie `atan2()` funktioniert: Für jedes der drei Kreuze wird der
Winkel vom Kreuz zur Maus berechnet und das Kreuz damit gedreht, sodass alle
drei auf die Maus zeigen. Der Winkel des mittleren Kreuzes wird in Grad
angezeigt. Ein Ausgangspunkt für alles, was sich zu einem Punkt hin
drehen soll, etwa Augen, Pfeile oder Geschütze.

## Installation

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die Maus über die Zeichenfläche bewegen.

## Coding-Hilfe

- **`sketch.js` → `boxWidth` / `boxHeight`**: Grösse der beiden Balken, aus
  denen jedes Kreuz besteht.
- **`setup()`**: erstellt eine Zeichenfläche von 400 × 400 px und stellt
  auf `angleMode(DEGREES)` um, damit `atan2()` Grad statt Bogenmass
  liefert.
- **`draw()`**: berechnet `angle = atan2(mouseY - center.y, mouseX -
  center.x)` von der Mitte aus und ebenso `angleLeft` und `angleRight` von
  den Positionen der beiden anderen Kreuze. Jedes Kreuz wird innerhalb von
  `push()` / `pop()` mit `translate()` an seine Position verschoben und mit
  `rotate()` um seinen eigenen Winkel gedreht, sodass jedes Kreuz auf die
  Maus zeigt.

</div>
