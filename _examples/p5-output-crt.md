---
title: CRT
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_CRT
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_CRT
related: []
render_with_liquid: false
---

# WebSocket Canvas Streaming

Dieses Projekt zeigt, wie man mit **p5.js** Frames von einem Canvas über einen **WebSocket** an einen Server streamt.  
Dabei werden die Frames als JPEG komprimiert und als Binärdaten verschickt.  

## Features

- Verbindung zu einem WebSocket-Server herstellen
- Canvas mit p5.js rendern (720 × 576 Pixel, PAL Auflösung)
- Echtzeit-Streaming der Frames (25 FPS)
- Drei bewegte Kreise in Rot, Grün und Blau als Demo
- Empfangsbestätigung `"ok"` vom Server löst den Versand des nächsten Frames aus

## Voraussetzungen

- Browser mit WebSocket-Unterstützung
- Ein laufender WebSocket-Server unter `ws://192.168.138.96:8100`

## Verwendung

- Starte den WebSocket-Server.
- Öffne die HTML-Seite (index.html) mit dem eingebundenen Skript.
- Das Canvas wird automatisch erstellt, und die Frames werden zum Server gesendet.

## Beispiel-Animation

Die Demo zeigt drei farbige Kreise, die sich horizontal mit unterschiedlicher Geschwindigkeit bewegen:

- 🔴 Rot: langsam
- 🟢 Grün: mittel
- 🔵 Blau: schnell

## Lizenz

MIT License