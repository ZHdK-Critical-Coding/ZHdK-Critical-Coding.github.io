---
title: SearXNG Search
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-17
repo: P5_Input_SearchXNG
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_SearchXNG
screenshot: "/assets/examples/p5-input-searchxng/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: SearXNG Search

A text input and a search button. The query is sent to a SearXNG instance
and the result URLs are drawn as text on the canvas, each with small tags
for the search engines that found it. A starting point for using web search
results as input for a sketch.

## Installation

Requirements: a running [SearXNG](https://docs.searxng.org) instance that
is reachable from your computer, with the JSON format enabled and CORS
headers added (see below).

Set `SEARCH_URL` at the top of `sketch.js` to your instance:

```js
const SEARCH_URL = "http://brian3.hermi.lan:8888/search?q=";
```

### SearXNG configuration

`&format=json` is appended automatically. The JSON format must be enabled
in SearXNG's `settings.yml`:

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

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Type a query and click **Search** or press Enter.

## Coding Help

- **`sketch.js` → `SEARCH_URL`**: search endpoint, the encoded query is
  appended to it.
- **`setup()`**: creates a full-window canvas, the text input and the
  **Search** button.
- **`keyPressed()`**: Enter also starts `search()`.
- **`search()`**: fetches `SEARCH_URL + query + "&format=json"` and keeps
  only `engines` and `url` of every result in `results`. The full response
  is logged to the console – look there for other fields (e.g. `title`,
  `content`) and add them to the `map()` call. Errors end up in `status`.
- **`draw()`**: prints `status` and then one line per result: a framed tag
  per engine, followed by the URL.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: SearXNG Search

Ein Texteingabefeld und ein Such-Button. Die Suchanfrage wird an eine
SearXNG-Instanz geschickt, die URLs der Resultate werden als Text auf die
Zeichenfläche gezeichnet, jeweils mit kleinen Tags für die Suchmaschinen,
die sie gefunden haben. Ein Ausgangspunkt, um Websuch-Resultate als Input
für einen Sketch zu verwenden.

## Installation

Voraussetzungen: eine laufende [SearXNG](https://docs.searxng.org)-Instanz,
die vom eigenen Computer aus erreichbar ist, mit aktiviertem JSON-Format und
CORS-Headern (siehe unten).

`SEARCH_URL` oben in `sketch.js` auf die eigene Instanz setzen:

```js
const SEARCH_URL = "http://brian3.hermi.lan:8888/search?q=";
```

### SearXNG-Konfiguration

`&format=json` wird automatisch angehängt. Das JSON-Format muss in der
`settings.yml` von SearXNG aktiviert sein:

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

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Einen Suchbegriff eingeben und auf **Search** klicken oder Enter drücken.

## Coding-Hilfe

- **`sketch.js` → `SEARCH_URL`**: Such-Endpunkt, die kodierte Suchanfrage
  wird angehängt.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, das
  Texteingabefeld und den Knopf **Search**.
- **`keyPressed()`**: Enter startet ebenfalls `search()`.
- **`search()`**: ruft `SEARCH_URL + query + "&format=json"` ab und behält
  von jedem Resultat nur `engines` und `url` in `results`. Die ganze Antwort
  wird in der Konsole ausgegeben – dort nach weiteren Feldern schauen (z. B.
  `title`, `content`) und sie im `map()`-Aufruf ergänzen. Fehler landen in
  `status`.
- **`draw()`**: schreibt `status` und dann eine Zeile pro Resultat: einen
  umrandeten Tag pro Suchmaschine, gefolgt von der URL.

</div>
