---
title: OpenType
category: transformation
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Transformation_Type_Opentype
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Transformation_Type_Opentype
related: []
render_with_liquid: false
---

# P5.js: OpenType

Works directly with the underlying [opentype.js](https://opentype.js.org) font
of a p5 font: `font.getPath()` returns the raw path commands, which are sampled
into points per contour (helpers in `pathhelper.js`) and drawn as outline and
points.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Enter a text and adjust sample step, font size, line subdivisions and raster size.
3. Press **O** to toggle the outlines.
