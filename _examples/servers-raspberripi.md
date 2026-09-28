---
title: Raspberry Pi Servers
category: output
technology: Node.js
author: Urs Hofer
date: 2025-09-26
repo: Servers_RaspberriPi
repo_url: https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Node.js: Raspberry Pi Servers

Small server scripts that connect a device to a Raspberry Pi — CRT, OLED,
e-ink display, LED matrix, thermal and line printers — and make it
reachable over the network, mostly via WebSocket. A p5 sketch in the
browser draws or writes something and sends it to the Pi, which puts it on
the device. There are also helpers for streaming (MJPEG proxy), face
analysis (DeepFace) and a generic WebSocket relay.

## Installation

Requirements: a Raspberry Pi with Raspberry Pi OS, on the same network as
the computer running the sketch, and the device for the server you want to
use. Each server is a separate folder; only copy the ones you need.

1. Copy the folder to the Pi, e.g. to `/home/pi/<folder>` — the `run.sh`
   scripts `cd` into exactly that path (adjust it if you use another one).
2. Install the dependencies:
   - Node.js servers (`generic-websocket`, `printer-websockets`,
     `lp-websockets`): `npm install` in the folder.
   - Python servers: install the packages listed per server below with
     `pip install ...`.
3. Enable the hardware interface if needed (`sudo raspi-config` →
   **Interface Options**): I2C for the OLED, SPI for the e-ink display.

## How to Run

1. Start the server with `bash run.sh` (or `python server.py` /
   `node <file>.js`). To start it on boot, call `run.sh` from e.g. a
   crontab `@reboot` entry.
2. Most servers show or print their own address (`ws://<ip>:<port>`) on
   start. Put that address into the sketch.

## Coding Help

### crt-websocket — CRT / composite video (port 8100)

- **`server.py`**: receives JPEG frames as binary WebSocket messages,
  decodes them with OpenCV, converts them to RGB565 and writes them to the
  framebuffer `/dev/fb0` (720 × 576, PAL), synced to vsync. Answers `ok`
  after each frame, so the sketch sends the next one. Shows the Pi's IP in
  green on start.
