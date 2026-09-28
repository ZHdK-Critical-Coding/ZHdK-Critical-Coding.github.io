---
title: Particles
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Simulation_Particles
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Simulation_Particles
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Particles

A simple particle system: every frame a new particle – a random letter of
"ZHDK" – is emitted at the bottom centre with a random force and mass,
rises, is pulled back by gravity and is removed when it leaves the canvas.
A starting point for particle simulations.

See also: [Nature of Code – Particles](https://natureofcode.com/particles/)

## Installation

Requirements: a current browser.

Libraries (in `libraries/`): p5.js 1.10.0 (p5.sound 1.0.1 is in the
folder but not loaded).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).

## Coding Help

- **`sketch.js` → `update()`**: creates one `Particle` per frame with a
  random mass (0.75–2) and applies a random `startForce` (slightly
  sideways, upwards). Change these ranges to change the fountain.
- **`sketch.js` → `draw()`**: calls `update()`, draws all particles, removes
  the dead ones and prints the current particle count.
- **`particle.js` → `Particle`**: the constructor sets position (bottom
  centre by default), mass, a small `gravity` vector and the letter.
  `applyForce()` stores the force; `update()` divides it by the mass, adds
  it to the acceleration and adds `gravity` to the force each frame, so the
  particle slows down and falls back.
- **`show()`**: colours the letter from red to blue depending on its height
  and sets the text size from the mass (`mass² * 5`).
- **`checkEdges()`**: marks the particle `dead` as soon as it leaves the
  canvas.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Particles

Ein einfaches Partikelsystem: In jedem Frame wird unten in der Mitte ein
neues Partikel – ein zufälliger Buchstabe aus "ZHDK" – mit zufälliger Kraft
und Masse ausgestossen. Es steigt auf, wird von der Schwerkraft
zurückgezogen und entfernt, sobald es die Zeichenfläche verlässt. Ein
Ausgangspunkt für Partikelsimulationen.

Siehe auch: [Nature of Code – Particles](https://natureofcode.com/particles/)

## Installation

Voraussetzungen: ein aktueller Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0 (p5.sound 1.0.1 liegt im
Ordner, wird aber nicht geladen).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).

## Coding-Hilfe

- **`sketch.js` → `update()`**: erzeugt pro Frame ein `Particle` mit
  zufälliger Masse (0.75–2) und gibt ihm eine zufällige Startkraft
  `startForce` (leicht seitlich, nach oben). Diese Bereiche ändern, um die Fontäne zu verändern.
- **`sketch.js` → `draw()`**: ruft `update()` auf, zeichnet alle Partikel,
  entfernt die toten und zeigt die aktuelle Anzahl an.
- **`particle.js` → `Particle`**: Der Konstruktor setzt Position
  (standardmässig unten in der Mitte), Masse, einen kleinen
  `gravity`-Vektor und den Buchstaben. `applyForce()` speichert die Kraft;
  `update()` teilt sie durch die Masse, addiert sie zur Beschleunigung und
  zählt in jedem Frame `gravity` zur Kraft dazu – so wird das Partikel
  langsamer und fällt zurück.
- **`show()`**: färbt den Buchstaben je nach Höhe von Rot nach Blau und
  setzt die Textgrösse aus der Masse (`mass² * 5`).
- **`checkEdges()`**: markiert das Partikel als `dead`, sobald es die
  Zeichenfläche verlässt.

</div>
