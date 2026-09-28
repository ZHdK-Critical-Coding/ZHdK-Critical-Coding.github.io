---
title: Joystick
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Devices_Joystick
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Devices_Joystick
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# P5.js: Joystick

Reads a USB joystick through the WebHID API and moves a circle with the
X/Y axes. A small square lights up while a button is pressed. A starting
point for using game controllers or other HID devices as input for a sketch.

## Installation

Requirements: a USB joystick (HID device) and Chrome or Edge (WebHID is not
available in Firefox or Safari).

1. Connect the joystick.
2. Open the folder in Visual Studio Code and start Live Server (click
   **Go Live** in the status bar).
3. Click **Connect Joystick** and move the stick.

The sketch uses `navigator.hid.getDevices()`, which only returns devices the
page has already been granted access to — it does not open a device picker.
To show the picker, use `navigator.hid.requestDevice()` instead.

Libraries (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (included, not used).

## Coding Help

- **`sketch.js` → `connectJoystick()`**: opens every HID device the browser
  can access and registers an `oninputreport` handler for each. The handler
  decodes the raw bytes: byte 0 is the button state, bytes 1–2 and 3–4 form
  the X and Y values. This byte layout is specific to the joystick the
  example was written for — adjust it for other devices.
- **Calibration and deadzone**: the first report of each device is stored
  in `calibration` as zero position. Values within ±10 of it count as 0,
  the rest is divided by 10. The results end up in `device[id].x`, `.y`
  and `.button`.
- **`setup()`**: creates the canvas and the **Connect Joystick** button.
- **`draw()`**: maps `device[0].x/y` from −50…50 to canvas coordinates,
  draws the circle, prints the values and colours the button square. Only
  the first device is drawn; loop over `device` to show more.

</div>

<div class="lang" lang="de" markdown="1">

# P5.js: Joystick

Liest einen USB-Joystick über die WebHID-API aus und bewegt einen Kreis mit
den X/Y-Achsen. Ein kleines Quadrat leuchtet, solange ein Knopf gedrückt
ist. Ein Ausgangspunkt, um Gamecontroller oder andere HID-Geräte als Input
für einen Sketch zu verwenden.

## Installation

Voraussetzungen: ein USB-Joystick (HID-Gerät) und Chrome oder Edge (WebHID
gibt es in Firefox und Safari nicht).

1. Joystick anschliessen.
2. Den Ordner in Visual Studio Code öffnen und Live Server starten (in der
   Statusleiste auf **Go Live** klicken).
3. Auf **Connect Joystick** klicken und den Stick bewegen.

Der Sketch verwendet `navigator.hid.getDevices()`. Das liefert nur Geräte,
für die die Seite bereits eine Berechtigung hat – es öffnet keinen
Auswahldialog. Für den Dialog stattdessen `navigator.hid.requestDevice()`
verwenden.

Bibliotheken (in `libraries/`): p5.js 1.10.0, p5.sound 1.0.1 (eingebunden,
nicht verwendet).

## Coding-Hilfe

- **`sketch.js` → `connectJoystick()`**: öffnet alle HID-Geräte, auf die
  der Browser zugreifen kann, und registriert für jedes einen
  `oninputreport`-Handler. Dieser dekodiert die Rohdaten: Byte 0 ist der
  Knopfzustand, Bytes 1–2 und 3–4 ergeben die X- und Y-Werte. Dieses
  Byte-Layout gilt für den Joystick, für den das Beispiel geschrieben wurde –
  für andere Geräte anpassen.
- **Kalibrierung und Totzone**: Der erste Report jedes Geräts wird in
  `calibration` als Nullposition gespeichert. Werte innerhalb von ±10 zählen
  als 0, der Rest wird durch 10 geteilt. Die Ergebnisse landen in
  `device[id].x`, `.y` und `.button`.
- **`setup()`**: erstellt die Zeichenfläche und den Knopf **Connect
  Joystick**.
- **`draw()`**: rechnet `device[0].x/y` von −50…50 in Canvas-Koordinaten
  um, zeichnet den Kreis, schreibt die Werte und färbt das Knopf-Quadrat.
  Gezeichnet wird nur das erste Gerät; für mehrere über `device` loopen.

</div>
