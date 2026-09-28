---
title: SearXNG Images
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-17
repo: P5_Input_SearchXNG_Images
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_SearchXNG_Images
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: SearXNG Images

A text input and a search button. The query is sent to a SearXNG instance
(`categories=images`). All result images are loaded and drawn as a pattern
of 250 × 250 pixel tiles (center-cropped squares). A starting point for
building collages or moodboards from web image search results.

## Installation

Requirements: a running [SearXNG](https://docs.searxng.org) instance that
is reachable from your computer, with the JSON format enabled and CORS
headers added (see below).

Set `SEARCH_URL` at the top of `sketch.js` to your instance:

```js
const SEARCH_URL = "http://brian3.hermi.lan:8888/search?q=";
const TILE_SIZE = 250;
```

### SearXNG configuration

`&categories=images&format=json` is appended automatically. The JSON format
must be enabled in SearXNG's `settings.yml`:

```yaml
search:
  formats:
    - html
    - json
```

SearXNG does not send an `Access-Control-Allow-Origin` header. When the
sketch runs in a browser (e.g. Live Server on `127.0.0.1:5500`), the request
is blocked unless a reverse proxy in front of SearXNG adds the header, e.g.
nginx:

```nginx
add_header Access-Control-Allow-Origin *;
```

Images are drawn on the canvas, so every image host must allow CORS as
well. Images that fail to load are skipped (see console).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Type a query and click **Search** or press Enter.

## Coding Help

- **Config at the top of `sketch.js`**: `SEARCH_URL` (search endpoint, the
  encoded query is appended), `TILE_SIZE` (tile size in pixels) and `TOP`
  (space for the input field).
- **`setup()`**: creates a full-window canvas, the text input and the
  **Search** button.
- **`keyPressed()`**: Enter also starts `search()`.
- **`search()`**: fetches the image results, logs the full JSON to the
  console and loads every image with `loadImage()` – the thumbnail
  (`thumbnail_src`) if there is one, else `img_src`. Loaded images are added
  to `images`; `searchId` makes sure images from an older search are
  ignored.
- **`draw()`**: draws `images` as a grid, cropping each one to a square from
  its center. Change the layout here (e.g. random positions or sizes).
- **`resizeToFit()`**: makes the canvas tall enough for all tiles, so the
  page scrolls. Also called from `windowResized()`.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: SearXNG Images

Ein Texteingabefeld und ein Such-Button. Die Suchanfrage wird an eine
SearXNG-Instanz geschickt (`categories=images`). Alle Bilder werden geladen
und als Muster aus 250 × 250 Pixel grossen Kacheln gezeichnet (quadratisch
aus der Mitte zugeschnitten). Ein Ausgangspunkt, um Collagen oder
Moodboards aus Bildsuch-Resultaten zu bauen.

## Installation

Voraussetzungen: eine laufende [SearXNG](https://docs.searxng.org)-Instanz,
die vom eigenen Computer aus erreichbar ist, mit aktiviertem JSON-Format und
CORS-Headern (siehe unten).

`SEARCH_URL` oben in `sketch.js` auf die eigene Instanz setzen:

```js
const SEARCH_URL = "http://brian3.hermi.lan:8888/search?q=";
const TILE_SIZE = 250;
```

### SearXNG-Konfiguration

`&categories=images&format=json` wird automatisch angehängt. Das
JSON-Format muss in der `settings.yml` von SearXNG aktiviert sein:

```yaml
search:
  formats:
    - html
    - json
```

SearXNG schickt keinen `Access-Control-Allow-Origin`-Header. Läuft der
Sketch im Browser (z. B. Live Server auf `127.0.0.1:5500`), wird die Anfrage
blockiert, ausser ein Reverse Proxy vor SearXNG ergänzt den Header, z. B.
nginx:

```nginx
add_header Access-Control-Allow-Origin *;
```

Die Bilder werden auf die Zeichenfläche gezeichnet, deshalb muss auch jeder
Bild-Host CORS erlauben. Bilder, die nicht geladen werden können, werden
übersprungen (siehe Konsole).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Einen Suchbegriff eingeben und auf **Search** klicken oder Enter drücken.

## Coding-Hilfe

- **Konfiguration oben in `sketch.js`**: `SEARCH_URL` (Such-Endpunkt, die
  kodierte Suchanfrage wird angehängt), `TILE_SIZE` (Kachelgrösse in Pixel)
  und `TOP` (Platz für das Eingabefeld).
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, das
  Texteingabefeld und den Knopf **Search**.
- **`keyPressed()`**: Enter startet ebenfalls `search()`.
- **`search()`**: ruft die Bildresultate ab, gibt das ganze JSON in der
  Konsole aus und lädt jedes Bild mit `loadImage()` – das Thumbnail
  (`thumbnail_src`), falls vorhanden, sonst `img_src`. Geladene Bilder
  kommen in `images`; `searchId` sorgt dafür, dass Bilder einer älteren
  Suche ignoriert werden.
- **`draw()`**: zeichnet `images` als Raster und schneidet jedes Bild
  quadratisch aus der Mitte zu. Das Layout hier ändern (z. B. zufällige
  Positionen oder Grössen).
- **`resizeToFit()`**: macht die Zeichenfläche hoch genug für alle Kacheln,
  damit die Seite scrollt. Wird auch von `windowResized()` aufgerufen.

</div>
