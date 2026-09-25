---
title: Web Images
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Web_WebImages
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Web_WebImages
related: []
render_with_liquid: false
---

# P5.js: Web Images

A p5.js sketch that fetches a web page, parses its HTML and displays all
images (`<img>` and `<picture>` sources) together with their alt texts.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Because the page is fetched cross-origin, the browser blocks the request
   (CORS). Start the debugger configuration **Launch Chrome (no Security)**
   (Run and Debug panel) to open Chrome with web security disabled.
3. Enter a URL and press **Fetch Images**.
