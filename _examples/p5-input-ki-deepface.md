---
title: Deepface
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_Deepface
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_Deepface
related: []
render_with_liquid: false
---

# P5.js: Deepface

A p5.js sketch that captures the webcam and sends the current frame (Base64
JPEG) to a [DeepFace](https://github.com/serengil/deepface) analysis server.
The JSON response (age, gender, emotion, …) is shown below the canvas.

## Requirements

- A running DeepFace server exposing `POST /analyze`. Adjust `serverURL` in
  `sketch.js` to point to your server.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Allow webcam access.
3. Press **Space** to send a frame for analysis. A red dot is shown while waiting.
