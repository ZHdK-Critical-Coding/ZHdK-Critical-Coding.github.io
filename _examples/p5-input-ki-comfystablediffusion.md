---
title: Comfy Stable Diffusion
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_ComfyStableDiffusion
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ComfyStableDiffusion
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Comfy Stable Diffusion

Sends a text prompt to a ComfyUI server, runs a basic Stable Diffusion 1.5
text-to-image workflow and shows the result on the canvas. The simplest way
to get started with generating images from a sketch through ComfyUI.

## Installation

Requirements: a ComfyUI instance reachable from your computer (usually on
the local network, with a GPU). The workflow `workflows/workflow_api.json`
expects the checkpoint `SD1.5/v1-5-pruned-emaonly.ckpt` and the
**SaveImageWebsocket** node (included with ComfyUI).

Set the address of your ComfyUI server in the `instance` constant at the
top of `sketch.js` (default `http://192.168.2.8:8188`).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), [p5.comfyui-helper](https://github.com/gohai/p5.comfyui-helper) by
Gottfried Haider.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. The browser calls ComfyUI cross-origin. Either start ComfyUI with
   `--enable-cors-header`, or use the debugger configuration
   **Launch Chrome (no Security)** (Run and Debug panel).
3. Edit the prompt in the text field and press **generate**. A pulsing red
   dot is shown while the image is being generated.

## Coding Help

- **Config at the top of `sketch.js`**: `instance` (ComfyUI URL),
  `workflowfile` (file name in `workflows/`) and `defaultPrompt`.
- **`preload()`**: loads the workflow JSON. It must be exported in ComfyUI's
  API format (**Save (API)**); the keys are the node numbers.
- **`setup()`**: creates the canvas, the `ComfyUiP5Helper` (opens a
  WebSocket to ComfyUI), the prompt textarea and the **generate** button.
- **`requestImage()`**: writes a random seed into the KSampler node `3` and
  the prompt into node `6` (positive prompt), then calls
  `await comfy.run(workflow, gotImage)`. If the request fails (e.g. server
  not reachable), an alert shows the error and `running` is reset so you
  can try again. The negative prompt is in node `7`, the
  image size (512 × 512) in node `5`. If you use your own workflow, adapt
  the node numbers.
- **`libraries/p5.comfyui-helper.js`**: replaces `SaveImage` with
  `SaveImageWebsocket`, queues the workflow via `/prompt` and collects the
  result images from the WebSocket as blob URLs.
- **`gotImage(results, err)`**: loads the first result into `resImg`.
  Uncomment `requestImage()` at the end to generate images in a loop.
- **`draw()`**: draws `resImg` scaled to the 1024 × 1024 canvas and the
  pulsing dot while `running` is true.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Comfy Stable Diffusion

Schickt einen Text-Prompt an einen ComfyUI-Server, führt einen einfachen
Stable-Diffusion-1.5-Workflow (Text zu Bild) aus und zeigt das Ergebnis auf
der Zeichenfläche. Der einfachste Einstieg, um aus einem Sketch über
ComfyUI Bilder zu generieren.

## Installation

Voraussetzungen: eine ComfyUI-Instanz, die vom eigenen Computer aus
erreichbar ist (meist im lokalen Netz, mit GPU). Der Workflow
`workflows/workflow_api.json` erwartet den Checkpoint
`SD1.5/v1-5-pruned-emaonly.ckpt` und den Node **SaveImageWebsocket** (in
ComfyUI enthalten).

Die Adresse des ComfyUI-Servers in der Konstante `instance` oben in
`sketch.js` eintragen (Standard `http://192.168.2.8:8188`).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), [p5.comfyui-helper](https://github.com/gohai/p5.comfyui-helper)
von Gottfried Haider.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Der Browser greift Cross-Origin auf ComfyUI zu. Entweder ComfyUI mit
   `--enable-cors-header` starten oder die Debugger-Konfiguration
   **Launch Chrome (no Security)** verwenden (Panel Run and Debug).
3. Den Prompt im Textfeld anpassen und auf **generate** klicken. Während
   das Bild generiert wird, pulsiert ein roter Punkt.

## Coding-Hilfe

- **Konfiguration oben in `sketch.js`**: `instance` (ComfyUI-URL),
  `workflowfile` (Dateiname in `workflows/`) und `defaultPrompt`.
- **`preload()`**: lädt das Workflow-JSON. Es muss im API-Format von
  ComfyUI exportiert sein (**Save (API)**); die Schlüssel sind die
  Node-Nummern.
- **`setup()`**: erstellt die Zeichenfläche, den `ComfyUiP5Helper` (öffnet
  einen WebSocket zu ComfyUI), das Prompt-Textfeld und den Knopf
  **generate**.
- **`requestImage()`**: schreibt einen zufälligen Seed in den
  KSampler-Node `3` und den Prompt in Node `6` (positiver Prompt) und ruft
  dann `await comfy.run(workflow, gotImage)` auf. Schlägt die Anfrage fehl
  (z. B. Server nicht erreichbar), zeigt ein Alert den Fehler und `running`
  wird zurückgesetzt, sodass man es erneut versuchen kann. Der negative
  Prompt steht in
  Node `7`, die Bildgrösse (512 × 512) in Node `5`. Bei einem eigenen
  Workflow die Node-Nummern anpassen.
- **`libraries/p5.comfyui-helper.js`**: ersetzt `SaveImage` durch
  `SaveImageWebsocket`, stellt den Workflow über `/prompt` in die
  Warteschlange und sammelt die Ergebnisbilder aus dem WebSocket als
  Blob-URLs.
- **`gotImage(results, err)`**: lädt das erste Ergebnis in `resImg`. Wer
  `requestImage()` am Ende einkommentiert, generiert Bilder in einer
  Schleife.
- **`draw()`**: zeichnet `resImg` skaliert auf die 1024 × 1024 grosse
  Zeichenfläche und den pulsierenden Punkt, solange `running` true ist.

</div>
