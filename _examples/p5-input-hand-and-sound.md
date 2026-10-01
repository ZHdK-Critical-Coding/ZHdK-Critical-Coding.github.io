---
title: Hand and Sound
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Hand_and_Sound
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Hand_and_Sound
screenshot: "/assets/examples/p5-input-hand-and-sound/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Hand and Sound

Play tones and chords with one hand in front of the webcam. ml5.js
`handPose` tracks 21 hand landmarks, Tone.js produces the sound. The
horizontal hand position sets the pitch, the number of extended fingers
chooses the chord – a starting point for gesture-controlled instruments.

- **Left → right**: the wrist position sets the pitch (C3 … C6).
- **Number of extended fingers** chooses what is played:

| Fingers | Sound                                  |
|---------|----------------------------------------|
| 0       | silence (fist)                         |
| 1       | single tone                            |
| 2       | major, 2 tones (root + major third)    |
| 3       | major triad                            |
| 4       | major triad + octave                   |
| 5       | minor seventh + octave                 |

## Installation

Requirements: a webcam, speakers or headphones and a current browser
(Chrome or Edge recommended).

Libraries (loaded from a CDN in `index.html`): p5.js 1.11.0, ml5.js 1.x,
Tone.js 14.8.49.

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow camera access in the browser.
3. Click into the canvas to enable sound (browsers block audio until a
   user gesture).
4. Press **f** to toggle fullscreen.

## Coding Help

- **`sketch.js` → configuration**: `LOW_MIDI` / `HIGH_MIDI` set the pitch
  range the hand maps onto (MIDI 48–84). `CHORDS` defines the semitone
  intervals per finger count. `FINGERS` lists the tip and middle-joint
  landmark of each finger.
- **`setup()`**: starts the hidden webcam, runs `handPose.detectStart()`
  (results go to `hands` via `gotHands()`) and creates a `Tone.PolySynth`
  with a triangle oscillator. Change the envelope and `synth.volume` here.
- **`draw()`**: counts the extended fingers, maps the wrist x position to
  a root note, builds the chord and draws the feedback. The webcam image is
  not drawn; x coordinates are mirrored (`width - x`) so the canvas behaves
  like a mirror.
- **`getFingerStates()`**: a finger counts as extended when its tip is
  farther from the wrist than its middle joint.
- **`chordNotes()` / `setSound()`**: turn root and finger count into note
  names and play them. `setSound()` only re-triggers the synth when the
  chord changes, so a held pose does not click every frame.
- **`drawHandDebug()`, `drawTextOutput()`**: draw the landmarks (green
  fingertips = counted, red = wrist) and the finger count, chord, pitch and
  notes.
- **`mousePressed()`**: calls `Tone.start()` on the first click;
  `touchStarted()` does the same on touch screens. **`keyPressed()`**
  toggles fullscreen.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Hand and Sound

Mit einer Hand vor der Webcam Töne und Akkorde spielen. ml5.js `handPose`
erkennt 21 Punkte der Hand, Tone.js erzeugt den Klang. Die horizontale
Position der Hand bestimmt die Tonhöhe, die Anzahl gestreckter Finger den
Akkord – ein Ausgangspunkt für gestengesteuerte Instrumente.

- **Links → rechts**: Die Position des Handgelenks bestimmt die Tonhöhe
  (C3 … C6).
- **Anzahl gestreckter Finger** bestimmt, was gespielt wird:

| Finger | Klang                                  |
|--------|----------------------------------------|
| 0      | Stille (Faust)                         |
| 1      | einzelner Ton                          |
| 2      | Dur, 2 Töne (Grundton + grosse Terz)   |
| 3      | Dur-Dreiklang                          |
| 4      | Dur-Dreiklang + Oktave                 |
| 5      | Moll-Septakkord + Oktave               |

## Installation

Voraussetzungen: eine Webcam, Lautsprecher oder Kopfhörer und ein aktueller
Browser (Chrome oder Edge empfohlen).

Bibliotheken (über ein CDN in `index.html` geladen): p5.js 1.11.0,
ml5.js 1.x, Tone.js 14.8.49.

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Im Browser den Zugriff auf die Kamera erlauben.
3. In die Zeichenfläche klicken, um den Ton einzuschalten (Browser
   blockieren Audio bis zu einer Benutzeraktion).
4. Mit **f** den Vollbildmodus ein- und ausschalten.

## Coding-Hilfe

- **`sketch.js` → Konfiguration**: `LOW_MIDI` / `HIGH_MIDI` legen den
  Tonbereich fest, auf den die Hand abgebildet wird (MIDI 48–84). `CHORDS`
  definiert die Halbtonintervalle pro Fingeranzahl. `FINGERS` enthält pro
  Finger den Punkt der Fingerspitze und des Mittelgelenks.
- **`setup()`**: startet die versteckte Webcam, ruft
  `handPose.detectStart()` auf (Resultate landen über `gotHands()` in
  `hands`) und erstellt einen `Tone.PolySynth` mit Dreieck-Oszillator.
  Hüllkurve und `synth.volume` hier ändern.
- **`draw()`**: zählt die gestreckten Finger, rechnet die x-Position des
  Handgelenks in einen Grundton um, baut den Akkord und zeichnet das
  Feedback. Das Webcam-Bild wird nicht gezeichnet; die x-Koordinaten werden
  gespiegelt (`width - x`), damit sich die Zeichenfläche wie ein Spiegel
  verhält.
- **`getFingerStates()`**: Ein Finger gilt als gestreckt, wenn seine Spitze
  weiter vom Handgelenk entfernt ist als sein Mittelgelenk.
- **`chordNotes()` / `setSound()`**: machen aus Grundton und Fingeranzahl
  Notennamen und spielen sie. `setSound()` löst den Synth nur neu aus, wenn
  sich der Akkord ändert, damit eine gehaltene Pose nicht in jedem Frame
  klickt.
- **`drawHandDebug()`, `drawTextOutput()`**: zeichnen die Handpunkte (grüne
  Fingerspitzen = gezählt, rot = Handgelenk) sowie Fingeranzahl, Akkord,
  Tonhöhe und Noten.
- **`mousePressed()`**: ruft beim ersten Klick `Tone.start()` auf;
  `touchStarted()` macht dasselbe auf Touchscreens. **`keyPressed()`**
  schaltet den Vollbildmodus um.

</div>
