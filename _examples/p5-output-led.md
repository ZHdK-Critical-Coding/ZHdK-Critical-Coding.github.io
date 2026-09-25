---
title: LED Matrix
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_LED
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_LED
related: []
render_with_liquid: false
---

# LED-Matrix Lauftext mit p5.js

Dieses Projekt zeigt, wie man mit **p5.js** einen farbigen Lauftext auf einer **LED-Matrix** anzeigt und die Frames über **WebSocket / ZMQ** an den LED-Server sendet.  
Der Text scrollt kontinuierlich, und jeder Matrix-Block kann unterschiedliche Farben im Verlauf darstellen.

## Features

- Verbindung zu einem LED-Matrix-Server über WebSocket/ZMQ
- Mehrere Matrizenketten unterstützen (z.B. 4 x 64×32 Pixel)
- Farbverlauf für jeden Matrixblock
- Lauftext mit benutzerdefinierbarem Inhalt
- Schriftart frei wählbar (Pixel-Schriftarten empfohlen)

## Voraussetzungen

- Browser mit WebSocket-Unterstützung
- Node.js / ZMQ-Server, der die Daten der Matrix empfangen kann
- Pixel-Schriftart (z.B. `pixelmix.ttf`) im `font`-Ordner

## Verwendung

- Stelle sicher, dass der LED-Matrix-Server läuft.
- Öffne die HTML-Seite im Browser.
- Der Text `lauftext` scrollt automatisch über die LED-Matrix.
- Farbverläufe werden pro Matrixblock angezeigt.
- Frames werden automatisch an den Server gesendet.

## Beispiel

- 🟦 Farbige Rechtecke in jedem Matrixblock
- 🔠 Pixeltext scrollt durch die gesamte Kette von LED-Matrizen
- 💨 Flüssiges Scrollen durch hohe Frame-Rate

## Lizenz

MIT License
