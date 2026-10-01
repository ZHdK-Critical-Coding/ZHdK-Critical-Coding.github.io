---
title: Template
maincategory: document-generation
category: batch-mode
technology: Basil.js
author: Urs Hofer
date: 2026-10-01
repo: Indesign_Basil_Batch_Template
repo_url: https://github.com/ZHdK-Critical-Coding/Indesign_Basil_Batch_Template
screenshot: "/assets/examples/indesign-basil-batch-template/screenshot.png"
related:
- Indesign_Basil_Batch_TextAndImages
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Basil.js: Template

An InDesign script that fills a layout template with content: the
document that is open in InDesign is the template. For every folder in
`source/` it fills one page – the first folder overwrites page 1, every
further folder gets a new page with the layout of page 1 – and exports the
whole document as one PDF. The template has three boxes: the first line
of `text.txt` goes into the title box, the rest into the text box, the
images into the image box; every further image gets a copy of the image
box, moved 10 px to the left and 10 px down, so the images pile up like a
stack of cards. The design lives in the template – change it in InDesign,
without touching the code. Written with
[basil.js](https://basiljs2.netlify.app), a library that brings the spirit
of Processing to InDesign.

## Installation

Requirements: Adobe InDesign. The library is included in `basiljs/`
(basil.js 2.0.0-beta, build 2025-01-19; basil.js is released under the
MIT license); the script is in
`Basil Scripts/batch_template/batch_template.jsx`.

1. Basil scripts load the library with these two lines:
   ```js
   // @includepath "~/Documents/;%USERPROFILE%Documents";
   // @include "basiljs/basil.js";
   ```
   InDesign therefore expects the library in `~/Documents/basiljs`. The
   easiest way is a symbolic link:
   ```sh
   ln -s "/path/to/Indesign_Basil_Batch_Template/basiljs" ~/Documents
   ```
   If `~/Documents/basiljs` already exists (e.g. from another basil
   example), you can keep it. Alternatively, change the `@includepath`
   line to where the library actually lives.
2. In InDesign, open the Scripts panel (*Window → Utilities → Scripts*),
   right-click the folder *User* and choose *Reveal in Finder*. Link the
   `Basil Scripts` folder into that directory:
   ```sh
   ln -s "/path/to/Indesign_Basil_Batch_Template/Basil Scripts" "/path/to/revealed/Scripts Panel"
   ```

More on the setup: the official
[getting started guide](https://basiljs2.netlify.app/tutorials/01-getting-started/).
All functions: [basil.js reference](https://basiljs2.netlify.app/reference/).
For code completion and documentation in VS Code, install the extension
from the Marketplace (search `ext:jsx basil`).

## How to Run

The template and the source material:

```
template/
  template.idml    A5 page with a title box, a text box and a 5 × 5 cm image box
source/
  glacier/
    text.txt       first line: title; an empty line starts a new paragraph
    01.jpg         images (jpg, png, tif), placed in alphabetical order
    02.jpg
  harbour/
    ...
```

1. **Open the template first**: open `template/template.idml` in
   InDesign (or your own template). **The script uses the document that is
   open and active when you start it as the template.**
2. 1. **Open the template first**: open `template/template.idml` in
   InDesign (or your own template). **The script works directly in the
   document that is open and active when you start it** and uses its
   current settings – page size, styles, frames, also changes you have
   just made and not saved.
2. Double-click `batch_template.jsx` in the Scripts panel and choose the
   `source` folder.

The script fills **page 1 with the first folder**, overwriting what was
there, and **adds one page per further folder**, each with the layout of
page 1. It then saves the whole document as one PDF in a folder `output`
next to `source`, named after the document (`output/template.pdf`). The
document stays open – check it, adjust it by hand, save it as `.indd`.

Running the script again in the same document overwrites page 1 again:
the image copies of the previous run on page 1 are removed, and if the
document has more than one page, the script asks whether to remove pages
2 to the end first. To keep the template itself unchanged, open
`template.idml` freshly for every run (IDML always opens as a new,
untitled document), or use *File → Save As* to keep a filled version.

### Changing the template

Any open document can be the template – change `template/template.idml`
and run the script directly, or save your own layout as `.indd`, `.indt`
or IDML (*File → Save a Copy…*, format *InDesign Markup (IDML)*) for
later. Page 1 of the template needs:

- a text frame with the script label `title` – for the first line of
  `text.txt`,
- a text frame with the script label `text` – for the rest,
- a graphic frame with the script label `image` – for the images.

Size, position, colours and everything else are up to you.

#### Setting a script label

1. Open the panel *Window → Utilities → Script Label*.
2. Select the frame with the **Selection tool** (black arrow, V) – not
   with the Text tool.
3. Type the label into the panel: `title`, `text` or `image`, lowercase,
   without spaces or a line break.
4. **Click on an empty spot of the page.** The label is only stored when
   the panel loses focus; clicking another frame directly can give that
   frame the label instead.
5. To check, select the frame again – the panel shows its label.

The name of a frame in the *Layers* panel is not its script label;
renaming it there has no effect on the script. The frames in
`template.idml` already have their labels.

**The placeholder text sets the look of the text**: format the text in
the `title` and `text` boxes the way the result should look – with
paragraph styles or directly (font, size, colour …); the new text takes on
exactly that formatting. All paragraphs in the text box look like the
first placeholder paragraph in it.

## Coding Help

Scripts are written in ExtendScript (an old dialect of JavaScript). A basil
script defines `draw()` and optionally `setup()`, which runs once before it;
basil calls both automatically once the library is included.

- **`setup()`**: `doc()` returns the active document – this is the
  template. (If no document is open, basil creates an empty one; it has no
  labelled frames, so the script stops with a message.) `findLabelled()`
  checks that page 1 has all three frames, then `Folder.selectDialog()` asks
  for the `source` folder.
- **`draw()` → clean up**: `units(PX)` makes `offsetX` / `offsetY` pixel
  values. Image copies of a previous run on page 1 (label `image-copy`)
  are removed; pages after page 1 are removed with `removePage()` if you
  confirm.
- **`draw()` → pages**: first, `templatePage.duplicate(LocationOptions.AT_END)`
  copies the still empty page 1 once per further folder – so every page
  starts with the same layout. Only then `fillPage()` fills page by page.
- **`fillPage()` → text**: `findLabelled()` looks for the frames with the
  script labels `title`, `text` and `image` on this page.
  `readParagraphs()` reads `text.txt` as UTF-8. The first paragraph goes
  to the title box, the others – joined with `\r` (InDesign's paragraph
  separator) – to the text box.
- **`replaceText()`**: replaces the whole text of a frame
  (`story.texts[0].contents`). Replaced text takes on the formatting of
  the text it replaces – so the look is defined in the template, not in
  the code. (Applying paragraph
  styles from the script, e.g. with `applyParagraphStyle()`, would reset
  formatting that was set directly in the template.) If the text is too
  long for the box, a message appears in the console (`println()`).
- **`fillPage()` → images**: the first image goes into the template box.
  For every further image, `duplicate()` copies the previous box onto the
  current page – set with `page(pg)` – and `transform(…, "translate",
  [offsetX, offsetY])` moves it. The copy gets the label `image-copy`, so
  only the original counts as `image`. `place()` puts the image in,
  `FitOptions.FILL_PROPORTIONALLY` fills the square and crops what sticks
  out; use `FitOptions.PROPORTIONALLY` to show the whole image instead.
  Change `offsetX` and `offsetY` at the top of the script for other
  cascades, e.g. `offsetX = 10` to move to the right.
- **Export**: `savePDF()` exports all pages with the last used PDF
  settings. The document is not closed. For one PDF per folder instead,
  set `app.pdfExportPreferences.pageRange` to the page number (e.g.
  `"2"`) and call `savePDF()` inside the loop.

</div>

<div class="lang" lang="de" markdown="1">

# Basil.js: Template

Ein InDesign-Script, das eine Layoutvorlage mit Inhalt füllt: Das in
InDesign geöffnete Dokument ist die Vorlage. Für jeden Ordner in `source/`
füllt es eine Seite – der erste Ordner überschreibt Seite 1, jeder weitere
bekommt eine neue Seite mit dem Layout von Seite 1 – und exportiert das
ganze Dokument als ein PDF. Die Vorlage hat drei Boxen: Die erste Zeile
von `text.txt` kommt in die Titelbox, der Rest in die Textbox, die Bilder
in die Bildbox; jedes weitere Bild bekommt eine Kopie der Bildbox,
10 px nach links und 10 px nach unten verschoben, sodass sich die Bilder
wie Karten stapeln. Die Gestaltung steckt in der Vorlage – sie wird in
InDesign geändert, ohne den Code anzufassen. Geschrieben mit
[basil.js](https://basiljs2.netlify.app), einer Bibliothek, die die Idee von
Processing nach InDesign bringt.

## Installation

Voraussetzungen: Adobe InDesign. Die Bibliothek liegt in `basiljs/`
(basil.js 2.0.0-beta, Build 2025-01-19; basil.js steht unter der
MIT-Lizenz); das Script liegt in
`Basil Scripts/batch_template/batch_template.jsx`.

1. Basil-Scripts laden die Bibliothek mit diesen zwei Zeilen:
   ```js
   // @includepath "~/Documents/;%USERPROFILE%Documents";
   // @include "basiljs/basil.js";
   ```
   InDesign erwartet die Bibliothek deshalb in `~/Documents/basiljs`. Am
   einfachsten geht das mit einem symbolischen Link:
   ```sh
   ln -s "/pfad/zu/Indesign_Basil_Batch_Template/basiljs" ~/Documents
   ```
   Gibt es `~/Documents/basiljs` schon (z. B. von einem anderen
   Basil-Beispiel), kann es bleiben. Alternativ die Zeile `@includepath`
   auf den Ort ändern, an dem die Bibliothek tatsächlich liegt.
2. In InDesign das Scripts-Panel öffnen (*Fenster → Hilfsprogramme →
   Skripte*), mit Rechtsklick auf den Ordner *Benutzer* *Im Finder
   anzeigen* wählen und den Ordner `Basil Scripts` dort hinein verlinken:
   ```sh
   ln -s "/pfad/zu/Indesign_Basil_Batch_Template/Basil Scripts" "/pfad/zum/angezeigten/Scripts Panel"
   ```

Mehr zur Einrichtung: die offizielle
[Getting-Started-Anleitung](https://basiljs2.netlify.app/tutorials/01-getting-started/).
Alle Funktionen: [basil.js-Referenz](https://basiljs2.netlify.app/reference/).
Für Code-Vervollständigung und Dokumentation in VS Code die Erweiterung aus
dem Marketplace installieren (Suche: `ext:jsx basil`).

## Ausführen

Die Vorlage und das Ausgangsmaterial:

```
template/
  template.idml    A5-Seite mit Titelbox, Textbox und einer Bildbox von 5 × 5 cm
source/
  glacier/
    text.txt       erste Zeile: Titel; eine Leerzeile beginnt einen neuen Absatz
    01.jpg         Bilder (jpg, png, tif), in alphabetischer Reihenfolge gesetzt
    02.jpg
  harbour/
    ...
```

1. **Zuerst die Vorlage öffnen**: `template/template.idml` (oder eine
   eigene Vorlage) in InDesign öffnen. **Das Script verwendet das Dokument
   als Vorlage, das beim Start geöffnet und aktiv ist.**
2. 1. **Zuerst die Vorlage öffnen**: `template/template.idml` (oder eine
   eigene Vorlage) in InDesign öffnen. **Das Script arbeitet direkt im
   Dokument, das beim Start geöffnet und aktiv ist**, und übernimmt
   dessen aktuelle Einstellungen – Seitenformat, Formate, Rahmen, auch
   eben gemachte, nicht gespeicherte Änderungen.
2. Im Scripts-Panel auf `batch_template.jsx` doppelklicken und den Ordner
   `source` wählen.

Das Script füllt **Seite 1 mit dem ersten Ordner** und überschreibt, was
dort war, und **fügt für jeden weiteren Ordner eine Seite hinzu**, jeweils
mit dem Layout von Seite 1. Danach speichert es das ganze Dokument als ein
PDF in einem Ordner `output` neben `source`, benannt nach dem Dokument
(`output/template.pdf`). Das Dokument bleibt offen – prüfen, von Hand
anpassen, als `.indd` speichern.

Ein weiterer Durchlauf im selben Dokument überschreibt Seite 1 erneut: Die
Bildkopien des letzten Durchlaufs auf Seite 1 werden entfernt, und hat das
Dokument mehr als eine Seite, fragt das Script, ob die Seiten 2 bis Ende
zuerst entfernt werden sollen. Um die Vorlage unverändert zu behalten,
`template.idml` für jeden Durchlauf neu öffnen (IDML öffnet sich immer als
neues, unbenanntes Dokument) oder eine gefüllte Version mit *Datei →
Speichern unter* sichern.

### Die Vorlage ändern

Jedes geöffnete Dokument kann die Vorlage sein – `template/template.idml`
ändern und das Script direkt ausführen, oder das eigene Layout für später
als `.indd`, `.indt` oder IDML speichern (*Datei → Kopie speichern…*,
Format *InDesign Markup (IDML)*). Seite 1 der Vorlage braucht:

- einen Textrahmen mit dem Skriptetikett `title` – für die erste Zeile
  von `text.txt`,
- einen Textrahmen mit dem Skriptetikett `text` – für den Rest,
- einen Grafikrahmen mit dem Skriptetikett `image` – für die Bilder.

Grösse, Position, Farben und alles andere sind frei.

#### Ein Skriptetikett setzen

1. Das Panel *Fenster → Hilfsprogramme → Skriptetikett* öffnen.
2. Den Rahmen mit dem **Auswahlwerkzeug** (schwarzer Pfeil, V) auswählen
   – nicht mit dem Textwerkzeug.
3. Das Etikett ins Panel tippen: `title`, `text` oder `image`, klein
   geschrieben, ohne Leerzeichen oder Zeilenumbruch.
4. **Auf eine leere Stelle der Seite klicken.** Das Etikett wird erst
   gespeichert, wenn das Panel den Fokus verliert; wer direkt einen
   anderen Rahmen anklickt, gibt das Etikett unter Umständen diesem.
5. Zur Kontrolle den Rahmen nochmals auswählen – das Panel zeigt sein
   Etikett.

Der Name eines Rahmens im Panel *Ebenen* ist nicht sein Skriptetikett;
ihn dort umzubenennen, hat keine Wirkung auf das Script. Die Rahmen in
`template.idml` haben ihre Etiketten schon.

**Der Platzhaltertext bestimmt das Aussehen des Textes**: Den Text in den
Boxen `title` und `text` so formatieren, wie das Ergebnis aussehen soll –
mit Absatzformaten oder direkt (Schrift, Grösse, Farbe …); der neue Text
übernimmt genau diese Formatierung. Alle Absätze in der Textbox sehen aus
wie ihr erster Platzhalterabsatz.

## Coding-Hilfe

Die Scripts sind in ExtendScript geschrieben (ein alter
JavaScript-Dialekt). Ein Basil-Script definiert `draw()` und optional
`setup()`, das einmal davor läuft; basil ruft beide automatisch auf, sobald
die Bibliothek eingebunden ist.

- **`setup()`**: `doc()` gibt das aktive Dokument zurück – das ist die
  Vorlage. (Ist kein Dokument offen, legt basil ein leeres an; es hat
  keine etikettierten Rahmen, also bricht das Script mit einer Meldung
  ab.) `findLabelled()` prüft, ob Seite 1 alle drei Rahmen hat, danach fragt
  `Folder.selectDialog()` nach dem Ordner `source`.
- **`draw()` → Aufräumen**: `units(PX)` macht `offsetX` / `offsetY` zu
  Pixelwerten. Bildkopien eines früheren Durchlaufs auf Seite 1 (Etikett
  `image-copy`) werden entfernt; Seiten nach Seite 1 entfernt
  `removePage()`, wenn man bestätigt.
- **`draw()` → Seiten**: Zuerst kopiert
  `templatePage.duplicate(LocationOptions.AT_END)` die noch leere Seite 1
  einmal pro weiterem Ordner – so beginnt jede Seite mit demselben Layout.
  Erst dann füllt `fillPage()` Seite für Seite.
- **`fillPage()` → Text**: `findLabelled()` sucht auf dieser Seite die
  Rahmen mit den Skriptetiketten `title`, `text` und `image`.
  `readParagraphs()` liest `text.txt` als UTF-8. Der erste Absatz kommt
  in die Titelbox, die übrigen – verbunden mit `\r` (dem Absatztrenner
  von InDesign) – in die Textbox.
- **`replaceText()`**: ersetzt den ganzen Text eines Rahmens
  (`story.texts[0].contents`). Ersetzter Text übernimmt die Formatierung
  des Textes, den er ersetzt – das Aussehen ist also in der Vorlage
  festgelegt, nicht im Code.
  (Absatzformate aus dem Script zuzuweisen, z. B. mit
  `applyParagraphStyle()`, würde direkt in der Vorlage gesetzte
  Formatierung zurücksetzen.) Ist der Text zu lang für die Box, erscheint
  eine Meldung in der Konsole (`println()`).
- **`fillPage()` → Bilder**: Das erste Bild kommt in die Box der Vorlage.
  Für jedes weitere Bild kopiert `duplicate()` die vorherige Box auf die
  aktuelle Seite – gesetzt mit `page(pg)` –, und `transform(…,
  "translate", [offsetX, offsetY])` verschiebt sie. Die Kopie bekommt das
  Etikett `image-copy`, damit nur das Original als `image` zählt.
  `place()` setzt das Bild ein, `FitOptions.FILL_PROPORTIONALLY` füllt das
  Quadrat und beschneidet, was übersteht; mit `FitOptions.PROPORTIONALLY`
  ist stattdessen das ganze Bild zu sehen. Für andere Kaskaden `offsetX`
  und `offsetY` oben im Script ändern, z. B. `offsetX = 10`, um nach
  rechts zu versetzen.
- **Export**: `savePDF()` exportiert alle Seiten mit den zuletzt
  verwendeten PDF-Einstellungen. Das Dokument wird nicht geschlossen. Für
  ein PDF pro Ordner stattdessen `app.pdfExportPreferences.pageRange` auf
  die Seitenzahl setzen (z. B. `"2"`) und `savePDF()` in der Schleife
  aufrufen.

</div>
