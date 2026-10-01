---
title: Enter Key
maincategory: code-samples
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Devices_EnterKey
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Devices_EnterKey
screenshot: "/assets/examples/p5-input-devices-enterkey/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Enter Key

Shows three ways to react to the **Enter** key: while it is held down, as a
one-shot action on press, and as an on/off toggle. Each state is shown as a
filled circle. Useful as a pattern for buttons, foot switches or keyboard
emulators that send Enter.

## Installation

Requirements: a keyboard (or any device that sends the Enter key) and a
current browser.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not
used).

## How to Run

1. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
2. Click the canvas so it has keyboard focus.
3. Press and release **Enter**:
   - **Down** (red): filled as long as the key is held.
   - **Once** (green): lights up for one second on each press.
   - **Toggled** (blue): switches on or off each time the key is released.

## Coding Help

- **`sketch.js` → state variables**: `isDown`, `once` and `isToggled` hold
  the three states. The comments in the code are in German.
- **`keyPressed()`**: sets `isDown` only if Enter was not already down, so
  the key repeat of a held key does not trigger the one-shot action again.
  Then it calls `doOnceOnPress()`. Returns `false` to suppress the browser's
  default key behaviour.
- **`doOnceOnPress()`**: sets `once` and ignores further calls until a
  1-second `setTimeout` has reset the flag. Put your own one-shot action
  here and change the 1000 ms to adjust the lock time.
- **`keyReleased()`**: clears `isDown` and flips `isToggled`.
- **`draw()`**: draws the three circles and fills them according to the
  states. To react to another key, replace `ENTER` with another `keyCode`
  (e.g. `32` for space) in both key handlers.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Enter Key

Zeigt drei Arten, auf die **Enter**-Taste zu reagieren: solange sie
gedrückt ist, als einmalige Aktion beim Drücken und als Ein/Aus-Schalter.
Jeder Zustand wird als gefüllter Kreis angezeigt. Nützlich als Muster für
Taster, Fussschalter oder Tastatur-Emulatoren, die Enter senden.

## Installation

Voraussetzungen: eine Tastatur (oder ein Gerät, das die Enter-Taste sendet)
und ein aktueller Browser.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Ausführen

1. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
2. In die Zeichenfläche klicken, damit sie den Tastatur-Fokus hat.
3. **Enter** drücken und loslassen:
   - **Down** (rot): gefüllt, solange die Taste gedrückt ist.
   - **Once** (grün): leuchtet bei jedem Drücken eine Sekunde auf.
   - **Toggled** (blau): schaltet bei jedem Loslassen ein oder aus.

## Coding-Hilfe

- **`sketch.js` → Zustandsvariablen**: `isDown`, `once` und `isToggled`
  speichern die drei Zustände.
- **`keyPressed()`**: setzt `isDown` nur, wenn Enter nicht schon gedrückt
  war. So löst die Tastenwiederholung einer gehaltenen Taste die einmalige
  Aktion nicht erneut aus. Danach wird `doOnceOnPress()` aufgerufen. Gibt
  `false` zurück, um das Standardverhalten des Browsers zu unterdrücken.
- **`doOnceOnPress()`**: setzt `once` und ignoriert weitere Aufrufe, bis
  ein `setTimeout` von einer Sekunde das Flag zurücksetzt. Hier die eigene
  einmalige Aktion einfügen; mit den 1000 ms die Sperrzeit anpassen.
- **`keyReleased()`**: setzt `isDown` zurück und schaltet `isToggled` um.
- **`draw()`**: zeichnet die drei Kreise und füllt sie je nach Zustand. Um
  auf eine andere Taste zu reagieren, in beiden Tasten-Handlern `ENTER`
  durch einen anderen `keyCode` ersetzen (z. B. `32` für die Leertaste).

</div>
