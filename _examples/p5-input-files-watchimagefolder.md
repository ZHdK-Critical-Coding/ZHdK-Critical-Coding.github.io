---
title: Watch Image Folder
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Files_WatchImageFolder
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Files_WatchImageFolder
related: []
render_with_liquid: false
---

# P5 -> Watch Image Folder

A p5.js sketch that displays all images from the folder `assets/files` in a
grid. Images added to or removed from the folder appear or disappear while
the sketch is running.

## How to Use

1. Put images (e.g. `.jpg`, `.png`) into `assets/files` (seven sample
   images are included).
2. In a terminal, run the watcher script from the project folder:
   `bash watch.sh` (leave it running).
3. Start Live Server (click **Go Live** in the VS Code status bar).
4. Add or remove images in `assets/files`.

## How it Works

A browser cannot list the contents of a folder, so `watch.sh` checks
`assets/files` every second and writes the file paths into
`assets/list.txt` whenever the contents change. The sketch reloads
`list.txt` every second with `loadStrings()`, loads new images with
`loadImage()` and removes images no longer in the list. Loaded images are
drawn as squares, four per row, on a 400 x 400 canvas.

## Libraries

- p5.js 1.10.0
- p5.sound 1.0.1 (included, not used)
