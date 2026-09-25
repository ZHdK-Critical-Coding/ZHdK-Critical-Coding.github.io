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
---

# P5.js: Audio Volume

Measures the loudness of the microphone and shows it as a number from 0 to 100.
The mic signal is run through a `p5.FFT`; the average energy of all frequency
bins (0–255) is mapped to 0–100 and drawn in the middle of a 448 × 256 canvas.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Allow microphone access in the browser.
3. Click into the canvas once — browsers only start audio after a user gesture.

## Libraries

- p5.js 1.9.4 and p5.sound (loaded from CDN in `index.html`)
