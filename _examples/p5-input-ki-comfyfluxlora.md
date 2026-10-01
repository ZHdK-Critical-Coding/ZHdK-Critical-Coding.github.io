---
title: Comfy Flux Lora
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_KI_ComfyFluxLora
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ComfyFluxLora
screenshot: "/assets/examples/p5-input-ki-comfyfluxlora/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Comfy Flux Lora

Sends a text prompt to a ComfyUI server, runs a Flux workflow with a LoRA
and shows the generated image on a 1024 × 1024 canvas. A starting point for
driving your own ComfyUI workflows (with custom models and LoRAs) from a
sketch.

## Installation

Requirements: a running ComfyUI server (see Server).

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used), [p5.comfyui-helper](https://github.com/gohai/p5.comfyui-helper) by
Gottfried Haider.

## Server

Needs a [ComfyUI](https://github.com/comfyanonymous/ComfyUI) server on port
8188, usually on a machine with a GPU — on the same computer or on another
machine in the network. Start it before the sketch; to allow access from
other machines and from the browser, start it with
`python main.py --listen --enable-cors-header`. The workflow
`workflows/Flux-Lora-Simple-Beocom2000.ai.json` expects:

- UNet `FLUX1/flux_dev_fp8_scaled_diffusion_model.safetensors`
- VAE `FLUX1/diffusion_pytorch_model.safetensors`
- CLIP `t5/t5xxl_fp8_e4m3fn.safetensors` and `clip_l.safetensors`
- LoRA `AI-Toolkit/beocom_2000_v.1/beocom_2000_v.1.safetensors`
- the custom node **CR SDXL Aspect Ratio** (ComfyUI Comfyroll nodes)
- the **SaveImageWebsocket** node (included with ComfyUI)

Set the server address in the `instance` constant at the top of
`sketch.js` (default `http://192.168.2.8:8188`).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. The browser calls ComfyUI cross-origin. If ComfyUI isn't started with
   `--enable-cors-header` (see Server), use the debugger configuration
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
- **`requestImage()`**: writes a random seed into node `25` (RandomNoise)
  and the prompt into node `6` (CLIPTextEncode), then calls
  `await comfy.run(workflow, gotImage)`. If the request fails (e.g. server
  not reachable), the error is logged and `running` is reset so you can try
  again. Change other nodes here the same way, e.g. steps in node `17`, LoRA
  strength in node `72`, image size in node `85` (`width`/`height`; its
  `aspect_ratio` is set to `custom` so these values apply – the default
  1024 × 1024 matches the square canvas). If you use your own workflow,
  adapt the node numbers.
- **`libraries/p5.comfyui-helper.js`**: replaces `SaveImage` with
  `SaveImageWebsocket`, queues the workflow via `/prompt` and collects the
  result images from the WebSocket as blob URLs.
- **`gotImage(results, err)`**: loads the first result into `resImg` (if
  there is one; on an error `results` is empty and `err` is logged).
  Uncomment `requestImage()` at the end to generate images in a loop.
- **`draw()`**: draws `resImg` scaled to the canvas and the pulsing dot
  while `running` is true.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Comfy Flux Lora

Schickt einen Text-Prompt an einen ComfyUI-Server, führt einen
Flux-Workflow mit einer LoRA aus und zeigt das generierte Bild auf einer
1024 × 1024 grossen Zeichenfläche. Ein Ausgangspunkt, um eigene
ComfyUI-Workflows (mit eigenen Modellen und LoRAs) aus einem Sketch
anzusteuern.

## Installation

Voraussetzungen: ein laufender ComfyUI-Server (siehe Server).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet), [p5.comfyui-helper](https://github.com/gohai/p5.comfyui-helper)
von Gottfried Haider.

## Server

Braucht einen [ComfyUI](https://github.com/comfyanonymous/ComfyUI)-Server
auf Port 8188, meist auf einem Rechner mit GPU – auf demselben Computer
oder auf einem anderen Rechner im Netzwerk. Vor dem Sketch starten; damit
andere Rechner und der Browser zugreifen können, mit
`python main.py --listen --enable-cors-header` starten. Der Workflow
`workflows/Flux-Lora-Simple-Beocom2000.ai.json` erwartet:

- UNet `FLUX1/flux_dev_fp8_scaled_diffusion_model.safetensors`
- VAE `FLUX1/diffusion_pytorch_model.safetensors`
- CLIP `t5/t5xxl_fp8_e4m3fn.safetensors` und `clip_l.safetensors`
- LoRA `AI-Toolkit/beocom_2000_v.1/beocom_2000_v.1.safetensors`
- den Custom Node **CR SDXL Aspect Ratio** (ComfyUI Comfyroll Nodes)
- den Node **SaveImageWebsocket** (in ComfyUI enthalten)

Die Adresse des Servers in der Konstante `instance` oben in `sketch.js`
eintragen (Standard `http://192.168.2.8:8188`).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Der Browser greift Cross-Origin auf ComfyUI zu. Ist ComfyUI nicht mit
   `--enable-cors-header` gestartet (siehe Server), die
   Debugger-Konfiguration **Launch Chrome (no Security)** verwenden (Panel
   Run and Debug).
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
- **`requestImage()`**: schreibt einen zufälligen Seed in Node `25`
  (RandomNoise) und den Prompt in Node `6` (CLIPTextEncode) und ruft dann
  `await comfy.run(workflow, gotImage)` auf. Schlägt die Anfrage fehl (z. B.
  Server nicht erreichbar), wird der Fehler geloggt und `running`
  zurückgesetzt, sodass man es erneut versuchen kann. Andere Nodes lassen
  sich hier gleich ändern, z. B. die Steps in Node `17`, die LoRA-Stärke in
  Node `72`, die Bildgrösse in Node `85` (`width`/`height`; `aspect_ratio`
  steht auf `custom`, damit diese Werte gelten – die Standardgrösse
  1024 × 1024 passt zur quadratischen Zeichenfläche). Bei einem eigenen
  Workflow die Node-Nummern anpassen.
- **`libraries/p5.comfyui-helper.js`**: ersetzt `SaveImage` durch
  `SaveImageWebsocket`, stellt den Workflow über `/prompt` in die
  Warteschlange und sammelt die Ergebnisbilder aus dem WebSocket als
  Blob-URLs.
- **`gotImage(results, err)`**: lädt das erste Ergebnis in `resImg` (falls
  vorhanden; bei einem Fehler ist `results` leer und `err` wird geloggt). Wer
  `requestImage()` am Ende einkommentiert, generiert Bilder in einer
  Schleife.
- **`draw()`**: zeichnet `resImg` skaliert auf die Zeichenfläche und den
  pulsierenden Punkt, solange `running` true ist.

</div>
