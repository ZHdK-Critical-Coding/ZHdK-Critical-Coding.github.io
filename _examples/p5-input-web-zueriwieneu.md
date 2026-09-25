---
title: Züri wie neu
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Web_ZueriWieNeu
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Web_ZueriWieNeu
related: []
render_with_liquid: false
---

# P5.js: Züri wie neu

A p5.js sketch that loads the latest reports from
[Züri wie neu](https://www.zueriwieneu.ch) (the City of Zurich's platform for
reporting damage and defects) and places their photos and titles on a map-like
canvas according to their geographic position.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. The first page of reports is loaded and drawn. After all photos have
   loaded, the sketch waits 10 seconds and loads the next (older) page.

## How it Works

- Reports are fetched from the site's AJAX endpoint (`/reports?ajax=1`,
  sorted by last update, limited to a bounding box around Zurich) through the
  public [AllOrigins](https://allorigins.win) proxy (`/get?url=...`), which
  wraps the response in JSON and adds CORS headers.
- Each entry in `pins` is an array (`[0]` latitude, `[1]` longitude,
  `[3]` report id, `[4]` title). The photos (`https://www.zueriwieneu.ch/photo/<id>.0.jpeg`)
  are loaded one after the other with `loadImage()` and appended to the pin.
- Latitude and longitude are normalised to the bounding box and scaled to the
  window size, so the canvas works as a simple map of the city.

## Libraries

- p5.js 1.10.0
- p5.sound 1.0.1 (loaded, not used)
