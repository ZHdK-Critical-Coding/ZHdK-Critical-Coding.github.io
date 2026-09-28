---
title: Camera Distance
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Distance_From_Camera
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Distance_From_Camera
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Camera Distance

Estimates how far a viewer is from the screen using the webcam. ml5.js
`faceMesh` detects the face; the closer you are, the wider the face box
appears. The distance is calculated as `K / faceWidthInPixels` and shown in
cm – useful for installations that react to people approaching.

## Installation

Requirements: a webcam and a current browser (Chrome or Edge recommended).

Libraries (loaded from a CDN in `index.html`): p5.js 1.11.0, ml5.js 1.x.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow camera access in the browser.
3. Press **f** to toggle fullscreen. The video scales with the window.
4. Press **c** to show the measured face width (for calibration).

### Calibration

1. Stand at a known distance from the camera (e.g. 60 cm).
2. Press **c** and read the `face width: … px` shown in the bar at the
   top.
3. Enter both values as `KNOWN_DISTANCE` and `KNOWN_WIDTH` at the top of
   `sketch.js`.

## Coding Help

- **`sketch.js` → calibration constants**: `KNOWN_DISTANCE` (cm) and
  `KNOWN_WIDTH` (px) define `K`. Adjust them for your camera.
- **`preload()`**: loads the ml5 `faceMesh` model, limited to one face
  (`maxFaces: 1`).
- **`setup()`**: creates a full-window canvas, starts the webcam with
  `createCapture(VIDEO)` at a fixed size of 448 × 256 (so the calibration
  does not depend on the window size) and runs `faceMesh.detectStart()`, which keeps
  writing the results into `faces`.
- **`draw()`**: draws the video scaled to fit the window (aspect ratio
  kept), takes `faces[0].box.width`, calculates the distance and prints it
  in a bar at the top. If `calibrating` is on, the face width is shown too.
- **`windowResized()`**: resizes the canvas with the window (also in
  fullscreen).
- **`keyPressed()`**: toggles fullscreen with **f** and the calibration
  display with **c**.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Camera Distance

Schätzt mit der Webcam, wie weit eine Person vom Bildschirm entfernt ist.
ml5.js `faceMesh` erkennt das Gesicht; je näher man ist, desto breiter
erscheint die Gesichtsbox. Die Distanz wird als `K / faceWidthInPixels`
berechnet und in cm angezeigt – nützlich für Installationen, die auf sich
nähernde Personen reagieren.

## Installation

Voraussetzungen: eine Webcam und ein aktueller Browser (Chrome oder Edge
empfohlen).

Bibliotheken (über ein CDN in `index.html` geladen): p5.js 1.11.0,
ml5.js 1.x.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Im Browser den Zugriff auf die Kamera erlauben.
3. Mit **f** den Vollbildmodus ein- und ausschalten. Das Video passt sich
   der Fenstergrösse an.
4. Mit **c** die gemessene Gesichtsbreite einblenden (für die
   Kalibrierung).

### Kalibrierung

1. In einer bekannten Distanz zur Kamera stehen (z. B. 60 cm).
2. **c** drücken und die `face width: … px` im Balken oben ablesen.
3. Beide Werte oben in `sketch.js` als `KNOWN_DISTANCE` und `KNOWN_WIDTH`
   eintragen.

## Coding-Hilfe

- **`sketch.js` → Kalibrierungskonstanten**: `KNOWN_DISTANCE` (cm) und
  `KNOWN_WIDTH` (px) ergeben `K`. Für die eigene Kamera anpassen.
- **`preload()`**: lädt das ml5-Modell `faceMesh`, beschränkt auf ein
  Gesicht (`maxFaces: 1`).
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, startet die
  Webcam mit `createCapture(VIDEO)` in einer festen Grösse von 448 × 256
  Pixeln (damit die Kalibrierung nicht von der Fenstergrösse abhängt) und
  ruft `faceMesh.detectStart()`
  auf, das die Resultate laufend in `faces` schreibt.
- **`draw()`**: zeichnet das Video passend ins Fenster (Seitenverhältnis
  bleibt erhalten), liest `faces[0].box.width`, berechnet die Distanz und
  zeigt sie in einem Balken oben an. Ist `calibrating` eingeschaltet, wird
  zusätzlich die Gesichtsbreite angezeigt.
- **`windowResized()`**: passt die Zeichenfläche an die Fenstergrösse an
  (auch im Vollbildmodus).
- **`keyPressed()`**: schaltet mit **f** den Vollbildmodus und mit **c**
  die Kalibrierungsanzeige um.

</div>
