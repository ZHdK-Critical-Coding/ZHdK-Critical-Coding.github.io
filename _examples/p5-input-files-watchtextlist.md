---
title: Watch Text List
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Files_WatchTextList
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Files_WatchTextList
related: []
render_with_liquid: false
---

# P5 -> Watch Text List

A p5.js sketch that reads the text file `assets/list.txt` every five seconds
and draws its lines on the canvas. Edit the file while the sketch is running
and the display follows the changes.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Open `assets/list.txt`, change, add or remove lines and save the file.
3. The canvas shows the new content within about five seconds.

## How it Works

`watcher()` loads the file with `loadStrings()` and, once it has arrived,
schedules itself again with `setTimeout(..., 5000)`. `draw()` renders the
current lines one below the other (10 px apart), so the text list can be
updated from outside the sketch, e.g. by another program writing the file.

## Libraries

- p5.js 1.10.0, p5.sound 1.0.1 (in `libraries/`)
