---
title: Züri wie neu
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Web_ZueriWieNeu
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Web_ZueriWieNeu
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Züri wie neu

Loads the latest reports from [Züri wie neu](https://www.zueriwieneu.ch)
(the City of Zurich's platform for reporting damage and defects) and places
their photos and titles on the canvas according to their geographic
position. The canvas works as a simple map of the city. A starting point for
visualising geolocated open data from a web API.

## Installation

Requirements: a browser and an internet connection (the data is loaded
through a public proxy).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. The first page of reports is loaded and drawn. After all photos have
   loaded, the sketch waits 10 seconds and loads the next (older) page.

## Coding Help

- **`sketch.js` → `api_url`**: the site's AJAX endpoint
  (`/reports?ajax=1`), sorted by last update and limited to a bounding box
  around Zurich (`bbox=`). The page number is appended from `page`.
- **`getZueri()`**: fetches the current page through the
  [AllOrigins](https://allorigins.win) proxy (`/get?url=...`), which wraps
  the response in JSON (`contents`) and adds CORS headers. Then starts
  loading the photos.
- **`processImage()`**: loads the photos
  (`https://www.zueriwieneu.ch/photo/<id>.0.jpeg`) one after the other with
  `loadImage()` and appends each image (or `false`) to its pin. Each pin is
  an array: `[0]` latitude, `[1]` longitude, `[3]` report id, `[4]` title;
  the photo ends up at `[7]`. When all pins are done, it calls
  `allImagesLoaded()`.
- **`allImagesLoaded()`**: waits 10 seconds, increases `page` and loads the
  next page. Change the delay here.
- **`draw()`**: normalises latitude and longitude to the bounding box
  `bbox` and scales them to the window size. Draws all photos centred on
  their position first, then all titles on top. Keep `bbox` in sync with
  the one in `api_url` when changing the area.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Züri wie neu

Lädt die neuesten Meldungen von [Züri wie neu](https://www.zueriwieneu.ch)
(der Plattform der Stadt Zürich, um Schäden und Mängel zu melden) und
platziert ihre Fotos und Titel entsprechend ihrer geografischen Position
auf der Zeichenfläche. Die Zeichenfläche wird so zu einer einfachen
Stadtkarte. Ein Ausgangspunkt, um georeferenzierte offene Daten aus einer
Web-API zu visualisieren.

## Installation

Voraussetzungen: ein Browser und eine Internetverbindung (die Daten werden
über einen öffentlichen Proxy geladen).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die erste Seite mit Meldungen wird geladen und gezeichnet. Sobald alle
   Fotos geladen sind, wartet der Sketch 10 Sekunden und lädt die nächste
   (ältere) Seite.

## Coding-Hilfe

- **`sketch.js` → `api_url`**: der AJAX-Endpunkt der Website
  (`/reports?ajax=1`), sortiert nach letzter Änderung und beschränkt auf
  einen Ausschnitt um Zürich (`bbox=`). Die Seitennummer wird aus `page`
  angehängt.
- **`getZueri()`**: holt die aktuelle Seite über den Proxy
  [AllOrigins](https://allorigins.win) (`/get?url=...`), der die Antwort in
  JSON verpackt (`contents`) und CORS-Header hinzufügt. Danach beginnt das
  Laden der Fotos.
- **`processImage()`**: lädt die Fotos
  (`https://www.zueriwieneu.ch/photo/<id>.0.jpeg`) nacheinander mit
  `loadImage()` und hängt jedes Bild (oder `false`) an seinen Pin an. Jeder
  Pin ist ein Array: `[0]` Breitengrad, `[1]` Längengrad, `[3]` Melde-ID,
  `[4]` Titel; das Foto landet in `[7]`. Sind alle Pins bearbeitet, ruft es
  `allImagesLoaded()` auf.
- **`allImagesLoaded()`**: wartet 10 Sekunden, erhöht `page` und lädt die
  nächste Seite. Hier die Wartezeit anpassen.
- **`draw()`**: normalisiert Breiten- und Längengrad auf den Ausschnitt
  `bbox` und skaliert sie auf die Fenstergrösse. Zeichnet zuerst alle Fotos
  zentriert auf ihrer Position, dann alle Titel darüber. Beim Ändern des
  Gebiets `bbox` und den Wert in `api_url` gleich halten.

</div>
