---
title: MJPEG Stream
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Webcams_MJPEGStream
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Webcams_MJPEGStream
related:
- Servers_RaspberriPi
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

Requirements: an MJPEG stream URL. Set it in `videoSrc` at the top of
`sketch.js` (MJPEG cameras often serve streams at paths like
`/?action=stream`).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## Server

Needs `stream-proxy` from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(HTTP, port 5000), running on a Raspberry Pi in the same network as your
computer. Start it first with `bash run.sh` (or `python server.py`) in its
folder. It fetches the camera stream and passes it on with CORS headers,
so the sketch can read its pixels. Set `proxyUrl` in `sketch.js` to
`http://<pi-ip>:5000/stream?url=`.

## How to Run

Start the proxy first (see Server). Then open the folder in Visual Studio Code and start Live Server (click
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

Voraussetzungen: eine MJPEG-Stream-URL. Sie in `sketch.js` oben in
`videoSrc` eintragen (MJPEG-Kameras liefern Streams oft unter Pfaden wie
`/?action=stream`).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Server

Braucht `stream-proxy` aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi)
(HTTP, Port 5000), auf einem Raspberry Pi im selben Netzwerk wie dein
Computer. Zuerst im Ordner mit `bash run.sh` (oder `python server.py`)
starten. Er holt den Kamerastream und reicht ihn mit CORS-Headern weiter,
damit der Sketch seine Pixel lesen kann. In `sketch.js` `proxyUrl` auf
`http://<pi-ip>:5000/stream?url=` setzen.

## Ausführen

Zuerst den Proxy starten (siehe Server). Dann den Ordner in Visual Studio Code öffnen und Live Server starten (in der
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
