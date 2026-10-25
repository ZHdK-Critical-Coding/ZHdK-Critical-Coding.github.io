---
title: JavaScript & p5.js
title_de: JavaScript & p5.js
order: 3
folder: P5.js
repo_url: https://github.com/ZHdK-Critical-Coding/Manuals/tree/main/P5.js
render_with_liquid: false
---

# JavaScript & p5.js

Selbstlern-Material zu p5.js – Ablauf, Befehlsreferenz und lauffähige Beispiele.

## Ressourcen

- **Reference** – Die offizielle Funktionsreferenz: <https://p5js.org/reference/>
- **Cheat Sheet** – Übersichtliche Kurzreferenz für Künstler:innen: <https://livinbits.github.io/p5js-cheatsheet-forartists/>
- **Coding Train** von Dan Shiffman – Video-Tutorials zum Programmieren mit p5.js: <https://thecodingtrain.com/tracks/code-programming-with-p5-js>
- **The Nature of Code** von Dan Shiffman – Simulation natürlicher Systeme mit Code: <https://natureofcode.com/>
- **Awesome Creative Coding** – Eine lange Liste mit Ressourcen zum Creative Coding: <https://github.com/terkelg/awesome-creative-coding>

## Beispiele (lauffähige Projekte)

Jedes Beispiel ist ein eigener Ordner mit `index.html` und `sketch.js`. Die
p5.js-Bibliothek wird vom CDN geladen – einfach die `index.html` im Browser
öffnen, es ist kein lokaler Server nötig.

### Basics – Grundlagen
- `Basics/01_setup_und_draw` – `setup()` und `draw()`, Canvas erstellen
- `Basics/02_formen` – Kreise, Rechtecke, Linien, Dreiecke zeichnen
- `Basics/03_farben` – `fill()`, `stroke()`, `strokeWeight()`, Transparenz
- `Basics/04_interaktion` – Maus und Tastatur (`mouseX`, `mousePressed()`, …)
- `Basics/05_text` – Text und Zahlen auf das Canvas schreiben

### Arrays – Listen von Werten
- `Arrays/01_array_grundlagen` – Array erstellen, Index, `length`
- `Arrays/02_array_und_schleife` – Array mit `for`-Schleife durchlaufen
- `Arrays/03_array_mit_objekten` – ein Array voller Objekte (Bälle)
- `Arrays/04_hinzufuegen_entfernen` – `push()`, `shift()`, `pop()` zur Laufzeit

### Objekte – Objekte & Klassen
- `Objekte/01_objekte_einfuehrung` – was ein Objekt ist
- `Objekte/02_objekte_literale` – Eigenschaften lesen und ändern
- `Objekte/03_methoden` – Methoden definieren, `this` verstehen
- `Objekte/04_klassen` – ES6-Klassen, Konstruktoren
- `Objekte/05_vererbung` – Klassen erweitern (`extends`, `super()`)
- `Objekte/06_mini_projekt` – mehrere Objekte zusammen animieren

---

## Ablauf: Basics (Selbstlern-Workbook)

### Lektion 1: Setup und Draw
- Ziel: Verstehen, was `setup()` und `draw()` tun
- Ordner: `Basics/01_setup_und_draw`
- Aufgaben: Ein Canvas erstellen und etwas darauf zeichnen

### Lektion 2: Formen
- Ziel: Die wichtigsten Zeichen-Funktionen kennenlernen
- Ordner: `Basics/02_formen`
- Aufgaben: Kreise, Rechtecke, Linien und Dreiecke auf das Canvas setzen

### Lektion 3: Farben
- Ziel: Füllung, Umrandung und Transparenz steuern
- Ordner: `Basics/03_farben`
- Aufgaben: `fill()`, `stroke()` und `strokeWeight()` ausprobieren

### Lektion 4: Interaktion
- Ziel: Auf Maus und Tastatur reagieren
- Ordner: `Basics/04_interaktion`
- Aufgaben: Formen mit `mouseX`/`mouseY` steuern, auf Klicks und Tasten reagieren

### Lektion 5: Text
- Ziel: Text und Zahlen ausgeben
- Ordner: `Basics/05_text`
- Aufgaben: `text()` und `textSize()` nutzen, Variablen anzeigen

---

## Ablauf: Arrays (Selbstlern-Workbook)

### Lektion 1: Array-Grundlagen
- Ziel: Verstehen, was ein Array ist
- Ordner: `Arrays/01_array_grundlagen`
- Aufgaben: Array erstellen, über den Index zugreifen, `length` auslesen

### Lektion 2: Array und Schleife
- Ziel: Ein Array mit einer `for`-Schleife durchlaufen
- Ordner: `Arrays/02_array_und_schleife`
- Aufgaben: Array befüllen und alle Elemente zeichnen

### Lektion 3: Array mit Objekten
- Ziel: Objekte in einem Array speichern
- Ordner: `Arrays/03_array_mit_objekten`
- Aufgaben: Mehrere Objekte erzeugen, durchlaufen und animieren

### Lektion 4: Hinzufügen & Entfernen
- Ziel: Arrays zur Laufzeit verändern
- Ordner: `Arrays/04_hinzufuegen_entfernen`
- Aufgaben: Mit `push()`, `shift()` und `pop()` Elemente hinzufügen und entfernen

---

## Ablauf: Objekte & Klassen (Selbstlern-Workbook)

