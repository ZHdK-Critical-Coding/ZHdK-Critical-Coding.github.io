---
title: RTMP Stream
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Webcams_RTMPStream
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Webcams_RTMPStream
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: RTMP Stream

Plays a live camera stream in a 640×480 canvas. A shell script uses ffmpeg
to convert the camera's stream into HLS segments (`.m3u8` + `.ts`) in the
`streamer/` folder, which the sketch then loads and draws frame by frame.
A starting point for using network cameras that don't offer MJPEG. Despite
the name, the script expects an RTSP source (`rtsp://...`).

## Installation

Requirements: [ffmpeg](https://ffmpeg.org) (e.g. `brew install ffmpeg`)
and the RTSP URL of an IP camera.

Replace the placeholder `rtsp://USER:PASS@CAMERA-IP:554/stream` in the
`input` variable of `streamer/createStream.sh` with the RTSP address of
your own camera. As long as the placeholder is there, the script stops
with a hint.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), hls.js 1.6.9.

## How to Run

1. Run the script in a terminal and keep it running:
   `bash streamer/createStream.sh`
   It deletes old segments and writes `stream.m3u8` and numbered `.ts`
   files into `streamer/`.
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar). The sketch shows "Loading video..."
   until the stream can be played.

The workspace settings tell Live Server to ignore `streamer/**`, `*.ts` and
`*.m3u8`, so the constantly changing segments do not trigger reloads. The
generated files are also excluded in `.gitignore`.

## Coding Help

- **`streamer/createStream.sh`**: runs ffmpeg with `-rtsp_transport tcp`
  and copies the video without re-encoding (`-vcodec copy`, no audio) into
  HLS segments of 1 second, keeping only the last 3 in the playlist
  (`-hls_time`, `-hls_list_size`). All ffmpeg output goes to `/dev/null` –
  remove `> /dev/null 2>&1` to see errors.
- **`sketch.js` → `setup()`**: creates a hidden, muted video element. Safari
  plays HLS natively; other browsers use hls.js to load `videoSrc`
  (`./streamer/stream.m3u8`). On `canplay`, `videoReady` is set and the
  video loops.
- **`draw()`**: draws the video with `image()` onto the canvas, or a
  loading text while the stream isn't ready. Add your own processing here.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: RTMP Stream

Spielt einen Live-Kamerastream auf einer Zeichenfläche von 640×480 ab. Ein
Shell-Skript wandelt den Stream der Kamera mit ffmpeg in HLS-Segmente
(`.m3u8` + `.ts`) im Ordner `streamer/` um, die der Sketch lädt und Bild
für Bild zeichnet. Ein Ausgangspunkt, um Netzwerkkameras zu verwenden, die
kein MJPEG anbieten. Trotz des Namens erwartet das Skript eine RTSP-Quelle
(`rtsp://...`).

## Installation

Voraussetzungen: [ffmpeg](https://ffmpeg.org) (z. B.
`brew install ffmpeg`) und die RTSP-URL einer IP-Kamera.

In `streamer/createStream.sh` den Platzhalter
`rtsp://USER:PASS@CAMERA-IP:554/stream` in der Variable `input` durch die
RTSP-Adresse der eigenen Kamera ersetzen. Solange der Platzhalter drin
steht, bricht das Skript mit einem Hinweis ab.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), hls.js 1.6.9.

## Ausführen

1. Das Skript in einem Terminal starten und laufen lassen:
   `bash streamer/createStream.sh`
   Es löscht alte Segmente und schreibt `stream.m3u8` und nummerierte
   `.ts`-Dateien nach `streamer/`.
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken). Der Sketch zeigt "Loading
   video...", bis der Stream abgespielt werden kann.

Die Workspace-Einstellungen sagen Live Server, dass `streamer/**`, `*.ts`
und `*.m3u8` ignoriert werden sollen, damit die ständig wechselnden
Segmente kein Neuladen auslösen. Die erzeugten Dateien sind auch in
`.gitignore` ausgeschlossen.

## Coding-Hilfe

- **`streamer/createStream.sh`**: startet ffmpeg mit `-rtsp_transport tcp`
  und kopiert das Video ohne Neukodierung (`-vcodec copy`, ohne Ton) in
  HLS-Segmente von 1 Sekunde, wobei nur die letzten 3 in der Playlist
  bleiben (`-hls_time`, `-hls_list_size`). Die ganze Ausgabe von ffmpeg geht
  nach `/dev/null` – `> /dev/null 2>&1` entfernen, um Fehler zu sehen.
- **`sketch.js` → `setup()`**: erstellt ein verstecktes, stummes
  Video-Element. Safari spielt HLS nativ ab, andere Browser laden
  `videoSrc` (`./streamer/stream.m3u8`) mit hls.js. Bei `canplay` wird
  `videoReady` gesetzt und das Video läuft in Schleife.
- **`draw()`**: zeichnet das Video mit `image()` auf die Zeichenfläche oder
  einen Ladetext, solange der Stream nicht bereit ist. Hier die eigene
  Verarbeitung ergänzen.

</div>
