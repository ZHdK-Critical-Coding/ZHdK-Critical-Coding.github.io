---
title: Modbuttons
maincategory: code-samples
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_UserInterfaces_Modbuttons
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_UserInterfaces_Modbuttons
screenshot: "/assets/examples/p5-transformation-userinterfaces-modbuttons/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Modbuttons

Shows [Modbuttons](https://github.com/yetyeeter1337/Modbuttons), a simple
and modular button system for p5.js: a custom-drawn button, a stepped
slider and a stepped, continuous dial, with their current state printed on the canvas.
Useful for building interfaces that are drawn directly on the canvas
instead of using HTML elements.

## Installation

Requirements: a current browser.

To use Modbuttons in another project, copy `libraries/p5.modbuttons.js` and
load it in `index.html` after p5.js and before your sketch:

```html
<script src="./libraries/p5.modbuttons.js"></script>
```

Full documentation: [Modbuttons wiki](https://github.com/yetyeeter1337/Modbuttons/wiki),
online example: [p5.js editor](https://editor.p5js.org/7vector/sketches/7DXk4U_iW).

Libraries (in `libraries/`): p5.js 1.10.0, p5.modbuttons.js (Modbuttons
V2 by 7vector), p5.sound 1.0.1 (included, not loaded).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Hover and press the **INITIALIZE** button, drag the slider and the dial.

## Coding Help

- **`sketch.js` → top level**: the widgets are created outside of
  `setup()` and configured through their properties:
  - `new Dial(continuous, x, y)` – `radius`, `segments` (steps; 0 =
    smooth), `minAngle` / `maxAngle` (ignored when `continuous` is true).
  - `new Slider(type, vertical, x, y)` – `type` "box" or "circle",
    `Slength` (track length), `smooth` and `segments`.
  - `new Button(type, x, y)` – `width`, `height`, `fill`, `stroke`,
    `strokeWeight`, plus own properties such as `text` and `textSize`.
- **Custom look and behaviour**: override `render()` to draw the widget
  yourself (as done for the button) and the event hooks `onHoverBegin()`,
  `onHoverEnd()`, `onPressBegin()`, `onPressEnd()` (also `onHover()`,
  `onPress()`, `onValueChange()`).
- **`draw()`**: only draws the background and reads the state:
  `testButton.pressed`, `testButton.hover`, `testSlider.value`,
  `testDial.value`. The widgets update and draw themselves after `draw()`
  through a p5 `post` hook in the library.
- **`libraries/p5.modbuttons.js`**: besides the classes it offers
  `disableAllButtons()`, `saveButtonStatus()` / `loadButtonStatus()` and
  `enable()` / `disable()` per widget. `Dial` calculates in
  `angleMode(DEGREES)` internally and then restores the sketch's own angle
  mode.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Modbuttons

Zeigt [Modbuttons](https://github.com/yetyeeter1337/Modbuttons), ein
einfaches, modulares Button-System für p5.js: einen selbst gezeichneten
Knopf, einen gestuften Slider und einen gestuften, endlos drehbaren Drehregler; ihr aktueller
Zustand wird auf der Zeichenfläche angezeigt. Nützlich für Oberflächen, die
direkt auf die Zeichenfläche gezeichnet werden statt mit HTML-Elementen.

## Installation

Voraussetzungen: ein aktueller Browser.

Um Modbuttons in einem anderen Projekt zu verwenden,
`libraries/p5.modbuttons.js` kopieren und in `index.html` nach p5.js und
vor dem Sketch laden:

```html
<script src="./libraries/p5.modbuttons.js"></script>
```

Vollständige Dokumentation: [Modbuttons-Wiki](https://github.com/yetyeeter1337/Modbuttons/wiki),
Online-Beispiel: [p5.js-Editor](https://editor.p5js.org/7vector/sketches/7DXk4U_iW).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.modbuttons.js
(Modbuttons V2 von 7vector), p5.sound 1.0.1 (vorhanden, nicht geladen).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Mit der Maus über den Knopf **INITIALIZE** fahren und ihn drücken,
   Slider und Drehregler ziehen.

## Coding-Hilfe

- **`sketch.js` → oberste Ebene**: Die Elemente werden ausserhalb von
  `setup()` erstellt und über ihre Eigenschaften konfiguriert:
  - `new Dial(continuous, x, y)` – `radius`, `segments` (Stufen; 0 =
    stufenlos), `minAngle` / `maxAngle` (ignoriert, wenn `continuous` wahr
    ist).
  - `new Slider(type, vertical, x, y)` – `type` "box" oder "circle",
    `Slength` (Länge der Bahn), `smooth` und `segments`.
  - `new Button(type, x, y)` – `width`, `height`, `fill`, `stroke`,
    `strokeWeight` sowie eigene Eigenschaften wie `text` und `textSize`.
- **Eigenes Aussehen und Verhalten**: `render()` überschreiben, um das
  Element selbst zu zeichnen (wie beim Knopf), sowie die Event-Hooks
  `onHoverBegin()`, `onHoverEnd()`, `onPressBegin()`, `onPressEnd()` (auch
  `onHover()`, `onPress()`, `onValueChange()`).
- **`draw()`**: zeichnet nur den Hintergrund und liest den Zustand aus:
  `testButton.pressed`, `testButton.hover`, `testSlider.value`,
  `testDial.value`. Die Elemente aktualisieren und zeichnen sich nach
  `draw()` selbst, über einen p5-`post`-Hook in der Bibliothek.
- **`libraries/p5.modbuttons.js`**: bietet neben den Klassen
  `disableAllButtons()`, `saveButtonStatus()` / `loadButtonStatus()` und
  pro Element `enable()` / `disable()`. `Dial` rechnet intern mit
  `angleMode(DEGREES)` und stellt danach den Winkelmodus des Sketches
  wieder her.

</div>
