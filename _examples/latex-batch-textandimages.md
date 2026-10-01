---
title: Text and Images
maincategory: document-generation
category: batch-mode
technology: LaTeX
author: Urs Hofer
date: 2026-10-01
repo: Latex_Batch_TextAndImages
repo_url: https://github.com/ZHdK-Critical-Coding/Latex_Batch_TextAndImages
screenshot: "/assets/examples/latex-batch-textandimages/screenshot.png"
related: []
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# LaTeX: Text and Images

Turns all folders in `source/` into one PDF: every folder starts on a new
page with the text from `text.txt`, followed by every image in the folder
on a page of its own. One template, any amount of material – add a folder and run the script
again. Written in LaTeX and compiled with LuaLaTeX, whose built-in
Lua scripting reads the folder and the text file.

## Installation

Requirements: a TeX distribution with LuaLaTeX, a terminal. The template
uses only standard packages (`geometry`, `fontspec`, `graphicx`).

Install a TeX distribution:

- **macOS**: [MacTeX](https://tug.org/mactex/) (about 6 GB, contains
  everything). Download the installer, or with
  [Homebrew](https://brew.sh):
  ```sh
  brew install --cask mactex-no-gui
  ```
  Open a new terminal window afterwards, so the programs are found.
- **Windows**: [MiKTeX](https://miktex.org/download). During the
  installation, allow missing packages to be installed on the fly; the
  first run then downloads what it needs.
- **Linux**: [TeX Live](https://tug.org/texlive/), e.g.
  `sudo apt install texlive-luatex texlive-latex-extra`.

Check the installation with `lualatex --version`. An editor with LaTeX
support helps, e.g. Visual Studio Code with the extension **LaTeX
Workshop**.

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
it again. An existing PDF is overwritten. If it fails, the error is in `output/document.log`.

The same by hand:

```sh
lualatex -jobname=document -output-directory=output template.tex
```

## Coding Help

LaTeX cannot list the files of a folder by itself. Lua code in
`batch.lua` does that and writes the content for all folders into the
document; `template.tex` defines what it looks like.

- **`build.sh` / `build.ps1`**: call
  `lualatex -jobname=document -output-directory=output template.tex` once;
  the jobname names the PDF. `-interaction=nonstopmode -halt-on-error` stops at the first
  error instead of waiting for input. Auxiliary `.aux` files are deleted
  at the end.
- **`template.tex`**: the layout. `geometry` sets the margins, `fontspec`
  allows Unicode text and other fonts (e.g. `\setmainfont{Helvetica}`),
  `graphicx` places the images. `\itemtitle{...}` sets the title of a
  folder, `\itemimage{...}` puts one image on its own page, fitted into
  the margins (`width=\textwidth, height=\textheight, keepaspectratio`)
  and centred vertically with `\vfill`. `\directlua{batch.items()}` runs
  the Lua code in the middle of the document and writes its content
  exactly there.
- **`batch.lua` → `items()`**: `lfs.dir()` lists `source/`; the folders
  are sorted with `table.sort()` and passed to `item()` one by one.
- **`batch.lua` → `item()` → text**: `\clearpage` starts the folder on a
  new page. `text.txt` is read line by line; the first line goes into
  `\itemtitle`.
  `tex.sprint(-2, s)` prints a string with every character taken
  literally, so `& % # $ _ { }` don't have to be escaped. To allow LaTeX
  commands in the text, use `tex.sprint(s)` instead. An empty line becomes
  `\par`.
- **`batch.lua` → `item()` → images**: files ending in `jpg`, `jpeg` or
  `png` are sorted by name, each one becomes an `\itemimage{...}`.

</div>

<div class="lang" lang="de" markdown="1">

# LaTeX: Text and Images

Macht aus allen Ordnern in `source/` ein PDF: jeder Ordner beginnt auf
einer neuen Seite mit dem Text aus `text.txt`, danach folgt jedes Bild aus
dem Ordner auf einer eigenen Seite. Eine Vorlage, beliebig viel Material – einen Ordner hinzufügen und das
Script nochmals ausführen. Geschrieben in LaTeX und
übersetzt mit LuaLaTeX, dessen eingebaute Lua-Programmierung den Ordner und
die Textdatei liest.

## Installation

Voraussetzungen: eine TeX-Distribution mit LuaLaTeX, ein Terminal. Die
Vorlage verwendet nur Standardpakete (`geometry`, `fontspec`, `graphicx`).

Eine TeX-Distribution installieren:

- **macOS**: [MacTeX](https://tug.org/mactex/) (etwa 6 GB, enthält
  alles). Den Installer herunterladen, oder mit
  [Homebrew](https://brew.sh):
  ```sh
  brew install --cask mactex-no-gui
  ```
  Danach ein neues Terminalfenster öffnen, damit die Programme gefunden
  werden.
- **Windows**: [MiKTeX](https://miktex.org/download). Bei der Installation
  erlauben, fehlende Pakete automatisch nachzuinstallieren; der erste
  Durchlauf lädt dann herunter, was er braucht.
- **Linux**: [TeX Live](https://tug.org/texlive/), z. B.
  `sudo apt install texlive-luatex texlive-latex-extra`.

Die Installation mit `lualatex --version` prüfen. Ein Editor mit
LaTeX-Unterstützung hilft, z. B. Visual Studio Code mit der Erweiterung
**LaTeX Workshop**.

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
Script nochmals ausführen. Ein bestehendes PDF wird überschrieben. Schlägt es fehl, steht der Fehler in `output/document.log`.

Dasselbe von Hand:

```sh
lualatex -jobname=document -output-directory=output template.tex
```

## Coding-Hilfe

LaTeX kann die Dateien eines Ordners nicht selbst auflisten. Das übernimmt
der Lua-Code in `batch.lua`, der den Inhalt aller Ordner ins Dokument
schreibt; wie er aussieht, legt `template.tex` fest.

- **`build.sh` / `build.ps1`**: rufen einmal
  `lualatex -jobname=document -output-directory=output template.tex` auf;
  der Jobname benennt das PDF. `-interaction=nonstopmode -halt-on-error` bricht beim ersten Fehler
  ab, statt auf eine Eingabe zu warten. Die Hilfsdateien `.aux` werden am
  Schluss gelöscht.
- **`template.tex`**: das Layout. `geometry` setzt die Ränder, `fontspec`
  erlaubt Unicode-Text und andere Schriften (z. B.
  `\setmainfont{Helvetica}`), `graphicx` setzt die Bilder. `\itemtitle{...}` setzt den Titel eines
  Ordners, `\itemimage{...}` stellt ein Bild auf eine eigene Seite,
  eingepasst in die Ränder (`width=\textwidth, height=\textheight,
  keepaspectratio`) und mit `\vfill` vertikal zentriert.
  `\directlua{batch.items()}` führt mitten im Dokument den Lua-Code aus
  und schreibt seinen Inhalt genau dort hin.
- **`batch.lua` → `items()`**: `lfs.dir()` listet `source/` auf; die
  Ordner werden mit `table.sort()` sortiert und einzeln an `item()`
  übergeben.
- **`batch.lua` → `item()` → Text**: `\clearpage` beginnt den Ordner auf
  einer neuen Seite. `text.txt` wird Zeile für Zeile gelesen; die erste
  Zeile kommt in `\itemtitle`. `tex.sprint(-2, s)` gibt einen String aus, bei dem jedes Zeichen
  wörtlich genommen wird; `& % # $ _ { }` müssen also nicht maskiert
  werden. Um LaTeX-Befehle im Text zu erlauben, stattdessen
  `tex.sprint(s)` verwenden. Eine Leerzeile wird zu `\par`.
- **`batch.lua` → `item()` → Bilder**: Dateien mit der Endung `jpg`,
  `jpeg` oder `png` werden nach Namen sortiert, jede wird zu einem
  `\itemimage{...}`.

</div>
