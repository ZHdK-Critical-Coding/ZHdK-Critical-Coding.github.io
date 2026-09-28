---
title: MJPEG Stream
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Webcams_MJPEGStream
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Webcams_MJPEGStream
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: MJPEG Stream

Reads an MJPEG stream (e.g. from an IP camera) and draws it into the
canvas, repeated four times in a 2×2 grid. Because the frames end up in
the canvas, they can be processed further like any p5 image. A starting
point for using network cameras as input for a sketch.

## Installation

Requirements: an MJPEG stream URL and a proxy that adds CORS headers to
the stream. The proxy is not included in this repository; you have to run
one yourself.

1. Set the camera stream URL in `videoSrc` at the top of `sketch.js`
   (MJPEG cameras often serve streams at paths like `/?action=stream`).
2. Set `proxyUrl` to your proxy. The sketch expects an endpoint of the
   form `http://<host>:<port>/stream?url=`.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## How to Run

Open the folder in Visual Studio Code and start Live Server (click
**Go Live** in the status bar).

While the stream is loading, the stream URL is shown on a black canvas.
If you run into CORS problems, use the debugger configuration
**Launch Chrome (no Security)** (Run and Debug panel), which opens Chrome
with web security disabled on `http://127.0.0.1:5500`.

## Coding Help

- **`sketch.js` → config at the top**: `videoSrc` is the camera stream,
  `proxyUrl` the CORS proxy. A second stream URL is commented out.
- **`setup()`**: creates a full-window canvas and loads
  `proxyUrl + encodeURIComponent(videoSrc)` with `createImg()` and
  `crossOrigin` set to `anonymous`. Once loaded, the HTML element is
  hidden and `videoReady` is set.
- **`draw()`**: draws `imageStream` four times with `image()`. The browser
  keeps updating an `<img>` that shows an MJPEG stream, so each call shows
  the current frame. Add your own processing here.
- **`wait()`**: shows the loading text until the stream is ready.
- **`windowResized()`**: resizes the canvas with the window.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: MJPEG Stream

Liest einen MJPEG-Stream (z. B. von einer IP-Kamera) und zeichnet ihn
viermal in einem 2×2-Raster auf die Zeichenfläche. Weil die Bilder auf der
Zeichenfläche landen, lassen sie sich wie jedes p5-Bild weiterverarbeiten.
Ein Ausgangspunkt, um Netzwerkkameras als Input für einen Sketch zu
verwenden.

## Installation

Voraussetzungen: eine MJPEG-Stream-URL und ein Proxy, der dem Stream
CORS-Header hinzufügt. Der Proxy ist nicht in diesem Repository enthalten,
du musst selbst einen betreiben.

1. In `sketch.js` oben in `videoSrc` die URL des Kamerastreams eintragen
   (MJPEG-Kameras liefern Streams oft unter Pfaden wie `/?action=stream`).
2. `proxyUrl` auf den eigenen Proxy setzen. Der Sketch erwartet einen
   Endpunkt der Form `http://<host>:<port>/stream?url=`.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
Statusleiste auf **Go Live** klicken).

Solange der Stream lädt, wird die Stream-URL auf schwarzem Grund angezeigt.
Bei CORS-Problemen die Debugger-Konfiguration **Launch Chrome (no
Security)** verwenden (Bereich Run and Debug). Sie öffnet Chrome mit
deaktivierter Web-Security auf `http://127.0.0.1:5500`.

## Coding-Hilfe

- **`sketch.js` → Konfiguration oben**: `videoSrc` ist der Kamerastream,
  `proxyUrl` der CORS-Proxy. Eine zweite Stream-URL ist auskommentiert.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche und lädt
  `proxyUrl + encodeURIComponent(videoSrc)` mit `createImg()` und
  `crossOrigin` auf `anonymous`. Nach dem Laden wird das HTML-Element
  versteckt und `videoReady` gesetzt.
- **`draw()`**: zeichnet `imageStream` viermal mit `image()`. Der Browser
  aktualisiert ein `<img>` mit MJPEG-Stream laufend, jeder Aufruf zeigt also
  das aktuelle Bild. Hier die eigene Verarbeitung ergänzen.
- **`wait()`**: zeigt den Ladetext, bis der Stream bereit ist.
- **`windowResized()`**: passt die Zeichenfläche an die Fenstergrösse an.

</div>
