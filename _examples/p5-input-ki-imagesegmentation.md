---
title: Image Segmentation
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_ImageSegmentation
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ImageSegmentation
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Image Segmentation

Captures a frame from the webcam (or an MJPEG stream) and runs a panoptic
image segmentation model on it. For every detected segment it shows the
masked frame, the cropped segment, the raw mask and the label. A starting
point for cutting out objects or people from a camera image.

## Installation

Requirements: a webcam (or an MJPEG stream), Chrome (the model runs on
WebGPU, other browsers show "This runs only on Chrome!") and an internet
connection – transformers.js and the model are downloaded on first start.

Optional, MJPEG stream instead of webcam: set `videoSrc` and `proxyUrl` at
the top of `sketch.js` and set `useWebcam = false` (`true`, the default,
uses the webcam). The stream is loaded through a CORS proxy server that you
need to provide yourself (called as `<proxyUrl><encoded videoSrc>`).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), ml5.js 1.2.2, `ml5-extra-imagesegmentation.js`. transformers.js
(Hugging Face) is loaded in its latest version from jsDelivr.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow webcam access.
3. Wait until the model has loaded (see console, the first load downloads it
   from Hugging Face), then press **capture**.

## Coding Help

- **Config at the top of `sketch.js`**: `videoSrc` (MJPEG stream URL),
  `proxyUrl` (CORS proxy) and `useWebcam` (source switch, see above).
- **`libraries/ml5-extra-imagesegmentation.js`**: adds
  `ml5.imageSegmentation()` on top of ml5.js. It loads transformers.js and
  runs the model `Xenova/detr-resnet-50-panoptic` (WebGPU, fp16). Each
  result contains a `mask` (`p5.Image`), a `label`, a `score` and a
  `boundingBox` computed from the mask. Requests are queued, since the model
  can only run one at a time.
- **`preload()`**: creates the model with
  `ml5.imageSegmentation({ feature_extractor_size: 256 })`. A smaller size
  is faster, a larger one more precise.
- **`setup()`**: creates a full-window canvas, the video source (webcam
  640 × 480 or `<img>` with the proxied stream) and the **capture** button.
- **`doSegmentation()`**: copies the current video frame into an off-screen
  buffer `frame` and runs `segmentation.detect()` on it. The results end up
  in `results` via `gotResults()`.
- **`draw()`**: draws the video in the left half. For every entry in
  `results` it applies `result.mask` to a copy of `frame`, crops it to
  `result.boundingBox` and draws masked image, cropped segment, raw mask and
  label in a row on the right. Filter by `result.label` here to keep only
  certain objects (e.g. `"person"`).
- **`drawUrl()`**: shows the stream URL and the ready state at the bottom.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Image Segmentation

Nimmt ein Bild von der Webcam (oder einem MJPEG-Stream) auf und wendet ein
panoptisches Segmentierungsmodell darauf an. Für jedes erkannte Segment
werden das maskierte Bild, das ausgeschnittene Segment, die Maske und das
Label angezeigt. Ein Ausgangspunkt, um Objekte oder Personen aus einem
Kamerabild auszuschneiden.

## Installation

Voraussetzungen: eine Webcam (oder ein MJPEG-Stream), Chrome (das Modell
läuft auf WebGPU, andere Browser zeigen "This runs only on Chrome!") und
eine Internetverbindung – transformers.js und das Modell werden beim ersten
Start heruntergeladen.

Optional, MJPEG-Stream statt Webcam: `videoSrc` und `proxyUrl` oben in
`sketch.js` setzen und `useWebcam = false` setzen (`true`, der Standard,
verwendet die Webcam). Der Stream wird über einen CORS-Proxy geladen, den
man selbst bereitstellen muss (aufgerufen als `<proxyUrl><encoded videoSrc>`).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), ml5.js 1.2.2, `ml5-extra-imagesegmentation.js`.
transformers.js (Hugging Face) wird in der neusten Version von jsDelivr
geladen.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Den Zugriff auf die Webcam erlauben.
3. Warten, bis das Modell geladen ist (siehe Konsole, beim ersten Mal wird
   es von Hugging Face heruntergeladen), dann auf **capture** klicken.

## Coding-Hilfe

- **Konfiguration oben in `sketch.js`**: `videoSrc` (MJPEG-Stream-URL),
  `proxyUrl` (CORS-Proxy) und `useWebcam` (Umschalter für die Quelle, siehe
  oben).
- **`libraries/ml5-extra-imagesegmentation.js`**: ergänzt ml5.js um
  `ml5.imageSegmentation()`. Lädt transformers.js und führt das Modell
  `Xenova/detr-resnet-50-panoptic` aus (WebGPU, fp16). Jedes Ergebnis
  enthält eine `mask` (`p5.Image`), ein `label`, einen `score` und eine aus
  der Maske berechnete `boundingBox`. Anfragen kommen in eine Warteschlange,
  da das Modell nur eine aufs Mal verarbeiten kann.
- **`preload()`**: erstellt das Modell mit
  `ml5.imageSegmentation({ feature_extractor_size: 256 })`. Ein kleinerer
  Wert ist schneller, ein grösserer genauer.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche, die
  Videoquelle (Webcam 640 × 480 oder `<img>` mit dem Stream über den Proxy)
  und den Knopf **capture**.
- **`doSegmentation()`**: kopiert das aktuelle Videobild in einen
  Offscreen-Buffer `frame` und führt darauf `segmentation.detect()` aus. Die
  Ergebnisse landen über `gotResults()` in `results`.
- **`draw()`**: zeichnet das Video in die linke Hälfte. Für jeden Eintrag in
  `results` wird `result.mask` auf eine Kopie von `frame` angewendet, auf
  `result.boundingBox` zugeschnitten und rechts in einer Zeile als
  maskiertes Bild, Ausschnitt, Maske und Label gezeichnet. Hier nach
  `result.label` filtern, um nur bestimmte Objekte zu behalten (z. B.
  `"person"`).
- **`drawUrl()`**: zeigt unten die Stream-URL und den Ladezustand an.

</div>
