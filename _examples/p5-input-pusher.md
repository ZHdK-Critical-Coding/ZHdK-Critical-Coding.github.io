---
title: Pusher
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Pusher
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Pusher
screenshot: "/assets/examples/p5-input-pusher/screenshot.png"
related:
- Servers_Pusher
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Pusher

Sends messages from one p5 sketch to another over
[Pusher Channels](https://pusher.com). `Client/` has a text field and a
**Send** button, `Display/` shows the latest message on a black canvas. A
starting point for remote-controlling a sketch from a phone or another
computer.

```
Client/ (p5 sender)  --POST /message-->  Servers_Pusher (Node)  --trigger-->  Pusher "chat"  -->  Display/ (p5 receiver)
```

## Installation

Requirements: a free Channels app on https://pusher.com and the relay
server (see Server).

1. Create the Channels app and copy its **App Keys**.
2. Put your public key and cluster into `PUSHER_KEY` / `PUSHER_CLUSTER` in
   `Display/sketch.js`.

Libraries (CDN): p5.js 1.9.4, Pusher JS 8.4.0 (Display only).

## Server

Needs the Node server
[Servers_Pusher](https://github.com/ZHdK-Critical-Coding/Servers_Pusher)
(locally `../Servers_Pusher`, not part of this repo) on port 3000. The
browser can't trigger Pusher events itself — that needs the app secret,
which must never live in browser code — so the client POSTs to the server
instead. It can run on the same computer or on another machine in the
network. Set it up once; it must be running before you open the sketches
(How to Run, step 1):

```bash
git clone https://github.com/ZHdK-Critical-Coding/Servers_Pusher.git
cd Servers_Pusher
npm install
cp .env.example .env   # paste your keys into .env
```

If the server runs on another machine, change `SERVER_URL` in
`Client/sketch.js` (default `http://localhost:3000/message`).

## How to Run

1. Start the server (in the `Servers_Pusher` folder):
   ```bash
   npm start              # -> http://localhost:3000
   ```
2. Open the folder in Visual Studio Code and open `Display/index.html` and
   `Client/index.html` with Live Server (right-click → **Open with Live
   Server**).
3. Type a message in the client and click **Send** — it appears on the
   display.

## Coding Help

- **`Client/sketch.js` → `setup()`**: no canvas (`noCanvas()`), only an
  input field and a **Send** button.
- **`Client/sketch.js` → `sendMessage()`**: POSTs `{ message }` as JSON to
  `SERVER_URL` and clears the field. Empty messages are ignored.
- **`Display/sketch.js` → `setup()`**: creates the 448 × 256 canvas,
  connects with `new Pusher(PUSHER_KEY, { cluster })`, subscribes to
  `chat` and binds `new-message`, which stores `data.message` in
  `latestMessage`. Channel and event must match the server.
- **`Display/sketch.js` → `draw()`**: black background, draws
  `latestMessage` wrapped into the whole canvas. Change size, font or
  layout here.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Pusher

Schickt Nachrichten von einem p5-Sketch zu einem anderen über
[Pusher Channels](https://pusher.com). `Client/` hat ein Textfeld und einen
**Send**-Knopf, `Display/` zeigt die letzte Nachricht auf einer schwarzen
Zeichenfläche. Ein Ausgangspunkt, um einen Sketch vom Handy oder von einem
anderen Computer aus fernzusteuern.

```
Client/ (p5-Sender)  --POST /message-->  Servers_Pusher (Node)  --trigger-->  Pusher "chat"  -->  Display/ (p5-Empfänger)
```

## Installation

Voraussetzungen: eine kostenlose Channels-App auf https://pusher.com und
der Relay-Server (siehe Server).

1. Die Channels-App erstellen und die **App Keys** kopieren.
2. Den öffentlichen Key und den Cluster in `PUSHER_KEY` / `PUSHER_CLUSTER`
   in `Display/sketch.js` eintragen.

Bibliotheken (CDN): p5.js 1.9.4, Pusher JS 8.4.0 (nur Display).

## Server

Braucht den Node-Server
[Servers_Pusher](https://github.com/ZHdK-Critical-Coding/Servers_Pusher)
(lokal `../Servers_Pusher`, nicht Teil dieses Repos) auf Port 3000. Der
Browser kann selbst keine Pusher-Events auslösen – dafür braucht es das
App-Secret, das nie im Browser-Code stehen darf –, deshalb schickt der
Client per POST an den Server. Er kann auf demselben Computer oder auf
einem anderen Rechner im Netzwerk laufen. Einmal einrichten; er muss
laufen, bevor die Sketches geöffnet werden (Ausführen, Schritt 1):

```bash
git clone https://github.com/ZHdK-Critical-Coding/Servers_Pusher.git
cd Servers_Pusher
npm install
cp .env.example .env   # Keys in .env eintragen
```

Läuft der Server auf einem anderen Rechner, `SERVER_URL` in
`Client/sketch.js` anpassen (Standard `http://localhost:3000/message`).

## Ausführen

1. Den Server starten (im Ordner `Servers_Pusher`):
   ```bash
   npm start              # -> http://localhost:3000
   ```
2. Den Ordner in Visual Studio Code öffnen und `Display/index.html` und
   `Client/index.html` mit Live Server öffnen (Rechtsklick → **Open with
   Live Server**).
3. Im Client eine Nachricht eingeben und auf **Send** klicken – sie
   erscheint auf dem Display.

## Coding-Hilfe

- **`Client/sketch.js` → `setup()`**: keine Zeichenfläche (`noCanvas()`),
  nur ein Eingabefeld und ein **Send**-Knopf.
- **`Client/sketch.js` → `sendMessage()`**: schickt `{ message }` als JSON
  per POST an `SERVER_URL` und leert das Feld. Leere Nachrichten werden
  ignoriert.
- **`Display/sketch.js` → `setup()`**: erstellt die 448 × 256 grosse
  Zeichenfläche, verbindet sich mit `new Pusher(PUSHER_KEY, { cluster })`,
  abonniert `chat` und bindet `new-message`, das `data.message` in
  `latestMessage` speichert. Kanal und Event müssen zum Server passen.
- **`Display/sketch.js` → `draw()`**: schwarzer Hintergrund, zeichnet
  `latestMessage` umbrochen über die ganze Fläche. Grösse, Schrift oder
  Layout hier ändern.

</div>