- Packages: `websockets`, `numpy`, `opencv-python`.
- Sketch: [P5_Output_CRT](https://github.com/ZHdK-Critical-Coding/P5_Output_CRT). Frames must be exactly
  720 × 576 — change `WIDTH` / `HEIGHT` / `DEPTH` for another framebuffer.

### oled-websockets — SSD1306 OLED over I2C (port 8200)

- **`server.py`**: receives an image (PNG/JPEG bytes), converts it to 1 bit
  with Pillow and shows it on a 128 × 32 SSD1306. Answers `ok`. Shows IP
  and port on start. The image must match the display size (the resize line
  is commented out). `example.py` is the plain Adafruit test.
- Packages: `websockets`, `adafruit-circuitpython-ssd1306`, `pillow`.
- Sketch: [P5_Output_OLED](https://github.com/ZHdK-Critical-Coding/P5_Output_OLED).

### screen-websocket — Waveshare 4.2" e-ink (port 8765)

- **`screen.py`**: receives a PNG, resizes it to 400 × 300 and shows it in
  4 grey levels with the Waveshare driver in `lib/waveshare_epd`
  (`epd4in2`). Shows its address on start (font from `fonts/`). Sends no
  answer. There is no `run.sh`; start it with `python screen.py`.
- Packages: `websockets`, `pillow` (plus the SPI/GPIO packages the
  Waveshare driver needs).
- Sketch: [P5_Output_EInk](https://github.com/ZHdK-Critical-Coding/P5_Output_EInk).

### led — LED matrix (port 42069)

- **`run_zmq_server.sh`**: only starts the external `led-matrix-zmq-server`
  (linked as `led-matrix-zmq-server/`, must be built on the Pi) for four
  chained 64 × 32 panels, with the frame endpoint on `ws://0.0.0.0:42069`.
  The comment at the top lists all options (rows, cols, chain length,
  brightness …).
- Sketch: [P5_Output_LED](https://github.com/ZHdK-Critical-Coding/P5_Output_LED) (sends raw RGBA pixels).

### printer-websockets — ESC/POS thermal printer via USB (port 8080)

- **`printer.js`**: text as JSON `{text, w, h, style, cut}`, the string
  `cut`, or an image as binary. Images are resized with `sharp` to the
  printer width, thresholded to black/white and printed. Answers `ok`, or
  `busy` while printing. Prints its address on start. USB ids
  (`0x4b8, 0xe02`), `density` and `threshold` are set at the top.
- After `npm install`, comment out `usb.on` in
  `node_modules/escpos-usb/index.js` (see `readme.md`).
- Sketches: [P5_Output_Printers_ThermalPrinter_Lines](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines),
  [P5_Output_Printers_ThermalPrinter_Bitmap](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap).

### lp-websockets — ESC/P line printer (port 8090)

- **`printer.js`**: writes raw ESC/P commands to `/dev/usb/lp1` (or
  `lp0`). JSON `{text, w, h, style}` prints text, `{direction: "up" |
  "down", steps}` feeds the paper. Binary images are dithered with
  ImageMagick `convert` and converted with `pbmtoepson` (netpbm) — both
  must be installed.
- Sketch: [P5_Output_Printers_LinePrinter](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter).

### stream-proxy — MJPEG proxy (HTTP, port 5000)

- **`server.py`**: Flask app. `GET /stream?url=<mjpeg url>` fetches a
  camera stream and passes it on with CORS headers, so a sketch can read
  its pixels.
- Packages: `flask`, `requests`.
- Sketches: [P5_Input_Webcams_MJPEGStream](https://github.com/ZHdK-Critical-Coding/P5_Input_Webcams_MJPEGStream),
  [P5_Input_KI_ImageRecognition](https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ImageRecognition),
  [P5_Input_KI_ImageSegmentation](https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ImageSegmentation).

### deepface — face analysis (HTTP, port 7777)

- **`deepface_server.py`**: Flask app. `POST /analyze` with
  `{ "image": "<base64 image>" }` returns DeepFace's age, gender, race and
  emotion as JSON. Runs on CPU only.
- **`run_server.sh`**: restarts the server when it crashes. Adjust
  `SERVER_DIR` and the Python path.
- Packages: `deepface`, `flask`, `flask-cors`.
- Sketch: [P5_Input_KI_Deepface](https://github.com/ZHdK-Critical-Coding/P5_Input_KI_Deepface).

### generic-websocket — relay (port 9999)

- **`index.js`**: forwards every message to all other connected clients.
  Useful to connect several sketches with each other.
- Packages: `ws`.

</div>

<div class="lang" lang="de" markdown="1">

# Node.js: Raspberry Pi Servers

Kleine Server-Skripte, die ein Gerät an einen Raspberry Pi anschliessen –
CRT, OLED, E-Ink-Display, LED-Matrix, Thermo- und Zeilendrucker – und über
das Netzwerk erreichbar machen, meist per WebSocket. Ein p5-Sketch im
Browser zeichnet oder schreibt etwas und schickt es an den Pi, der es auf
das Gerät bringt. Dazu kommen Helfer fürs Streaming (MJPEG-Proxy), für
Gesichtsanalyse (DeepFace) und ein allgemeines WebSocket-Relay.

## Installation

Voraussetzungen: ein Raspberry Pi mit Raspberry Pi OS im selben Netzwerk
wie der Computer mit dem Sketch, und das Gerät zum gewünschten Server.
Jeder Server ist ein eigener Ordner; nur die benötigten kopieren.

1. Den Ordner auf den Pi kopieren, z. B. nach `/home/pi/<ordner>` – die
   `run.sh`-Skripte wechseln genau in diesen Pfad (bei einem anderen Pfad
   anpassen).
2. Abhängigkeiten installieren:
   - Node.js-Server (`generic-websocket`, `printer-websockets`,
     `lp-websockets`): `npm install` im Ordner.
   - Python-Server: die unten pro Server aufgeführten Pakete mit
     `pip install ...` installieren.
3. Falls nötig die Hardware-Schnittstelle aktivieren (`sudo raspi-config`
   → **Interface Options**): I2C für das OLED, SPI für das E-Ink-Display.

## Ausführen

1. Den Server mit `bash run.sh` starten (oder `python server.py` /
   `node <datei>.js`). Für den Start beim Booten `run.sh` z. B. über einen
   Crontab-Eintrag `@reboot` aufrufen.
2. Die meisten Server zeigen oder drucken beim Start ihre eigene Adresse
   (`ws://<ip>:<port>`). Diese Adresse im Sketch eintragen.

## Coding-Hilfe

### crt-websocket – CRT / Composite-Video (Port 8100)

- **`server.py`**: empfängt JPEG-Frames als binäre WebSocket-Nachrichten,
  dekodiert sie mit OpenCV, wandelt sie in RGB565 um und schreibt sie in
  den Framebuffer `/dev/fb0` (720 × 576, PAL), synchron zu VSync. Antwortet
  nach jedem Frame mit `ok`, damit der Sketch den nächsten schickt. Zeigt
  beim Start die IP des Pi in Grün.
- Pakete: `websockets`, `numpy`, `opencv-python`.
- Sketch: [P5_Output_CRT](https://github.com/ZHdK-Critical-Coding/P5_Output_CRT). Frames müssen genau
  720 × 576 gross sein – für einen anderen Framebuffer `WIDTH` / `HEIGHT` /
  `DEPTH` ändern.

### oled-websockets – SSD1306-OLED über I2C (Port 8200)

- **`server.py`**: empfängt ein Bild (PNG/JPEG-Bytes), wandelt es mit
  Pillow in 1 Bit um und zeigt es auf einem 128 × 32 SSD1306. Antwortet mit
  `ok`. Zeigt beim Start IP und Port. Das Bild muss so gross wie das
  Display sein (die Resize-Zeile ist auskommentiert). `example.py` ist der
  einfache Adafruit-Test.
- Pakete: `websockets`, `adafruit-circuitpython-ssd1306`, `pillow`.
- Sketch: [P5_Output_OLED](https://github.com/ZHdK-Critical-Coding/P5_Output_OLED).

### screen-websocket – Waveshare 4.2"-E-Ink (Port 8765)

- **`screen.py`**: empfängt ein PNG, skaliert es auf 400 × 300 und zeigt es
  in 4 Graustufen mit dem Waveshare-Treiber in `lib/waveshare_epd`
  (`epd4in2`). Zeigt beim Start seine Adresse (Schrift aus `fonts/`).
  Schickt keine Antwort. Es gibt kein `run.sh`; mit `python screen.py`
  starten.
- Pakete: `websockets`, `pillow` (plus die SPI/GPIO-Pakete, die der
  Waveshare-Treiber braucht).
- Sketch: [P5_Output_EInk](https://github.com/ZHdK-Critical-Coding/P5_Output_EInk).

### led – LED-Matrix (Port 42069)

- **`run_zmq_server.sh`**: startet nur den externen `led-matrix-zmq-server`
  (verlinkt als `led-matrix-zmq-server/`, muss auf dem Pi gebaut werden)
  für vier verkettete 64 × 32-Panels, mit dem Frame-Endpunkt auf
  `ws://0.0.0.0:42069`. Der Kommentar oben listet alle Optionen (Rows,
  Cols, Chain Length, Helligkeit …).
- Sketch: [P5_Output_LED](https://github.com/ZHdK-Critical-Coding/P5_Output_LED) (schickt rohe RGBA-Pixel).

### printer-websockets – ESC/POS-Thermodrucker über USB (Port 8080)

- **`printer.js`**: Text als JSON `{text, w, h, style, cut}`, den String
  `cut` oder ein Bild als Binärdaten. Bilder werden mit `sharp` auf die
  Druckerbreite skaliert, in Schwarz-Weiss umgewandelt und gedruckt.
  Antwortet mit `ok`, oder `busy`, solange gedruckt wird. Druckt beim Start
  seine Adresse. USB-IDs (`0x4b8, 0xe02`), `density` und `threshold` stehen
  oben in der Datei.
- Nach `npm install` in `node_modules/escpos-usb/index.js` die Zeile
  `usb.on` auskommentieren (siehe `readme.md`).
- Sketches: [P5_Output_Printers_ThermalPrinter_Lines](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines),
  [P5_Output_Printers_ThermalPrinter_Bitmap](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap).

### lp-websockets – ESC/P-Zeilendrucker (Port 8090)

- **`printer.js`**: schreibt rohe ESC/P-Befehle nach `/dev/usb/lp1` (oder
  `lp0`). JSON `{text, w, h, style}` druckt Text, `{direction: "up" |
  "down", steps}` bewegt das Papier. Binäre Bilder werden mit ImageMagick
  `convert` gedithert und mit `pbmtoepson` (netpbm) umgewandelt – beides
  muss installiert sein.
- Sketch: [P5_Output_Printers_LinePrinter](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter).

### stream-proxy – MJPEG-Proxy (HTTP, Port 5000)

- **`server.py`**: Flask-App. `GET /stream?url=<mjpeg-url>` holt einen
  Kamerastream und reicht ihn mit CORS-Headern weiter, damit ein Sketch
  seine Pixel lesen kann.
- Pakete: `flask`, `requests`.
- Sketches: [P5_Input_Webcams_MJPEGStream](https://github.com/ZHdK-Critical-Coding/P5_Input_Webcams_MJPEGStream),
  [P5_Input_KI_ImageRecognition](https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ImageRecognition),
  [P5_Input_KI_ImageSegmentation](https://github.com/ZHdK-Critical-Coding/P5_Input_KI_ImageSegmentation).

### deepface – Gesichtsanalyse (HTTP, Port 7777)

- **`deepface_server.py`**: Flask-App. `POST /analyze` mit
  `{ "image": "<base64-bild>" }` liefert von DeepFace Alter, Geschlecht,
  Herkunft und Emotion als JSON. Läuft nur auf der CPU.
- **`run_server.sh`**: startet den Server neu, wenn er abstürzt.
  `SERVER_DIR` und den Python-Pfad anpassen.
- Pakete: `deepface`, `flask`, `flask-cors`.
- Sketch: [P5_Input_KI_Deepface](https://github.com/ZHdK-Critical-Coding/P5_Input_KI_Deepface).

### generic-websocket – Relay (Port 9999)

- **`index.js`**: leitet jede Nachricht an alle anderen verbundenen Clients
  weiter. Praktisch, um mehrere Sketches miteinander zu verbinden.
- Pakete: `ws`.

</div>
