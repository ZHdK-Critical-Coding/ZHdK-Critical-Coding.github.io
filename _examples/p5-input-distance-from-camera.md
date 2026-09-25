---
title: Camera Distance
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Distance_From_Camera
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Distance_From_Camera
render_with_liquid: false
---

# P5 -> Distance From Camera

Estimates how far a viewer is from the screen using the webcam. ml5.js
`faceMesh` detects the face; the closer you are, the wider the face box
appears. The distance is simply `K / faceWidthInPixels` and shown in cm.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Allow camera access in the browser.
3. Press **f** to toggle fullscreen.

## Calibration

1. Stand at a known distance from the camera (e.g. 60 cm).
2. Read the printed `face width: … px` from the browser console.
3. Enter both values as `KNOWN_DISTANCE` and `KNOWN_WIDTH` at the top of `sketch.js`.

## Libraries

- p5.js 1.11.0 and ml5.js 1 (loaded from CDN in `index.html`)
