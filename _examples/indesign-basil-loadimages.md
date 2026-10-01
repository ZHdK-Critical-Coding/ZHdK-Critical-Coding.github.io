---
title: Load Images
maincategory: code-samples
category: output
technology: Basil.js
author: Urs Hofer
date: 2025-10-02
repo: Indesign_Basil_LoadImages
repo_url: https://github.com/ZHdK-Critical-Coding/Indesign_Basil_LoadImages
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Basil.js: Load Images

An InDesign script that asks for a folder and places every image it finds
(jpg, png or tif) on its own page, fitted proportionally and centred. It
fills the pages already in the document first and adds pages as needed. Written with
[basil.js](https://basiljs2.netlify.app), a library that brings the spirit
of Processing to InDesign. A starting point for generating photo books or
contact sheets from a folder of files.

## Installation

Requirements: Adobe InDesign. The library is included in `basiljs/`
(basil.js 2.0.0-beta, build 2025-01-19, with source, tests and tutorials;
basil.js is released under the MIT license); the script is in
`Basil Scripts/load_folder/load_folder.jsx`.

1. Basil scripts load the library with these two lines:
   ```js
   // @includepath "~/Documents/;%USERPROFILE%Documents";
   // @include "basiljs/basil.js";
   ```
   InDesign therefore expects the library in `~/Documents/basiljs`. The
   easiest way is a symbolic link:
   ```sh
   ln -s "/path/to/Indesign_Basil_LoadImages/basiljs" ~/Documents
   ```
   Alternatively, change the `@includepath` line to where the library
   actually lives.
2. In InDesign, open the Scripts panel (*Window → Utilities → Scripts*),
   right-click the folder *User* and choose *Reveal in Finder*. Link the
   `Basil Scripts` folder into that directory:
   ```sh
   ln -s "/path/to/Indesign_Basil_LoadImages/Basil Scripts" "/path/to/revealed/Scripts Panel"
   ```

More on the setup: the official
[getting started guide](https://basiljs2.netlify.app/tutorials/01-getting-started/).
All functions: [basil.js reference](https://basiljs2.netlify.app/reference/).

## How to Run

Double-click `load_folder.jsx` in the Scripts panel and choose a folder
with images.

The tutorials in `basiljs/scripts/tutorials` were written for basil.js 1.x,
where every function had the prefix `b.` and each script ended with
`b.go()`. If a tutorial fails, remove the `b.` prefixes and the final
`b.go();` line.

## Coding Help

Scripts are written in ExtendScript (an old dialect of JavaScript). A basil
script defines `draw()` and optionally `setup()`, which runs once before it;
basil calls both automatically once the library is included.

- **`load_folder.jsx` → `setup()`**: opens `Folder.selectDialog()` and
  stores the chosen folder in `_folder`.
- **`load_folder.jsx` → `draw()`**: lists the files in the folder with
  `getFiles()` and keeps only images. The regular expression
  `/\.(jpg|jpeg|png|tif|tiff)$/i` decides which file types are used —
  extend it for other formats.
- **The loop**: for every image, `page(i + 1)` takes the next page that
  already exists in the document (`pageCount()` tells how many there are);
  when they run out, `addPage()` appends a new page at the end. `bounds()`
  gets the page size, and `rect()` draws a frame over
  the whole page. The image is placed into the frame with `place()` and
  fitted with `FitOptions.PROPORTIONALLY` and `FitOptions.CENTER_CONTENT`.
  Use `FitOptions.FILL_PROPORTIONALLY` to fill the page instead, or change
  the `rect()` values to leave a margin.

</div>

<div class="lang" lang="de" markdown="1">

# Basil.js: Load Images

Ein InDesign-Script, das nach einem Ordner fragt und jedes Bild darin (jpg,
png oder tif) auf eine eigene Seite setzt, proportional eingepasst und
zentriert. Es füllt zuerst die Seiten, die schon im Dokument sind, und legt
bei Bedarf neue an. Geschrieben mit
[basil.js](https://basiljs2.netlify.app), einer Bibliothek, die die Idee von
Processing nach InDesign bringt. Ein Ausgangspunkt, um aus einem Ordner
Fotobücher oder Kontaktbögen zu erzeugen.

## Installation

Voraussetzungen: Adobe InDesign. Die Bibliothek liegt in `basiljs/`
(basil.js 2.0.0-beta, Build 2025-01-19, mit Quellcode, Tests und
Tutorials; basil.js steht unter der MIT-Lizenz); das Script liegt in
`Basil Scripts/load_folder/load_folder.jsx`.

1. Basil-Scripts laden die Bibliothek mit diesen zwei Zeilen:
   ```js
   // @includepath "~/Documents/;%USERPROFILE%Documents";
   // @include "basiljs/basil.js";
   ```
   InDesign erwartet die Bibliothek deshalb in `~/Documents/basiljs`. Am
   einfachsten geht das mit einem symbolischen Link:
   ```sh
   ln -s "/pfad/zu/Indesign_Basil_LoadImages/basiljs" ~/Documents
   ```
   Alternativ die Zeile `@includepath` auf den Ort ändern, an dem die
   Bibliothek tatsächlich liegt.
2. In InDesign das Scripts-Panel öffnen (*Fenster → Hilfsprogramme →
   Skripte*), mit Rechtsklick auf den Ordner *Benutzer* *Im Finder
   anzeigen* wählen und den Ordner `Basil Scripts` dort hinein verlinken:
   ```sh
   ln -s "/pfad/zu/Indesign_Basil_LoadImages/Basil Scripts" "/pfad/zum/angezeigten/Scripts Panel"
   ```

Mehr zur Einrichtung: die offizielle
[Getting-Started-Anleitung](https://basiljs2.netlify.app/tutorials/01-getting-started/).
Alle Funktionen: [basil.js-Referenz](https://basiljs2.netlify.app/reference/).

## Ausführen

Im Scripts-Panel auf `load_folder.jsx` doppelklicken und einen Ordner mit
Bildern wählen.

Die Tutorials in `basiljs/scripts/tutorials` wurden für basil.js 1.x
geschrieben, wo jede Funktion das Präfix `b.` hatte und jedes Script mit
`b.go()` endete. Funktioniert ein Tutorial nicht, die `b.`-Präfixe und die
letzte Zeile `b.go();` entfernen.

## Coding-Hilfe

Die Scripts sind in ExtendScript geschrieben (ein alter
JavaScript-Dialekt). Ein Basil-Script definiert `draw()` und optional
`setup()`, das einmal davor läuft; basil ruft beide automatisch auf, sobald
die Bibliothek eingebunden ist.

- **`load_folder.jsx` → `setup()`**: öffnet `Folder.selectDialog()` und
  speichert den gewählten Ordner in `_folder`.
- **`load_folder.jsx` → `draw()`**: listet die Dateien im Ordner mit
  `getFiles()` auf und behält nur Bilder. Der reguläre Ausdruck
  `/\.(jpg|jpeg|png|tif|tiff)$/i` bestimmt, welche Dateitypen verwendet
  werden – für andere Formate erweitern.
- **Die Schleife**: Für jedes Bild nimmt `page(i + 1)` die nächste Seite,
  die schon im Dokument ist (`pageCount()` sagt, wie viele es gibt); sind
  alle belegt, hängt `addPage()` eine neue Seite am Ende an. `bounds()`
  liefert die Seitengrösse, und `rect()`
  zeichnet einen Rahmen über die ganze Seite. Das Bild wird mit `place()` in
  den Rahmen gesetzt und mit `FitOptions.PROPORTIONALLY` und
  `FitOptions.CENTER_CONTENT` eingepasst. Mit
  `FitOptions.FILL_PROPORTIONALLY` füllt es stattdessen die Seite; für einen
  Rand die Werte in `rect()` ändern.

</div>
