---
title: Essentia Audio Analysis
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-10-28
repo: P5_Input_Essentia
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Essentia
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Essentia Audio Analysis

Loads an mp3 file in the browser and analyzes it with
[essentia.js](https://mtg.github.io/essentia.js/), the WebAssembly version of
the Essentia audio analysis library. The results – tempo, key,
loudness, danceability, frame-wise spectral centroid, mood
(happy, sad, relaxed, aggressive, party) and 50 tags (genres, moods,
decades…) – are stored in the global object `analysis` and drawn as raw JSON on the canvas. A
starting point for visualizations based on music analysis, without any server.

## Installation

Requirements: a current browser (Chrome, Edge or Firefox).

Libraries (in `libraries/`): p5.js 1.10.0, essentia.js 0.1.3
(`essentia-wasm.es.js` with the embedded WebAssembly binary,
`essentia.js-core.es.js` and `essentia.js-model.es.js`, from the npm package
`essentia.js`), TensorFlow.js 3.21.0 (`tf.min.js`).

Models (in `models/`, about 18 MB): the MusiCNN classifiers
`mood_*-musicnn-msd-2` and the auto-tagger `msd-musicnn-1` from the
[Essentia models](https://essentia.upf.edu/models.html), converted for
TensorFlow.js. `metadata.json` in each folder lists the class labels. The
models are licensed CC BY-NC-SA 4.0 (non-commercial use only).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Wait until the status says the models are loaded, then choose an mp3 file
   with the file input at the top left. Everything runs in the browser and
   takes roughly 10 seconds per minute of audio; the page does not react
   during that time. The first file takes longer, because TensorFlow.js
   first prepares its WebGL shaders.
3. Scroll the JSON with the mouse wheel. The same data is printed to the
   browser console and is available as `analysis` in the console.

## Coding Help

All essentia.js and TensorFlow.js code is in the class `AudioAnalyzer` in
`analyzer.js`. The sketch only needs two functions:

```js
let analyzer = new AudioAnalyzer()

await analyzer.load(["happy", "sad", "tags"])          // optional: preload models
let analysis = await analyzer.analyze(file, { models: ["happy", "sad", "tags"] })
```

- **`analyzer.load(models)`**: loads essentia.js and the given models
  (default: all). Optional – `analyze()` loads missing models itself, but
  then the first analysis takes longer.
- **`analyzer.analyze(file, options)`**: `file` is a `File`, `Blob` or URL
  (e.g. `"assets/song.mp3"`). `options.models` chooses the models: `"happy"`,
  `"sad"`, `"relaxed"`, `"aggressive"`, `"party"` and `"tags"` (default: all,
  `[]` for none). Returns an object with:
  - `duration`, `loudness`, `dynamicComplexity`, `danceability`
  - `bpm`, `beatConfidence`
  - `key`, `scale`, `keyStrength`
  - `frames.spectralCentroid`: one value per frame; frame
    `i` starts at `i * frames.hopSize / frames.sampleRate` seconds
  - `mood`: probability (0–1) per mood model, e.g. `mood.happy`
  - `tags`: probabilities of all 50 tags, sorted from most to least likely
- **`analyzer.status`**: a short text about what the analyzer is doing,
  e.g. for `draw()`.

In `sketch.js`:

- **`setup()`**: creates the canvas, calls `analyzer.load(models)` and
  creates a file input (`createFileInput`).
- **`handleFile(file)`**: called by the file input. Stores the result of
  `analyzer.analyze()` in the global `analysis` and converts it to text
  lines with `toJSON()` and `wrapLines()`.
- **`draw()`**: draws `analyzer.status` and the visible part of the JSON
  lines; **`mouseWheel()`** scrolls them.

Inside `analyzer.js`: `decode()` and `resample()` turn the file into mono
signals at 44.1 kHz (essentia algorithms) and 16 kHz (models). `features()`
runs `RhythmExtractor2013`, `KeyExtractor`, `Loudness` etc. and the
frame-wise `SpectralCentroidTime`. `classify()` computes the mel
spectrogram with `EssentiaTFInputExtractor` and runs each model;
`predict()` averages the predictions of all 3-second patches. More
algorithms are listed in the
[essentia.js API reference](https://mtg.github.io/essentia.js/docs/api/Essentia.html).
To add a model, download its TensorFlow.js version (`*-tfjs.zip`) and its
`.json` file from the Essentia models page, put `model.json`, the `.bin` file
and the `.json` as `metadata.json` into a new folder in `models/` and add it
to `MODELS` at the top of `analyzer.js`.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Essentia Audio Analysis

Lädt eine mp3-Datei im Browser und analysiert sie mit
[essentia.js](https://mtg.github.io/essentia.js/), der WebAssembly-Version der
Audioanalyse-Bibliothek Essentia. Die Resultate – Tempo, Tonart,
Lautheit, Tanzbarkeit, spektraler Schwerpunkt pro Frame, Stimmung
(happy, sad, relaxed, aggressive, party) und 50 Tags (Genres, Stimmungen,
Jahrzehnte…) – werden
im globalen Objekt `analysis` gespeichert und als rohes JSON auf die
Zeichenfläche geschrieben. Ein Ausgangspunkt für Visualisierungen auf Basis
von Musikanalyse, ganz ohne Server.

## Installation

Voraussetzungen: ein aktueller Browser (Chrome, Edge oder Firefox).

Bibliotheken (in `libraries/`): p5.js 1.10.0, essentia.js 0.1.3
(`essentia-wasm.es.js` mit eingebettetem WebAssembly-Binary,
`essentia.js-core.es.js` und `essentia.js-model.es.js`, aus dem npm-Paket
`essentia.js`), TensorFlow.js 3.21.0 (`tf.min.js`).

Modelle (in `models/`, etwa 18 MB): die MusiCNN-Klassifikatoren
`mood_*-musicnn-msd-2` und der Auto-Tagger `msd-musicnn-1` aus den
[Essentia-Modellen](https://essentia.upf.edu/models.html), konvertiert für
TensorFlow.js. `metadata.json` in jedem Ordner enthält die Klassennamen. Die
Modelle stehen unter CC BY-NC-SA 4.0 (nur nicht-kommerzielle Nutzung).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Warten, bis der Status meldet, dass die Modelle geladen sind, dann mit
   dem Dateifeld oben links eine mp3-Datei auswählen. Alles läuft im
   Browser und dauert etwa 10 Sekunden pro Minute Audio; die Seite reagiert
   in dieser Zeit nicht. Die erste Datei dauert länger, weil TensorFlow.js
   zuerst seine WebGL-Shader vorbereitet.
3. Das JSON mit dem Mausrad scrollen. Dieselben Daten werden in der
   Browser-Konsole ausgegeben und sind dort als `analysis` verfügbar.

## Coding-Hilfe

Der ganze essentia.js- und TensorFlow.js-Code steckt in der Klasse
`AudioAnalyzer` in `analyzer.js`. Der Sketch braucht nur zwei Funktionen:

```js
let analyzer = new AudioAnalyzer()

await analyzer.load(["happy", "sad", "tags"])          // optional: Modelle vorladen
let analysis = await analyzer.analyze(file, { models: ["happy", "sad", "tags"] })
```

- **`analyzer.load(models)`**: lädt essentia.js und die angegebenen Modelle
  (Standard: alle). Optional – `analyze()` lädt fehlende Modelle selbst,
  dann dauert die erste Analyse aber länger.
- **`analyzer.analyze(file, options)`**: `file` ist ein `File`, ein `Blob`
  oder eine URL (z. B. `"assets/song.mp3"`). `options.models` wählt die
  Modelle: `"happy"`, `"sad"`, `"relaxed"`, `"aggressive"`, `"party"` und
  `"tags"` (Standard: alle, `[]` für keine). Gibt ein Objekt zurück mit:
  - `duration`, `loudness`, `dynamicComplexity`, `danceability`
  - `bpm`, `beatConfidence`
  - `key`, `scale`, `keyStrength`
  - `frames.spectralCentroid`: ein Wert pro Frame; Frame
    `i` beginnt bei `i * frames.hopSize / frames.sampleRate` Sekunden
  - `mood`: Wahrscheinlichkeit (0–1) pro Stimmungsmodell, z. B. `mood.happy`
  - `tags`: Wahrscheinlichkeiten aller 50 Tags, absteigend sortiert
- **`analyzer.status`**: ein kurzer Text darüber, was der Analyzer gerade
  tut, z. B. für `draw()`.

In `sketch.js`:

- **`setup()`**: erstellt die Zeichenfläche, ruft `analyzer.load(models)`
  auf und erstellt ein Dateifeld (`createFileInput`).
- **`handleFile(file)`**: wird vom Dateifeld aufgerufen. Speichert das
  Resultat von `analyzer.analyze()` im globalen `analysis` und wandelt es
  mit `toJSON()` und `wrapLines()` in Textzeilen um.
- **`draw()`**: zeichnet `analyzer.status` und den sichtbaren Teil der
  JSON-Zeilen; **`mouseWheel()`** scrollt sie.

In `analyzer.js`: `decode()` und `resample()` machen aus der Datei
Mono-Signale mit 44.1 kHz (essentia-Algorithmen) und 16 kHz (Modelle).
`features()` führt `RhythmExtractor2013`, `KeyExtractor`, `Loudness` usw.
sowie `SpectralCentroidTime` pro Frame aus. `classify()` berechnet
das Mel-Spektrogramm mit `EssentiaTFInputExtractor` und führt jedes Modell
aus; `predict()` mittelt die Vorhersagen aller 3-Sekunden-Abschnitte.
Weitere Algorithmen stehen in der
[essentia.js-API-Referenz](https://mtg.github.io/essentia.js/docs/api/Essentia.html).
Um ein Modell hinzuzufügen, dessen TensorFlow.js-Version (`*-tfjs.zip`) und
`.json`-Datei von der Essentia-Modellseite herunterladen, `model.json`, die
`.bin`-Datei und die `.json` als `metadata.json` in einen neuen Ordner in
`models/` legen und ihn in `MODELS` oben in `analyzer.js` eintragen.

</div>
