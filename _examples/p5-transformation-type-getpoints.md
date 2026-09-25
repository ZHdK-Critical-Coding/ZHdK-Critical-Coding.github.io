---
title: Get Points
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Type_GetPoints
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Type_GetPoints
render_with_liquid: false
---

# P5 -> Get Points

Samples the outline of a text with `font.textToPoints()` using the font
`assets/pixelmix.ttf`. Sliders control the sample factor and the font size; the
number of generated points is shown.

## Notes

Browsers cannot read system fonts directly – put your own font file (ttf/otf/woff) into `assets/` and change `FONT_PATH` in `sketch.js`.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Adjust the sliders to change sampling density and font size.
