---
title: Basil.js Completion
maincategory: utilities
category: editors
technology: VS Code
author: Urs Hofer
date: 2026-10-01
repo: Editors_VSCode_Basil
repo_url: https://github.com/ZHdK-Critical-Coding/Editors_VSCode_Basil
related:
- Indesign_Basil_Batch_TextAndImages
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# VS Code: Basil.js Completion

A Visual Studio Code extension for writing [basil.js](https://basiljs2.netlify.app)
scripts: code completion, documentation on hover and parameter hints for
all basil functions and constants. It saves looking up the
reference while scripting InDesign, and shows what a function expects
right where you type it. The documentation is generated from the
comments in basil.js itself.

## Installation

Requirements: Visual Studio Code 1.80 or newer.

1. In VS Code, open the Extensions view (*View → Extensions*, or
   Cmd/Ctrl+Shift+X).
2. Search for `ext:jsx basil` and install **Basil.js – Code Completion
   and Documentation**.

Without Marketplace access, install the packaged file instead: run
`npm install` and `npm run package` in this repository, then in the
Extensions view *… → Install from VSIX…* and choose `basiljs-1.0.0.vsix`.

To run scripts from VS Code as well (not only from InDesign's Scripts
panel), add Adobe's
[ExtendScript Debugger](https://marketplace.visualstudio.com/items?itemName=Adobe.extendscript-debug).

License: MIT (basil.js: MIT, the basil.js team)

## How to Run

Open a basil script (a `.jsx` file with
`// @include "basiljs/basil.js";`):

- **Completion**: start typing, e.g. `rec` → `rect(x, y, w, h)`; Tab
  jumps from parameter to parameter. After `Vector.`, `HashList.`, `CSV.`
  or `JSON.` the members are listed.
- **Hover**: move the mouse over a basil function or constant to read its
  documentation and examples; the link opens the online reference.
- **Parameter hints**: appear while typing between the brackets of a
  call; Cmd/Ctrl+Shift+Space shows them again.
- **Snippets**: type `basil` for a new script with `setup()` and `draw()`,
  `basil-loop` for a looping script, `basil-batch` for a folder-to-PDF
  loop.
- **Command palette** (Cmd/Ctrl+Shift+P): *Basil.js: Open Reference* opens
  the reference page of the function under the cursor.

In `.jsx` files without the basil include (e.g. React components) the
extension stays silent. To use it in every JavaScript file, set
*Settings → Basil.js → Activation* to `always`.

### Working on the extension

1. `npm install` in this repository.
2. Open the folder in VS Code and press F5: a second VS Code window (the
   *Extension Development Host*) opens with the extension loaded and
   `test/fixtures/sketch.jsx` ready to try.
3. `npm test` runs the tests in `test/` in a downloaded copy of VS Code.

For a new basil.js version, regenerate the documentation with
`npm run generate -- path/to/basil.js`.

To publish a new version: raise `version` in `package.json`, add a line
to `CHANGELOG.md`, then `npx vsce publish` (needs a Marketplace token of
the publisher `zhdk-critical-coding`).

## Coding Help

The extension is plain JavaScript without a build step; VS Code loads
`extension.js` directly.

- **`package.json`**: the extension manifest. `activationEvents` start
  the extension when a JavaScript or JSX file is opened. Under
  `contributes` it declares the snippets, the command, the two settings
  and the language entry for `.jsx` – this is what makes the extension
  appear for the Marketplace search `ext:jsx`.
- **`scripts/generate-api.js`**: reads the JSDoc comments
  (`@summary`, `@description`, `@param`, `@return`, `@example`, …) and the
  constants from `basil.js` and writes `data/basil-api.json`. It also
  checks which functions have a page in the online reference.
- **`extension.js` → `activate()`**: registers three providers for the
  languages `javascript`, `javascriptreact` and `extendscript`, and the
  command. VS Code calls a provider whenever it needs completions, a hover
  or parameter hints.
- **`isBasil()`**: checks whether the file mentions `basil.js`. Every
  provider returns nothing otherwise.
- **`completionProvider`**: returns one `CompletionItem` per basil global,
  or the members of `Vector`, `HashList`, … when the text before the
  cursor ends with `Name.`. `insertText` is a `SnippetString` with
  `${1:x}`-style placeholders for the required parameters.
- **`hoverProvider`** / **`documentation()`**: finds the word under the
  mouse and builds a `MarkdownString` from the entry. `obj.width` is
  ignored, only a free-standing `width` is basil's.
- **`signatureProvider`** / **`currentCall()`**: walks back from the
  cursor to the open bracket of the current call, skipping strings and
  nested brackets, and counts the commas – that is the active parameter.
- **`test/extension.test.js`**: runs the providers through VS Code's own
  commands (`vscode.executeCompletionItemProvider`, …) against the files
  in `test/fixtures`.

</div>

<div class="lang" lang="de" markdown="1">

# VS Code: Basil.js Completion

Eine Erweiterung für Visual Studio Code zum Schreiben von
[basil.js](https://basiljs2.netlify.app)-Scripts: Code-Vervollständigung,
Dokumentation beim Darüberfahren und Parameterhinweise für alle
basil-Funktionen und -Konstanten. Sie erspart das Nachschlagen in der
Referenz beim Scripten von InDesign und zeigt direkt beim Tippen, was eine
Funktion erwartet. Die Dokumentation wird aus den Kommentaren in basil.js
selbst erzeugt.

## Installation

Voraussetzungen: Visual Studio Code 1.80 oder neuer.

1. In VS Code die Ansicht Erweiterungen öffnen (*Anzeigen →
   Erweiterungen*, oder Cmd/Ctrl+Shift+X).
2. Nach `ext:jsx basil` suchen und **Basil.js – Code Completion and
   Documentation** installieren.

Ohne Zugang zum Marketplace stattdessen die gepackte Datei installieren:
in diesem Repository `npm install` und `npm run package` ausführen, dann in
der Ansicht Erweiterungen *… → Aus VSIX installieren…* wählen und
`basiljs-1.0.0.vsix` öffnen.

Um Scripts auch aus VS Code auszuführen (nicht nur aus dem Scripts-Panel
von InDesign), zusätzlich Adobes
[ExtendScript Debugger](https://marketplace.visualstudio.com/items?itemName=Adobe.extendscript-debug)
installieren.

Lizenz: MIT (basil.js: MIT, das basil.js-Team)

## Ausführen

Ein Basil-Script öffnen (eine `.jsx`-Datei mit
`// @include "basiljs/basil.js";`):

- **Vervollständigung**: losschreiben, z. B. `rec` → `rect(x, y, w, h)`;
  Tab springt von Parameter zu Parameter. Nach `Vector.`, `HashList.`,
  `CSV.` oder `JSON.` werden die Mitglieder aufgelistet.
- **Hover**: mit der Maus über eine basil-Funktion oder -Konstante fahren,
  um Dokumentation und Beispiele zu lesen; der Link öffnet die
  Online-Referenz.
- **Parameterhinweise**: erscheinen beim Tippen zwischen den Klammern
  eines Aufrufs; Cmd/Ctrl+Shift+Leertaste zeigt sie erneut.
- **Snippets**: `basil` tippen für ein neues Script mit `setup()` und
  `draw()`, `basil-loop` für ein loopendes Script, `basil-batch` für eine
  Schleife vom Ordner zum PDF.
- **Befehlspalette** (Cmd/Ctrl+Shift+P): *Basil.js: Open Reference* öffnet
  die Referenzseite der Funktion unter dem Cursor.

In `.jsx`-Dateien ohne Basil-Include (z. B. React-Komponenten) bleibt die
Erweiterung stumm. Um sie in jeder JavaScript-Datei zu verwenden, unter
*Einstellungen → Basil.js → Activation* `always` wählen.

### An der Erweiterung arbeiten

1. `npm install` in diesem Repository.
2. Den Ordner in VS Code öffnen und F5 drücken: ein zweites VS-Code-Fenster
   (der *Extension Development Host*) öffnet sich mit geladener
   Erweiterung und `test/fixtures/sketch.jsx` zum Ausprobieren.
3. `npm test` führt die Tests in `test/` in einer heruntergeladenen Kopie
   von VS Code aus.

Für eine neue basil.js-Version die Dokumentation mit
`npm run generate -- pfad/zu/basil.js` neu erzeugen.

Eine neue Version veröffentlichen: `version` in `package.json` erhöhen,
eine Zeile in `CHANGELOG.md` ergänzen, dann `npx vsce publish` (braucht
ein Marketplace-Token des Publishers `zhdk-critical-coding`).

## Coding-Hilfe

Die Erweiterung ist reines JavaScript ohne Build-Schritt; VS Code lädt
`extension.js` direkt.

- **`package.json`**: das Manifest der Erweiterung. `activationEvents`
  starten die Erweiterung, sobald eine JavaScript- oder JSX-Datei geöffnet
  wird. Unter `contributes` deklariert es die Snippets, den Befehl, die
  zwei Einstellungen und den Spracheintrag für `.jsx` – dadurch erscheint
  die Erweiterung bei der Marketplace-Suche `ext:jsx`.
- **`scripts/generate-api.js`**: liest die JSDoc-Kommentare (`@summary`,
  `@description`, `@param`, `@return`, `@example`, …) und die Konstanten
  aus `basil.js` und schreibt `data/basil-api.json`. Es prüft auch, welche
  Funktionen eine Seite in der Online-Referenz haben.
- **`extension.js` → `activate()`**: registriert drei Provider für die
  Sprachen `javascript`, `javascriptreact` und `extendscript` sowie den
  Befehl. VS Code ruft einen Provider auf, sobald es Vorschläge, einen
  Hover oder Parameterhinweise braucht.
- **`isBasil()`**: prüft, ob die Datei `basil.js` erwähnt. Sonst geben
  alle Provider nichts zurück.
- **`completionProvider`**: gibt pro basil-Global ein `CompletionItem`
  zurück, oder die Mitglieder von `Vector`, `HashList`, … wenn der Text
  vor dem Cursor auf `Name.` endet. `insertText` ist ein `SnippetString`
  mit Platzhaltern im Stil `${1:x}` für die nötigen Parameter.
- **`hoverProvider`** / **`documentation()`**: findet das Wort unter der
  Maus und baut aus dem Eintrag einen `MarkdownString`. `obj.width` wird
  ignoriert, nur ein freistehendes `width` gehört zu basil.
- **`signatureProvider`** / **`currentCall()`**: geht vom Cursor zurück
  bis zur offenen Klammer des aktuellen Aufrufs, überspringt dabei Strings
  und verschachtelte Klammern und zählt die Kommas – das ergibt den
  aktiven Parameter.
- **`test/extension.test.js`**: ruft die Provider über VS Codes eigene
  Befehle auf (`vscode.executeCompletionItemProvider`, …), mit den Dateien
  in `test/fixtures`.

</div>
