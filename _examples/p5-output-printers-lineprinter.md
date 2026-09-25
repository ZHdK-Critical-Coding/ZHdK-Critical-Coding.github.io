---
title: Line Printer
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Printers_LinePrinter
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter
related: []
render_with_liquid: false
---

# WebSocket Drucker-Sender mit p5.js

Dieses Projekt zeigt, wie man mit **p5.js** Text an einen **WebSocket-fähigen Drucker** sendet.  
Der Benutzer kann Text eingeben, Stil und Größe festlegen und über einen Button an den Drucker senden.

## Features

- Verbindung zu einem WebSocket-Drucker herstellen
- Text mit verschiedenen Stiloptionen senden:
  - Unterstrichen (u)
  - Fett + Unterstrichen (bu)
  - Fett (b)
- Textbreite (normal oder breit) und Höhe (normal oder doppelt) anpassen
- Anzeige des Druckerstatus im Browser
- Benutzeroberfläche mit Textarea und Druck-Button

## Voraussetzungen

- Browser mit WebSocket-Unterstützung
- Ein Drucker oder Server, der WebSocket-Verbindungen akzeptiert und JSON-Textdaten verarbeitet

## Verwendung

- Öffne die HTML-Seite im Browser.
- Gib den gewünschten Text in die Textarea ein.
- Klicke auf **Print**, um den Text an den Drucker zu senden.
- Der Status des Druckers wird oben im Canvas angezeigt.

## Beispiel

- 🖨️ Text wird in fett + unterstrichen auf dem Drucker ausgegeben
- 🔠 Breite und Höhe des Textes können angepasst werden
- ⚡ Echtzeit-Statusanzeige über WebSocket

## Lizenz

MIT License