### Lektion 1: Einführung in Objekte
- Ziel: Verstehen, was Objekte sind
- Ordner: `Objekte/01_objekte_einfuehrung`
- Aufgaben: Erstes Objekt erstellen und visualisieren

### Lektion 2: Objektliterale & Zugriff
- Ziel: Eigenschaften lesen, ändern, iterieren
- Ordner: `Objekte/02_objekte_literale`
- Aufgaben: Neues Objekt erstellen und auf Canvas darstellen

### Lektion 3: Methoden in Objekten
- Ziel: Methoden definieren, `this` verstehen
- Ordner: `Objekte/03_methoden`
- Aufgaben: Methoden aufrufen, Bewegung oder Farbe verändern

### Lektion 4: ES6-Klassen
- Ziel: Klassen erstellen, Konstruktoren, Methoden
- Ordner: `Objekte/04_klassen`
- Aufgaben: Objekte instanziieren, zeichnen, Berechnungen durchführen

### Lektion 5: Vererbung & Subklassen
- Ziel: Klassen erweitern, `extends`, `super()`
- Ordner: `Objekte/05_vererbung`
- Aufgaben: Subklasse erstellen, neue Eigenschaften und Methoden hinzufügen

### Lektion 6: Mini-Projekt
- Ziel: Interaktive Objekte mit Klassen, Animationen, Interaktion
- Ordner: `Objekte/06_mini_projekt`
- Aufgaben: Eigenes kleines p5.js-Projekt umsetzen

---

## p5.js-Befehlsreferenz

### I. Struktur und Basis-Setup (Functions)

- **`function setup()`:** Wird einmal aufgerufen und ausgeführt, wenn das Programm startet. Es wird verwendet, um Standardwerte festzulegen.
- **`function draw()`:** Wird direkt nach `setup()` aufgerufen und führt den Code in seinen geschweiften Klammern 60 Mal pro Sekunde aus.
- **`createCanvas()`:** Erstellt ein HTML-Canvas. Die Argumente legen die Breite und Höhe in Pixeln fest (z. B. `createCanvas(400, 400)` oder `createCanvas(600, 400)` oder `createCanvas(windowWidth, windowHeight)`).
- **`noLoop()`:** Eine Funktion, die aufgerufen werden kann, um zu verhindern, dass die `draw()`-Funktion kontinuierlich ausgeführt wird.
- **`fullscreen(true)`:** Fullscreen ein oder ausschalten
- **`windowResized()`:** wird ausgeführt wenn das Fenster verändert wird.
- **`resizeCanvas(breite, höhe)`:** Verändert dynamisch die Grösse des Canvas

### II. Hintergrund und Farbeinstellungen (Color)

- **`background()`:** Legt die Farbe fest, die für den Hintergrund des Canvas verwendet wird. Kann mit einem Graustufenwert (z. B. `background(220)`), mit drei Zahlen für RGB-Werte (z. B. `background(135, 206, 235)`), mit einem String für HTML-Farbnamen oder mit HEX-Farbwerten verwendet werden.
- **`fill()`:** Legt die Füllfarbe für Formen fest. Muss *vor* der Zeichnungsfunktion der Form aufgerufen werden.
- **`stroke()`:** Legt die Farbe für Linien und Umrisse fest.
- **`strokeWeight()`:** Legt die Dicke von Linien, Umrissen und Punkten fest. Der Wert wird in Pixeln angegeben (z. B. `strokeWeight(20)`).
- **`color(r, g, b, a);`:** Gibt ein Farbobjekt zurück: https://p5js.org/reference/p5/color/

### III. Formen zeichnen (Shapes)

Die folgenden Funktionen werden verwendet, um Formen auf das Canvas zu zeichnen:

- **`circle()`:** Zeichnet einen Kreis unter Verwendung der x-Koordinate, der y-Koordinate (Mittelpunkt) und der Größe (Breite und Höhe).
- **`rect()`:** Zeichnet ein Rechteck unter Verwendung der x-Koordinate, der y-Koordinate (obere linke Ecke), der Breite und der Höhe (z. B. `rect(0, 200, 600, 200)`).

**Optionale/Erwähnte Formen:**

`ellipse()`, `square()`, `quad()`, `triangle()`, `line()`, `point()`, `arc()`

### IV. Text und Schriftgröße

- **`text()`:** Zeichnet Text (oder Emojis als String) auf das Canvas. Die Argumente sind ein String, eine x-Koordinate und eine y-Koordinate (untere linke Ecke des Textfeldes).
- **`textSize()`:** Legt die Größe des Textes in Pixeln fest (z. B. `textSize(75)`). Muss vor der `text()`-Funktion aufgerufen werden.

### V. Interaktivität und Systemvariablen

Integrierte Variablen, die Werte speichern und zur Erzeugung von Interaktivität genutzt werden können:

- **`mouseX`:** Speichert die aktuelle x-Koordinate des Mauszeigers auf dem Canvas.
- **`mouseY`:** Speichert die aktuelle y-Koordinate des Mauszeigers auf dem Canvas.
- **`width`:** Speichert die Breite des Canvas.
- **`height`:** Speichert die Höhe des Canvas.
- **`pmouseX`:** Speichert die vorherige x-Koordinate der Maus.
- **`pmouseY`:** Speichert die vorherige y-Koordinate der Maus.
