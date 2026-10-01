---
title: Text and Images
maincategory: document-generation
category: batch-mode
technology: Basil.js
author: Urs Hofer
date: 2026-10-01
repo: Indesign_Basil_Batch_TextAndImages
repo_url: https://github.com/ZHdK-Critical-Coding/Indesign_Basil_Batch_TextAndImages
screenshot: "/assets/examples/indesign-basil-batch-textandimages/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Basil.js: Text and Images

An InDesign script that turns all folders in `source/` into one PDF:
every folder starts on a new page with the text from `text.txt`, followed
by every image in the folder on a page of its own. It creates a new
document, fills it folder by folder and exports the PDF; the document
stays open, so you can check and refine the layout – a batch run instead
of layouting by hand. Written with
[basil.js](https://basiljs2.netlify.app), a library that brings the spirit
of Processing to InDesign.

## Installation

Requirements: Adobe InDesign. The library is included in `basiljs/`
(basil.js 2.0.0-beta, build 2025-01-19; basil.js is released under the
MIT license); the script is in `Basil Scripts/batch_pdf/batch_pdf.jsx`.

1. Basil scripts load the library with these two lines:
   ```js
   // @includepath "~/Documents/;%USERPROFILE%Documents";
   // @include "basiljs/basil.js";
   ```
   InDesign therefore expects the library in `~/Documents/basiljs`. The
   install script copies it there. Open a terminal in the repository
   folder and run
   - **macOS**: `./install_basil.sh`
   - **Windows**: `powershell -ExecutionPolicy Bypass -File install_basil.ps1`

   If basil.js is already installed (e.g. from another basil example), the
   script leaves it as it is and tells you so.

   Instead of a copy, you can also create a symbolic link, which keeps the
   library in the repository:
   ```sh
   ln -s "/path/to/Indesign_Basil_Batch_TextAndImages/basiljs" ~/Documents
   ```
   Or change the `@includepath` line to where the library actually lives.
2. In InDesign, open the Scripts panel (*Window → Utilities → Scripts*),
   right-click the folder *User* and choose *Reveal in Finder*. Link the
   `Basil Scripts` folder into that directory:
   ```sh
   ln -s "/path/to/Indesign_Basil_Batch_TextAndImages/Basil Scripts" "/path/to/revealed/Scripts Panel"
   ```

More on the setup: the official
[getting started guide](https://basiljs2.netlify.app/tutorials/01-getting-started/).
All functions: [basil.js reference](https://basiljs2.netlify.app/reference/).

## How to Run

The source material lies in `source/`, one folder per section:

```
source/
  glacier/
    text.txt     first line: title; an empty line starts a new paragraph
    01.jpg       images (jpg, png, tif), placed in alphabetical order
    02.jpg
  harbour/
    ...
```

Double-click `batch_pdf.jsx` in the Scripts panel and choose the `source`
folder. The script creates `output/document.pdf` (A4, 20 mm
margins, folders in alphabetical order) in a folder `output` next to
`source`, and reports how many folders it saved. An existing PDF is
overwritten. Replace the folders in
`source/` with your own material and run it again.

Don't click into InDesign while the script runs, wait until the message
appears. The new document stays open afterwards; save it if you want to
keep the InDesign file.

## Coding Help

Scripts are written in ExtendScript (an old dialect of JavaScript). A basil
script defines `draw()` and optionally `setup()`, which runs once before it;
basil calls both automatically once the library is included. The script
uses basil functions wherever basil has one; the full list is in the
[basil.js reference](https://basiljs2.netlify.app/reference/).

- **`setup()`**: `selectFolder()` opens the folder dialog and stores the
  chosen folder in `sourceFolder`.
- **`draw()` → document**: `app.documents.add()` creates a new document
  with single pages, `doc()` tells basil to work with it, `units(MM)`
  switches all coordinates to millimetres and `size(210, 297)` sets A4.
  `app.pdfExportPreferences.pageRange` is set to all pages, otherwise
  InDesign reuses the page range of the last export.
- **`draw()` → folders**: `getFiles()` lists the subfolders, they are
  sorted by name and `forEach()` calls `addItem()` for each of them.
- **`startPage()`**: uses page 1 for the first content and appends a new
  page with `addPage()` for everything after it, so every folder and every
  image starts on a page of its own. `margins(pageMargin)` sets the margins
  of the page, `canvasMode(MARGIN)` makes basil draw inside them: `(0, 0)`
  is the top left margin corner, `width` and `height` are the size of the
  area inside the margins.
- **`addItem()` → text**: `readParagraphs()` reads `text.txt` with
  `loadStrings()` (as UTF-8, set on the `File` with `encoding`), `trim()`s
  the lines and `join()`s them into paragraphs. In InDesign, `\r`
  separates paragraphs. `text(…, 0, 0, width, height)` creates the frame;
  font, size and alignment come from `textFont()`, `textSize()` and
  `textAlign()`, the text colour from `fill()`. `fill()` has to be set
  again for every text, because the image frames switch it off with
  `noFill()` – without it, the text would be invisible.
- **`addItem()` → formatting**: basil formats only the text that fits into
  the frame, so `typo()` applies font and size to the whole
  `parentStory`. `paragraphs(frame)[0]` is the title: 24 pt bold. While the
  frame `overflows`, `startPage()` adds a page, `text()` a new frame, and
  `linkTextFrames()` threads it to the previous one, so long texts continue
  on the following pages.
- **`addItem()` → images**: `files(folder, {filter: […]})` lists the images
  (`jpg`, `jpeg`, `png`, `tif`). For each, `rect(0, 0, width, height)`
  draws a frame inside the margins (without fill and stroke, see
  `noFill()` / `noStroke()`), and `image(file, frame)` places the image in
  it. `image()` fills the frame and crops the image, so it is fitted again
  with `FitOptions.PROPORTIONALLY` and `FitOptions.CENTER_CONTENT`. Leave
  these two lines out to fill the area instead.
- **`draw()` → export**: `file()` describes `output/document.pdf`,
  `savePDF()` creates the `output` folder if needed and exports with the
  last used PDF settings (by default *High Quality Print*). The document
  stays open and unsaved. In a batch run over many documents, close each
  one after the export with `close(false)` (without saving) or save it
  with `doc().save(new File(...))`.

</div>

<div class="lang" lang="de" markdown="1">

# Basil.js: Text and Images

Ein InDesign-Script, das aus allen Ordnern in `source/` ein PDF macht:
jeder Ordner beginnt auf einer neuen Seite mit dem Text aus `text.txt`,
danach folgt jedes Bild aus dem Ordner auf einer eigenen Seite. Es legt
ein neues Dokument an, füllt es Ordner für Ordner und exportiert das PDF;
das Dokument bleibt offen, damit man das Layout prüfen und verfeinern kann
– ein Stapellauf statt Layouten von Hand. Geschrieben mit
[basil.js](https://basiljs2.netlify.app), einer Bibliothek, die die Idee von
Processing nach InDesign bringt.

## Installation

Voraussetzungen: Adobe InDesign. Die Bibliothek liegt in `basiljs/`
(basil.js 2.0.0-beta, Build 2025-01-19; basil.js steht unter der
MIT-Lizenz); das Script liegt in `Basil Scripts/batch_pdf/batch_pdf.jsx`.

1. Basil-Scripts laden die Bibliothek mit diesen zwei Zeilen:
   ```js
   // @includepath "~/Documents/;%USERPROFILE%Documents";
   // @include "basiljs/basil.js";
   ```
   InDesign erwartet die Bibliothek deshalb in `~/Documents/basiljs`. Das
   Installations-Script kopiert sie dorthin. Ein Terminal im Ordner des
   Repositorys öffnen und ausführen:
   - **macOS**: `./install_basil.sh`
   - **Windows**: `powershell -ExecutionPolicy Bypass -File install_basil.ps1`

   Ist basil.js schon installiert (z. B. von einem anderen
   Basil-Beispiel), lässt das Script es unverändert und meldet das.

   Statt einer Kopie geht auch ein symbolischer Link; die Bibliothek bleibt
   dann im Repository:
   ```sh
   ln -s "/pfad/zu/Indesign_Basil_Batch_TextAndImages/basiljs" ~/Documents
   ```
   Oder die Zeile `@includepath` auf den Ort ändern, an dem die Bibliothek
   tatsächlich liegt.
2. In InDesign das Scripts-Panel öffnen (*Fenster → Hilfsprogramme →
   Skripte*), mit Rechtsklick auf den Ordner *Benutzer* *Im Finder
   anzeigen* wählen und den Ordner `Basil Scripts` dort hinein verlinken:
   ```sh
   ln -s "/pfad/zu/Indesign_Basil_Batch_TextAndImages/Basil Scripts" "/pfad/zum/angezeigten/Scripts Panel"
   ```

Mehr zur Einrichtung: die offizielle
[Getting-Started-Anleitung](https://basiljs2.netlify.app/tutorials/01-getting-started/).
Alle Funktionen: [basil.js-Referenz](https://basiljs2.netlify.app/reference/).

## Ausführen

Das Ausgangsmaterial liegt in `source/`, ein Ordner pro Abschnitt:

```
source/
  glacier/
    text.txt     erste Zeile: Titel; eine Leerzeile beginnt einen neuen Absatz
    01.jpg       Bilder (jpg, png, tif), in alphabetischer Reihenfolge gesetzt
    02.jpg
  harbour/
    ...
```

Im Scripts-Panel auf `batch_pdf.jsx` doppelklicken und den Ordner
`source` wählen. Das Script erzeugt `output/document.pdf` (A4, 20 mm
Rand, Ordner in alphabetischer Reihenfolge) in einem Ordner `output` neben
`source` und meldet, wie viele Ordner es gespeichert hat. Ein bestehendes
PDF wird überschrieben. Die Ordner in `source/` durch eigenes Material
ersetzen und das Script nochmals ausführen.

Während das Script läuft, nicht in InDesign klicken, sondern auf die
Meldung warten. Das neue Dokument bleibt danach offen; wer die
InDesign-Datei behalten will, speichert es.

## Coding-Hilfe

Die Scripts sind in ExtendScript geschrieben (ein alter
JavaScript-Dialekt). Ein Basil-Script definiert `draw()` und optional
`setup()`, das einmal davor läuft; basil ruft beide automatisch auf, sobald
die Bibliothek eingebunden ist. Das Script verwendet basil-Funktionen, wo
immer basil eine hat; alle stehen in der
[basil.js-Referenz](https://basiljs2.netlify.app/reference/).

- **`setup()`**: `selectFolder()` öffnet den Ordner-Dialog und speichert
  den gewählten Ordner in `sourceFolder`.
- **`draw()` → Dokument**: `app.documents.add()` legt ein neues Dokument
  mit Einzelseiten an, `doc()` sagt basil, damit zu arbeiten, `units(MM)`
  stellt alle Koordinaten auf Millimeter um und `size(210, 297)` setzt A4.
  `app.pdfExportPreferences.pageRange` wird auf alle Seiten gesetzt, sonst
  verwendet InDesign den Seitenbereich des letzten Exports.
- **`draw()` → Ordner**: `getFiles()` listet die Unterordner auf, sie
  werden nach Namen sortiert, und `forEach()` ruft für jeden `addItem()`
  auf.
- **`startPage()`**: verwendet Seite 1 für den ersten Inhalt und hängt für
  alles Weitere mit `addPage()` eine neue Seite an; so beginnt jeder
  Ordner und jedes Bild auf einer eigenen Seite. `margins(pageMargin)`
  setzt die Ränder der Seite, `canvasMode(MARGIN)` lässt basil innerhalb
  davon zeichnen: `(0, 0)` ist die obere linke Ecke des Satzspiegels,
  `width` und `height` sind die Grösse der Fläche innerhalb der Ränder.
- **`addItem()` → Text**: `readParagraphs()` liest `text.txt` mit
  `loadStrings()` (als UTF-8, gesetzt mit `encoding` auf dem `File`),
  bereinigt die Zeilen mit `trim()` und fügt sie mit `join()` zu Absätzen
  zusammen. In InDesign trennt `\r` die Absätze.
  `text(…, 0, 0, width, height)` erzeugt den Rahmen; Schrift, Grösse und
  Ausrichtung kommen von `textFont()`, `textSize()` und `textAlign()`, die
  Textfarbe von `fill()`. `fill()` muss für jeden Text neu gesetzt werden,
  weil die Bildrahmen es mit `noFill()` ausschalten – sonst wäre der Text
  unsichtbar.
- **`addItem()` → Formatierung**: basil formatiert nur den Text, der in
  den Rahmen passt; deshalb wendet `typo()` Schrift und Grösse auf die
  ganze `parentStory` an. `paragraphs(frame)[0]` ist der Titel: 24 pt
  fett. Solange der Rahmen `overflows` (Übersatz hat), fügt `startPage()`
  eine Seite an, `text()` einen neuen Rahmen, und `linkTextFrames()`
  verkettet ihn mit dem vorherigen; lange Texte laufen so auf den
  folgenden Seiten weiter.
- **`addItem()` → Bilder**: `files(ordner, {filter: […]})` listet die
  Bilder auf (`jpg`, `jpeg`, `png`, `tif`). Für jedes zeichnet
  `rect(0, 0, width, height)` einen Rahmen innerhalb der Ränder (ohne
  Fläche und Kontur, siehe `noFill()` / `noStroke()`), und
  `image(datei, rahmen)` setzt das Bild hinein. `image()` füllt den Rahmen
  und beschneidet das Bild; deshalb wird es mit
  `FitOptions.PROPORTIONALLY` und `FitOptions.CENTER_CONTENT` neu
  eingepasst. Ohne diese zwei Zeilen füllt es die Fläche.
- **`draw()` → Export**: `file()` beschreibt `output/document.pdf`,
  `savePDF()` legt den Ordner `output` bei Bedarf an und exportiert mit den
  zuletzt verwendeten PDF-Einstellungen (standardmässig *Qualitativ
  hochwertiger Druck*). Das Dokument bleibt offen und ungespeichert. Bei
  einem Stapellauf über viele Dokumente schliesst man jedes nach dem
  Export mit `close(false)` (ohne zu speichern) oder speichert es mit
  `doc().save(new File(...))`.

</div>
