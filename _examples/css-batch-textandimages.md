---
title: Text and Images
maincategory: document-generation
category: batch-mode
technology: CSS
author: Urs Hofer
date: 2026-10-01
repo: CSS_Batch_TextAndImages
repo_url: https://github.com/ZHdK-Critical-Coding/CSS_Batch_TextAndImages
screenshot: "/assets/examples/css-batch-textandimages/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# CSS: Text and Images

Turns all folders in `source/` into one PDF: every folder starts on a new
page with the text from `text.txt`, followed by every image in the folder
on a page of its own. A Node.js script fills an HTML template, and a headless Chrome
(controlled with [Puppeteer](https://pptr.dev)) prints it to PDF. The
layout is plain CSS with print rules (`@page`, `break-before`), so
anything you know from web design works on paper too.

## Installation

Requirements: [Node.js](https://nodejs.org) 18 or newer (the LTS version),
a terminal.

1. Install Node.js: download the LTS installer from
   [nodejs.org](https://nodejs.org), or on macOS with
   [Homebrew](https://brew.sh): `brew install node`. Check with
   `node --version`.
2. Open a terminal in the repository folder and install the dependencies:
   ```sh
   npm install
   ```
   This installs Puppeteer (in `node_modules/`) and downloads a matching
   Chrome for Testing (about 170 MB, into `~/.cache/puppeteer`). Your own
   Chrome is not used or changed.

Libraries: puppeteer 24 (via npm).

License: MIT

## How to Run

The source material lies in `source/`, one folder per section:

```
source/
  glacier/
    text.txt     first line: title; an empty line starts a new paragraph
    01.jpg       images (jpg, png), placed in alphabetical order
    02.jpg
  harbour/
    ...
```

In the repository folder, run

```sh
npm run build
```

The script creates `output/document.pdf` (A4, 20 mm margins) with the
folders in alphabetical order. Replace the folders in `source/` with your own material and run
it again. An existing PDF is overwritten.

Next to the PDF lies the generated HTML file (`output/document.html`).
Open it in Chrome to work on `style.css`: reload after each change and use
*Print* (Cmd/Ctrl+P) to see the pages – no need to run the script every
time.

## Coding Help

- **`template.html`**: the document around the content, with the
  placeholder `{{items}}`. The stylesheet is linked as
  `../style.css`, because the generated HTML is saved in `output/`.
- **`style.css`**: the layout. `@page` sets paper size and margins (try
  `size: A5` or `size: 200mm 200mm`). `.item + .item` starts every folder
  after the first on a new page. `.image-page` starts every image on
  a new page with `break-before: page`; its height of 257 mm is A4 minus
  both margins. The image keeps its proportions with `max-width` /
  `max-height` and is centred with flexbox. Change the margin in `@page`
  and adjust the height of `.image-page` with it.
- **`build.js` → `buildItem()`**: builds one `<section class="item">`
  per folder. It reads `text.txt`; the first line is the
  title, the rest is split at empty lines into `<p>` paragraphs.
  `escapeHtml()` replaces `& < >`, so the text is printed as it is. The
  images (`jpg`, `jpeg`, `png`, sorted by name) become one
  `<div class="image-page">` each. Extend the regular expression
  `/\.(jpe?g|png)$/i` for other formats (e.g. `webp`, `gif`, `svg`).
- **`build.js` → `main()`**: starts the browser once with
  `puppeteer.launch()`, lists the folders in `source/` (sorted by name), joins
  their sections into `template.html`, writes the HTML, opens it with
  `page.goto()` and saves it with `page.pdf()`.
  `preferCSSPageSize: true` uses the size from `@page`;
  `printBackground: true` keeps background colours and images, which
  browsers otherwise leave out when printing.

</div>

<div class="lang" lang="de" markdown="1">

# CSS: Text and Images

Macht aus allen Ordnern in `source/` ein PDF: jeder Ordner beginnt auf
einer neuen Seite mit dem Text aus `text.txt`, danach folgt jedes Bild aus
dem Ordner auf einer eigenen Seite. Ein Node.js-Script füllt eine HTML-Vorlage, und ein
unsichtbares Chrome (gesteuert mit [Puppeteer](https://pptr.dev)) druckt sie
als PDF. Das Layout ist reines CSS mit Druckregeln (`@page`,
`break-before`); was man vom Webdesign kennt, funktioniert also auch auf
Papier.

## Installation

Voraussetzungen: [Node.js](https://nodejs.org) 18 oder neuer (die
LTS-Version), ein Terminal.

1. Node.js installieren: den LTS-Installer von
   [nodejs.org](https://nodejs.org) herunterladen, oder auf macOS mit
   [Homebrew](https://brew.sh): `brew install node`. Mit `node --version`
   prüfen.
2. Ein Terminal im Ordner des Repositorys öffnen und die Abhängigkeiten
   installieren:
   ```sh
   npm install
   ```
   Das installiert Puppeteer (in `node_modules/`) und lädt ein passendes
   Chrome for Testing herunter (etwa 170 MB, nach `~/.cache/puppeteer`).
   Das eigene Chrome wird weder verwendet noch verändert.

Bibliotheken: puppeteer 24 (über npm).

Lizenz: MIT

## Ausführen

Das Ausgangsmaterial liegt in `source/`, ein Ordner pro Abschnitt:

```
source/
  glacier/
    text.txt     erste Zeile: Titel; eine Leerzeile beginnt einen neuen Absatz
    01.jpg       Bilder (jpg, png), in alphabetischer Reihenfolge gesetzt
    02.jpg
  harbour/
    ...
```

Im Ordner des Repositorys ausführen:

```sh
npm run build
```

Das Script erzeugt `output/document.pdf` (A4, 20 mm Rand) mit den Ordnern
in alphabetischer Reihenfolge. Die Ordner in `source/` durch eigenes Material ersetzen und das
Script nochmals ausführen. Ein bestehendes PDF wird überschrieben.

Neben dem PDF liegt die erzeugte HTML-Datei (`output/document.html`).
Um an `style.css` zu arbeiten, diese in Chrome öffnen: nach jeder Änderung
neu laden und mit *Drucken* (Cmd/Ctrl+P) die Seiten ansehen – ohne jedes
Mal das Script auszuführen.

## Coding-Hilfe

- **`template.html`**: das Dokument rund um den Inhalt, mit dem
  Platzhalter `{{items}}`. Das Stylesheet ist als
  `../style.css` verlinkt, weil das erzeugte HTML in `output/` gespeichert
  wird.
- **`style.css`**: das Layout. `@page` legt Papierformat und Ränder fest
  (z. B. `size: A5` oder `size: 200mm 200mm` ausprobieren).
  `.item + .item` beginnt jeden Ordner nach dem ersten auf einer neuen
  Seite.
  `.image-page` beginnt jedes Bild mit `break-before: page` auf einer neuen
  Seite; die Höhe von 257 mm ist A4 minus beide Ränder. Das Bild behält
  mit `max-width` / `max-height` seine Proportionen und wird mit Flexbox
  zentriert. Wer den Rand in `@page` ändert, passt die Höhe von
  `.image-page` mit an.
- **`build.js` → `buildItem()`**: baut eine `<section class="item">`
  pro Ordner. Es liest `text.txt`; die erste Zeile ist
  der Titel, der Rest wird bei Leerzeilen in `<p>`-Absätze aufgeteilt.
  `escapeHtml()` ersetzt `& < >`, damit der Text unverändert erscheint.
  Die Bilder (`jpg`, `jpeg`, `png`, nach Namen sortiert) werden zu je
  einem `<div class="image-page">`. Für andere Formate den regulären
  Ausdruck `/\.(jpe?g|png)$/i` erweitern (z. B. `webp`, `gif`, `svg`).
- **`build.js` → `main()`**: startet den Browser einmal mit
  `puppeteer.launch()`, listet die Ordner in `source/` auf (nach Namen
  sortiert), fügt ihre Abschnitte in `template.html` ein, schreibt das HTML,
  öffnet es mit `page.goto()` und speichert es mit `page.pdf()`.
  `preferCSSPageSize: true` verwendet das Format aus `@page`;
  `printBackground: true` behält Hintergrundfarben und -bilder, die
  Browser beim Drucken sonst weglassen.

</div>
