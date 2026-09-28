---
title: Audio Volume
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Audio_Volume_Measure
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Audio_Volume_Measure
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Audio Volume

Measures the loudness of the microphone and shows it as a number from 0 to
100 in the middle of the canvas. A simple starting point for sketches that
react to sound, clapping or voice level.

## Installation

Requirements: a microphone and a current browser (Chrome, Edge, Firefox or
Safari).

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow microphone access in the browser.
3. Click into the canvas once – browsers only start audio after a user
   gesture.

Libraries (loaded from a CDN in `index.html`): p5.js 1.9.4, p5.sound 1.9.4.

## Coding Help

- **`sketch.js` → `setup()`**: creates a 448 × 256 canvas, starts the
  microphone with `p5.AudioIn` and connects it to a `p5.FFT` analyser.
- **`draw()`**: calls `fft.analyze()`, which returns an array of frequency
  bins with values from 0 to 255. Their average is mapped to 0–100 and
  printed in the centre. Change the mapping range (e.g. `map(avg, 0, 100,
  0, 100)`) to make the display more sensitive.
- **`mousePressed()`**: calls `userStartAudio()` so the audio context can
  start after the first click.
- Instead of the FFT average you can also use `mic.getLevel()` (0.0–1.0)
  for a plain volume value.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Audio Volume

Misst die Lautstärke des Mikrofons und zeigt sie als Zahl von 0 bis 100 in
der Mitte der Zeichenfläche an. Ein einfacher Ausgangspunkt für Sketches,
die auf Geräusche, Klatschen oder Stimmen reagieren.

## Installation

Voraussetzungen: ein Mikrofon und ein aktueller Browser (Chrome, Edge,
Firefox oder Safari).

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Im Browser den Zugriff auf das Mikrofon erlauben.
3. Einmal in die Zeichenfläche klicken – Browser starten Audio erst nach
   einer Benutzeraktion.

Bibliotheken (über ein CDN in `index.html` geladen): p5.js 1.9.4,
p5.sound 1.9.4.

## Coding-Hilfe

- **`sketch.js` → `setup()`**: erstellt eine Zeichenfläche von 448 × 256
  Pixeln, startet das Mikrofon mit `p5.AudioIn` und verbindet es mit einem
  `p5.FFT`-Analyser.
- **`draw()`**: ruft `fft.analyze()` auf. Das liefert ein Array von
  Frequenzbändern mit Werten von 0 bis 255. Ihr Durchschnitt wird auf 0–100
  umgerechnet und in der Mitte angezeigt. Den Bereich in `map()` ändern
  (z. B. `map(avg, 0, 100, 0, 100)`), um die Anzeige empfindlicher zu
  machen.
- **`mousePressed()`**: ruft `userStartAudio()` auf, damit der Audio-Kontext
  nach dem ersten Klick starten kann.
- Statt des FFT-Durchschnitts kann man auch `mic.getLevel()` (0.0–1.0) als
  einfachen Lautstärkewert verwenden.

</div>
