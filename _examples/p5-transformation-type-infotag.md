---
title: Infotag
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Type_Infotag
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Type_Infotag
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Infotag

A small tool for animated text tags: layers of the text with growing,
alternating black and white outlines are stacked on top of each other.
Text, speed and interval can be changed, and one loop of the animation can
be exported as a GIF. Useful for signage, social media loops or as a
starting point for type animation.

## Installation

Requirements: a current browser.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Enter a text and press **UPDATE**.
3. Adjust **Speed** and **Interval**.
4. Press **EXPORT one Iteration as GIF** to download the animation.

## Coding Help

- **`sketch.js` → `setup()`**: creates the 800 × 300 canvas and the
  controls with p5 DOM functions: text input + **UPDATE** button (sets
  `writer`), **Speed** slider `s1` (1–10), **Interval** slider `s2`
  (1–100 frames) and the export button. Change the canvas size here.
- **`draw()`**: every `s2` frames a new `Layer` is added and `mode`
  switches between black and white. If an export was requested, it starts
  at that moment with `saveGif('mySketch', s2 * 2, { units: 'frames' })`,
  i.e. exactly one black/white cycle.
- **`Layer`**: draws the text centred with the fill in one colour and the
  outline in the other. `borderWidth` grows by `s1` every frame; when it
  exceeds the canvas height the layer is removed. Font size (`height / 2`)
  and position are set in `draw()`.
- A commented-out `keyPressed()` shows how to type the text directly on
  the canvas instead of using the input field.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Infotag

Ein kleines Tool für animierte Text-Tags: Ebenen des Textes mit
wachsenden, abwechselnd schwarzen und weissen Konturen werden übereinander
gestapelt. Text, Geschwindigkeit und Intervall lassen sich ändern, und ein
Durchlauf der Animation kann als GIF exportiert werden. Nützlich für
Signaletik, Social-Media-Loops oder als Ausgangspunkt für
Schriftanimationen.

## Installation

Voraussetzungen: ein aktueller Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Einen Text eingeben und auf **UPDATE** klicken.
3. **Speed** und **Interval** einstellen.
4. Auf **EXPORT one Iteration as GIF** klicken, um die Animation
   herunterzuladen.

## Coding-Hilfe

- **`sketch.js` → `setup()`**: erstellt die Zeichenfläche (800 × 300) und
  die Bedienelemente mit p5-DOM-Funktionen: Texteingabe + Knopf
  **UPDATE** (setzt `writer`), Slider **Speed** `s1` (1–10), Slider
  **Interval** `s2` (1–100 Frames) und den Export-Knopf. Die Grösse der
  Zeichenfläche hier ändern.
- **`draw()`**: Alle `s2` Frames kommt eine neue `Layer` dazu und `mode`
  wechselt zwischen Schwarz und Weiss. Wurde ein Export angefordert,
  startet er genau in diesem Moment mit
  `saveGif('mySketch', s2 * 2, { units: 'frames' })` – also genau ein
  Schwarz/Weiss-Zyklus.
- **`Layer`**: zeichnet den Text zentriert, die Füllung in der einen, die
  Kontur in der anderen Farbe. `borderWidth` wächst pro Frame um `s1`;
  wird sie grösser als die Höhe der Zeichenfläche, wird die Ebene entfernt.
  Schriftgrösse (`height / 2`) und Position werden in `draw()` gesetzt.
- Ein auskommentiertes `keyPressed()` zeigt, wie man den Text direkt auf
  der Zeichenfläche statt im Eingabefeld tippen kann.

</div>
