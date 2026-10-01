---
title: ISS Position
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Web_ISSPosition
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Web_ISSPosition
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: ISS Position

Fetches the current position of the International Space Station every two
seconds and draws its track as dots on the canvas (longitude mapped to x,
latitude to y). An example of polling a web API with `fetch()` and turning
live data into a drawing.

## Installation

Requirements: an internet connection and a current browser.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Leave the page open: a new dot is added every two seconds, so the orbit
   builds up slowly over time.

The position comes from the [Where the ISS at?](https://wheretheiss.at) API
(`/v1/satellites/25544`). The request is routed through the AllOrigins
proxy (`api.allorigins.win`) to avoid CORS restrictions, so no special
browser setup is needed.

## Coding Help

- **`sketch.js` → `api_url`**: the API endpoint. Change it to fetch other
  data (and adjust `getISS()`).
- **`getISS()`**: fetches the URL through the AllOrigins proxy. The proxy
  wraps the answer, so the real JSON is parsed from `d.contents`. Returns
  `latitude` and `longitude`.
- **`setup()`**: creates a full-window canvas and starts a `setInterval`
  that pushes a new position into `positions` every 2000 ms and logs the
  newest position to the console.
- **`draw()`**: normalizes latitude (−90…90) and longitude (−180…180) to
  0–1 and draws a circle for each stored position. Latitude is inverted
  (`1 - …`) so north is at the top.
- **`windowResized()`**: resizes the canvas with the window.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: ISS Position

Holt alle zwei Sekunden die aktuelle Position der Internationalen
Raumstation und zeichnet ihre Bahn als Punkte auf die Zeichenfläche
(Längengrad auf x, Breitengrad auf y). Ein Beispiel, wie man eine Web-API
mit `fetch()` regelmässig abfragt und Live-Daten in eine Zeichnung
umsetzt.

## Installation

Voraussetzungen: eine Internetverbindung und ein aktueller Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die Seite offen lassen: Alle zwei Sekunden kommt ein neuer Punkt dazu,
   die Umlaufbahn baut sich also langsam auf.

Die Position stammt von der API [Where the ISS at?](https://wheretheiss.at)
(`/v1/satellites/25544`). Die Anfrage läuft über den Proxy AllOrigins
(`api.allorigins.win`), um CORS-Einschränkungen zu umgehen; im Browser muss
also nichts speziell eingestellt werden.

## Coding-Hilfe

- **`sketch.js` → `api_url`**: der API-Endpunkt. Ändern, um andere Daten
  zu holen (und `getISS()` anpassen).
- **`getISS()`**: ruft die URL über den AllOrigins-Proxy ab. Der Proxy
  verpackt die Antwort, deshalb wird das eigentliche JSON aus `d.contents`
  gelesen. Gibt `latitude` und `longitude` zurück.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche und startet
  ein `setInterval`, das alle 2000 ms eine neue Position in `positions`
  speichert und die neueste Position in der Konsole ausgibt.
- **`draw()`**: rechnet Breitengrad (−90…90) und Längengrad (−180…180) auf
  0–1 um und zeichnet für jede gespeicherte Position einen Kreis. Der
  Breitengrad wird umgekehrt (`1 - …`), damit Norden oben liegt.
- **`windowResized()`**: passt die Zeichenfläche an die Fenstergrösse an.

</div>
