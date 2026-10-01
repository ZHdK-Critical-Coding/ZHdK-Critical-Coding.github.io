---
title: Text and Images
maincategory: document-generation
category: batch-mode
technology: Typst
author: Urs Hofer
date: 2026-10-01
repo: Typst_Batch_TextAndImages
repo_url: https://github.com/ZHdK-Critical-Coding/Typst_Batch_TextAndImages
screenshot: "/assets/examples/typst-batch-textandimages/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Typst: Text and Images

Turns all folders in `source/` into one PDF: every folder starts on a new
page with the text from `text.txt`, followed by every image in the folder
on a page of its own. One template, any amount of material – add a folder and run the
script again. Written in [Typst](https://typst.app), a modern, fast
alternative to LaTeX with a readable markup language.

## Installation

Requirements: Typst 0.12 or newer (command line), a terminal. Optional:
Visual Studio Code with the extension **Tinymist Typst** for a live preview
of `template.typ`.

Install Typst:

- **macOS** (with [Homebrew](https://brew.sh)):
  ```sh
  brew install typst
  ```
- **Windows** (PowerShell):
  ```sh
  winget install --id Typst.Typst
  ```
- **Linux / without a package manager**: download the archive for your
  system from the [Typst releases](https://github.com/typst/typst/releases),
  unpack it and put the `typst` program into a folder in your `PATH`.

Check the installation with `typst --version`. No other libraries are
needed; Typst brings its own fonts.

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

Open a terminal in the repository folder and run

- **macOS / Linux**: `./build.sh`
- **Windows**: `powershell -ExecutionPolicy Bypass -File build.ps1`

The script creates `output/document.pdf` (A4, 20 mm margins) with the
folders in alphabetical order. Replace the folders in `source/` with your own material and run
it again. An existing PDF is overwritten.

To work on the layout, open `template.typ` in VS Code and start the
Tinymist preview: without inputs from the script, the template shows the
folder `glacier`.

## Coding Help

Typst cannot list the files of a folder by itself. The build script does
that and hands the lists to Typst, which builds the whole PDF in one run.

- **`build.sh` / `build.ps1`**: collect the folder names in `source/`
  and the images of all folders as `folder/name` (`jpg`, `jpeg`, `png`,
  sorted by name), then call
  `typst compile --root . --input items=<folders> --input images=<images> template.typ output/document.pdf`.
  `--input` hands values to the template, `--root .` allows the template
  to read files anywhere in the repository. Extend the pattern
  `\.(jpe?g|png)$` for other file types (Typst also reads `gif`, `svg`
  and `webp`).
- **`template.typ` → inputs**: `sys.inputs.at("items", default: …)` reads
  the values from the command line. The defaults are used by the live
  preview. Both arrive as one string with one entry per line and are split
  into arrays.
- **`template.typ` → page setup**: `#set page(...)`, `#set text(...)` and
  `#set par(...)` define format, margins, font size and justification for
  the whole document. Change `paper: "a4"` to e.g. `"a5"` or set your own
  `width` and `height`; add `font: "…"` to `#set text` for another font.
- **`template.typ` → folders**: `for item in items` builds one section
  per folder. `pagebreak(weak: true)` starts every section on a new page
  (but adds no empty page at the very beginning).
- **`template.typ` → text**: `read()` loads `text.txt` as a string. The
  first line becomes the title, the rest is split at empty lines into
  paragraphs. The text is used as plain text, so characters like `*`, `_`
  or `#` are printed as they are.
- **`template.typ` → images**: `images.filter(...)` picks the images whose
  path starts with the folder name. For every image, `page(...)` creates a
  new page. `image(..., width: 100%, height: 100%, fit: "contain")` scales the
  image to the area inside the margins without cropping it. Use
  `fit: "cover"` to fill the area, or `page(margin: 0, …)` for full-bleed
  images.

</div>

<div class="lang" lang="de" markdown="1">

# Typst: Text and Images

Macht aus allen Ordnern in `source/` ein PDF: jeder Ordner beginnt auf
einer neuen Seite mit dem Text aus `text.txt`, danach folgt jedes Bild aus
dem Ordner auf einer eigenen Seite. Eine Vorlage, beliebig viel Material – einen Ordner hinzufügen und das
Script nochmals ausführen. Geschrieben in
[Typst](https://typst.app), einer modernen, schnellen Alternative zu LaTeX
mit gut lesbarer Auszeichnungssprache.

## Installation

Voraussetzungen: Typst 0.12 oder neuer (Kommandozeile), ein Terminal.
Optional: Visual Studio Code mit der Erweiterung **Tinymist Typst** für eine
Live-Vorschau von `template.typ`.

Typst installieren:

- **macOS** (mit [Homebrew](https://brew.sh)):
  ```sh
  brew install typst
  ```
- **Windows** (PowerShell):
  ```sh
  winget install --id Typst.Typst
  ```
- **Linux / ohne Paketmanager**: das Archiv für das eigene System von den
  [Typst-Releases](https://github.com/typst/typst/releases) herunterladen,
  entpacken und das Programm `typst` in einen Ordner im `PATH` legen.

Die Installation mit `typst --version` prüfen. Weitere Bibliotheken
braucht es nicht; Typst bringt eigene Schriften mit.

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

Ein Terminal im Ordner des Repositorys öffnen und ausführen:

- **macOS / Linux**: `./build.sh`
- **Windows**: `powershell -ExecutionPolicy Bypass -File build.ps1`

Das Script erzeugt `output/document.pdf` (A4, 20 mm Rand) mit den Ordnern
in alphabetischer Reihenfolge. Die Ordner in `source/` durch eigenes Material ersetzen und das
Script nochmals ausführen. Ein bestehendes PDF wird überschrieben.

Um am Layout zu arbeiten, `template.typ` in VS Code öffnen und die
Tinymist-Vorschau starten: ohne Werte vom Script zeigt die Vorlage den
Ordner `glacier`.

## Coding-Hilfe

Typst kann die Dateien eines Ordners nicht selbst auflisten. Das übernimmt das Build-Script; es übergibt die Listen an Typst, das das
ganze PDF in einem Durchgang erzeugt.

- **`build.sh` / `build.ps1`**: sammeln die Ordnernamen in `source/` und die
  Bilder aller Ordner als `ordner/name` (`jpg`, `jpeg`, `png`, nach Namen
  sortiert) und rufen
  `typst compile --root . --input items=<ordner> --input images=<bilder> template.typ output/document.pdf`
  auf. `--input` übergibt Werte an die Vorlage, `--root .` erlaubt der
  Vorlage, Dateien überall im Repository zu lesen. Für andere Dateitypen
  das Muster `\.(jpe?g|png)$` erweitern (Typst liest auch `gif`, `svg` und
  `webp`).
- **`template.typ` → Eingaben**: `sys.inputs.at("items", default: …)` liest
  die Werte von der Kommandozeile. Die Standardwerte verwendet die
  Live-Vorschau. Beide kommen als ein String mit einem Eintrag pro Zeile an
  und werden in Arrays aufgeteilt.
- **`template.typ` → Seiteneinstellungen**: `#set page(...)`,
  `#set text(...)` und `#set par(...)` legen Format, Ränder, Schriftgrösse
  und Blocksatz für das ganze Dokument fest. `paper: "a4"` z. B. auf
  `"a5"` ändern oder eigene Werte für `width` und `height` setzen; mit
  `font: "…"` in `#set text` eine andere Schrift wählen.
- **`template.typ` → Ordner**: `for item in items` baut einen Abschnitt
  pro Ordner. `pagebreak(weak: true)` beginnt jeden Abschnitt auf einer
  neuen Seite (ohne ganz am Anfang eine leere Seite einzufügen).
- **`template.typ` → Text**: `read()` lädt `text.txt` als String. Die
  erste Zeile wird zum Titel, der Rest wird bei Leerzeilen in Absätze
  aufgeteilt. Der Text wird als reiner Text verwendet, Zeichen wie `*`,
  `_` oder `#` erscheinen also unverändert.
- **`template.typ` → Bilder**: `images.filter(...)` wählt die Bilder,
  deren Pfad mit dem Ordnernamen beginnt. Für jedes Bild erzeugt
  `page(...)` eine neue Seite. `image(..., width: 100%, height: 100%, fit: "contain")`
  skaliert das Bild auf die Fläche innerhalb der Ränder, ohne es zu
  beschneiden. Mit `fit: "cover"` füllt es die Fläche, mit
  `page(margin: 0, …)` geht es bis an den Seitenrand.

</div>
