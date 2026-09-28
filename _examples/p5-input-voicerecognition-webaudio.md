---
title: Voice Recognition
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_VoiceRecognition_WebAudio
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_VoiceRecognition_WebAudio
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Voice Recognition

Uses the browser's Web Speech API (through the p5.speech library) to
transcribe German speech from the microphone continuously. Interim results
are shown in grey, final results in black. A starting point for voice
commands or sketches that react to spoken words.

## Installation

Requirements: a microphone, a browser that supports the Web Speech API
(e.g. Chrome) and an internet connection – recognition is done by the
browser's online speech service.

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Allow microphone access and start speaking (German).
3. To recognise another language, change `'de-DE'` in `sketch.js`
   (e.g. `'en-US'`).

Libraries (in `libraries/`): p5.js 1.10.0, p5.speech 0.0.3, p5.sound 1.0.1
(included, not used).

## Coding Help

- **`sketch.js` → top**: creates a `p5.SpeechRec` object with the language
  code and the callback `parseResult`. `continuous = true` keeps listening,
  `interimResults = true` delivers faster, less accurate results while you
  speak. The comments in the code are in German.
- **`setup()`**: creates a full-window canvas and starts recognition with
  `myRec.start()`.
- **`parseResult()`**: stores the full result object `myRec.resultJSON` in
  `recognizedResult`. For just the latest text, use `myRec.resultString`;
  this is also the place to check for keywords.
- **`draw()`**: loops over `recognizedResult.results` and prints each
  transcript, black if `isFinal`, grey otherwise.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Voice Recognition

Verwendet die Web-Speech-API des Browsers (über die Bibliothek p5.speech),
um deutsche Sprache vom Mikrofon laufend zu transkribieren.
Zwischenresultate erscheinen grau, endgültige Resultate schwarz. Ein
Ausgangspunkt für Sprachbefehle oder Sketches, die auf gesprochene Wörter
reagieren.

## Installation

Voraussetzungen: ein Mikrofon, ein Browser mit Unterstützung für die
Web-Speech-API (z. B. Chrome) und eine Internetverbindung – die Erkennung
läuft über den Online-Sprachdienst des Browsers.

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. Den Zugriff auf das Mikrofon erlauben und (auf Deutsch) sprechen.
3. Um eine andere Sprache zu erkennen, `'de-DE'` in `sketch.js` ändern
   (z. B. `'en-US'`).

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.speech 0.0.3, p5.sound
1.0.1 (eingebunden, nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → oben**: erstellt ein `p5.SpeechRec`-Objekt mit dem
  Sprachcode und dem Callback `parseResult`. `continuous = true` hört
  dauernd zu, `interimResults = true` liefert schon während des Sprechens
  schnellere, aber ungenauere Resultate.
- **`setup()`**: erstellt eine fensterfüllende Zeichenfläche und startet
  die Erkennung mit `myRec.start()`.
- **`parseResult()`**: speichert das ganze Resultat-Objekt
  `myRec.resultJSON` in `recognizedResult`. Nur den neuesten Text liefert
  `myRec.resultString`; hier ist auch der Ort, um nach Stichwörtern zu
  suchen.
- **`draw()`**: geht durch `recognizedResult.results` und schreibt jedes
  Transkript hin, schwarz wenn `isFinal`, sonst grau.

</div>
