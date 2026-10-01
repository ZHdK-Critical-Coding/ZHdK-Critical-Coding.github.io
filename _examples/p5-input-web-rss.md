---
title: RSS
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Web_RSS
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Web_RSS
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: RSS

Loads an RSS 2.0 or Atom feed, parses the XML and writes title, date and
summary of every entry onto the canvas. The feed is re-fetched every 10
seconds. A starting point for using news feeds or other live XML data as
input for a sketch.

## Installation

Requirements: a browser and an internet connection (the feed is loaded
through a public proxy).

Set the feed URL in `RSS_URL` at the top of `sketch.js` (default: NZZ
recent news).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. The entries appear on the canvas.

## Coding Help

- **`sketch.js` → `RSS_URL` / `ATOM_URL`**: the feed addresses. `ATOM_URL`
  holds an example Atom feed (arXiv); to use it, replace `RSS_URL` with
  `ATOM_URL` in `fetchRSS()`.
- **`setup()`**: creates a full-window canvas, turns off the draw loop
  with `noLoop()`, loads the feed once and then again every 10 seconds
  with `setInterval()`, calling `draw()` manually after each load.
- **`fetchRSS()`**: requests the feed through the
  [AllOrigins](https://allorigins.win) proxy
  (`https://api.allorigins.win/raw?url=...`), which adds CORS headers so the
  browser accepts the response. The text is parsed with `DOMParser`; on a
  parse error an exception is thrown.
- **`parseRssXml()`**: looks for RSS `<item>` elements first and falls back
  to Atom `<entry>` elements. Returns an array of objects with `title`,
  `link`, `date`, `summary` and `guid`.
- **`draw()`**: clears the canvas and writes title, date and summary of
  each item, 100 px apart. Change the layout here; long summaries are not
  wrapped and may contain HTML.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: RSS

Lädt einen RSS-2.0- oder Atom-Feed, parst das XML und schreibt Titel,
Datum und Zusammenfassung jedes Eintrags auf die Zeichenfläche. Der Feed
wird alle 10 Sekunden neu geladen. Ein Ausgangspunkt, um Newsfeeds oder
andere laufend aktualisierte XML-Daten als Input für einen Sketch zu
verwenden.

## Installation

Voraussetzungen: ein Browser und eine Internetverbindung (der Feed wird über
einen öffentlichen Proxy geladen).

In `sketch.js` oben die Feed-URL in `RSS_URL` eintragen (Standard: NZZ
Neueste Meldungen).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Die Einträge erscheinen auf der Zeichenfläche.

## Coding-Hilfe

- **`sketch.js` → `RSS_URL` / `ATOM_URL`**: die Feed-Adressen. `ATOM_URL`
  enthält einen Beispiel-Atom-Feed (arXiv); um ihn zu verwenden, in
  `fetchRSS()` `RSS_URL` durch `ATOM_URL` ersetzen.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, schaltet die
  Draw-Schleife mit `noLoop()` aus, lädt den Feed einmal und danach alle
  10 Sekunden mit `setInterval()` und ruft nach jedem Laden `draw()` von
  Hand auf.
- **`fetchRSS()`**: holt den Feed über den Proxy
  [AllOrigins](https://allorigins.win)
  (`https://api.allorigins.win/raw?url=...`), der CORS-Header hinzufügt,
  damit der Browser die Antwort akzeptiert. Der Text wird mit `DOMParser`
  geparst; bei einem Parse-Fehler wird eine Exception geworfen.
- **`parseRssXml()`**: sucht zuerst nach RSS-`<item>`-Elementen und weicht
  sonst auf Atom-`<entry>`-Elemente aus. Gibt ein Array von Objekten mit
  `title`, `link`, `date`, `summary` und `guid` zurück.
- **`draw()`**: löscht die Zeichenfläche und schreibt Titel, Datum und
  Zusammenfassung jedes Eintrags im Abstand von 100 px. Hier das Layout
  anpassen; lange Zusammenfassungen werden nicht umbrochen und können HTML
  enthalten.

</div>
