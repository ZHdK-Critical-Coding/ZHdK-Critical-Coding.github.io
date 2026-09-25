---
title: Thermal Printer Lines
category: output
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Output_Printers_ThermalPrinter_Lines
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines
related: []
render_with_liquid: false
---

# P5.js: Thermal Printer Lines

Dieses Projekt zeigt, wie man mit **p5.js** Text an einen **WebSocket-fähigen Drucker** sendet und dabei auf die Antwort des Servers wartet.  
Durch die asynchrone Umsetzung wird sichergestellt, dass jeder Druckbefehl bestätigt wird, bevor der nächste gesendet wird.

## Features

- Verbindung zu einem WebSocket-Drucker herstellen
- Text mit verschiedenen Stiloptionen senden:
  - Unterstrichen (u)
  - Fett (b)
  - Fett + Unterstrichen (bu)
- Textbreite (normal oder breit) und Höhe (normal oder doppelt) anpassen
- Optionales Papier schneiden nach dem Druck
- Anzeige des Druckerstatus im Browser
- Asynchrones Senden und Warten auf Server-Bestätigung

## Voraussetzungen

- Browser mit WebSocket-Unterstützung
- Ein Drucker oder Server, der WebSocket-Verbindungen akzeptiert und JSON-Textdaten verarbeitet

## Verwendung

- Öffne die HTML-Seite im Browser.
- Gib den gewünschten Text in die Textarea ein.
- Klicke auf **Print**, um den Text an den Drucker zu senden.
- Jeder Druckbefehl wird asynchron gesendet und wartet auf die Bestätigung vom Server.
- Der Status des Druckers wird im Canvas angezeigt.

## Beispiel

- 🖨️ Text wird in verschiedenen Stilen und Größen gesendet
- ⚡ Asynchrones Senden garantiert, dass jeder Druckbefehl bestätigt wird
- ✂️ Papier kann optional nach dem Druck geschnitten werden

## Lizenz

MIT License
