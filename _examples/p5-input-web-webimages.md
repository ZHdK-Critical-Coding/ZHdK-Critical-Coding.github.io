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
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Web Images

Fetches a web page, parses its HTML and shows all images (`<img>` and
`<picture>` sources) together with their alt texts as a grid of thumbnails.
A starting point for scraping and remixing visual material from websites.

## Installation

Requirements: Chrome and an internet connection. Because the page is
fetched cross-origin, the browser normally blocks the request (CORS).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. In the **Run and Debug** panel, start the configuration **Launch Chrome
   (no Security)**. It opens `http://127.0.0.1:5500` in a separate Chrome
   profile with web security disabled.
3. Enter a URL and click **Fetch Images**.

Only use the insecure Chrome window for this sketch, not for normal browsing.

## Coding Help

- **`sketch.js` → `setup()`**: creates the canvas, an input field
  (default `https://www.zhdk.ch`) and the **Fetch Images** button, which
  calls `fetchData()` with the entered URL.
- **`fetchData()`**: loads the page with `fetch()` and parses it with
  `DOMParser`. For every `<img>` it takes `src` (or the first `srcset`
  candidate), for every `<picture>` the first candidate of the first
  `<source>`. Relative paths are made absolute with `new URL(src, url)`;
  alt texts default to "(no alt text)".
- **`processImages()`**: removes the previous result and creates a `div`
  with one item per image: an `<img>` and a paragraph with the alt text.
- **`style.css`**: `.imageContainer` and `.imageItem` lay out the grid;
  `img` sets the thumbnail size (100 × 100 px). Change the look here.
- **`.vscode/launch.json`**: the Chrome configuration with
  `--disable-web-security`. Adjust the port if Live Server uses another one.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Web Images

Lädt eine Webseite, parst ihr HTML und zeigt alle Bilder (`<img>`- und
`<picture>`-Quellen) mit ihren Alt-Texten als Raster von Vorschaubildern an.
Ein Ausgangspunkt, um Bildmaterial von Websites zu sammeln und
weiterzuverarbeiten.

## Installation

Voraussetzungen: Chrome und eine Internetverbindung. Weil die Seite von
einer fremden Domain geladen wird, blockiert der Browser die Anfrage
normalerweise (CORS).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Im Bereich **Run and Debug** die Konfiguration **Launch Chrome (no
   Security)** starten. Sie öffnet `http://127.0.0.1:5500` in einem
   separaten Chrome-Profil mit ausgeschalteter Web-Sicherheit.
3. Eine URL eingeben und auf **Fetch Images** klicken.

Das unsichere Chrome-Fenster nur für diesen Sketch verwenden, nicht zum
normalen Surfen.

## Coding-Hilfe

- **`sketch.js` → `setup()`**: erstellt die Zeichenfläche, ein Eingabefeld
  (Standard `https://www.zhdk.ch`) und den Knopf **Fetch Images**, der
  `fetchData()` mit der eingegebenen URL aufruft.
- **`fetchData()`**: lädt die Seite mit `fetch()` und parst sie mit
  `DOMParser`. Bei jedem `<img>` wird `src` (oder der erste Kandidat aus
  `srcset`) genommen, bei jedem `<picture>` der erste Kandidat der ersten
  `<source>`. Relative Pfade werden mit `new URL(src, url)` absolut gemacht;
  fehlende Alt-Texte werden zu "(no alt text)".
- **`processImages()`**: entfernt das vorherige Ergebnis und erstellt ein
  `div` mit einem Eintrag pro Bild: ein `<img>` und ein Absatz mit dem
  Alt-Text.
- **`style.css`**: `.imageContainer` und `.imageItem` ordnen das Raster an;
  `img` legt die Grösse der Vorschaubilder fest (100 × 100 px). Hier das
  Aussehen anpassen.
- **`.vscode/launch.json`**: die Chrome-Konfiguration mit
  `--disable-web-security`. Den Port anpassen, falls Live Server einen
  anderen verwendet.

</div>
