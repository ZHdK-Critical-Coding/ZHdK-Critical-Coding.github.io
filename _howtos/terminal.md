---
title: Terminal
title_de: Terminal
order: 1
folder: Terminal
repo_url: https://github.com/ZHdK-Critical-Coding/Manuals/tree/main/Terminal
render_with_liquid: false
---

# Terminal Basics – Cheatsheet

Die wichtigsten Befehle für den Einstieg ins Terminal. Sie funktionieren unter macOS und Linux. Unter Windows stehen sie über WSL oder Git Bash zur Verfügung.

**Schreibweise:** `[Pfad]`, `[Datei]` usw. sind Platzhalter und werden ohne Klammern durch den eigenen Wert ersetzt. Optionen (z. B. `-r`) stehen immer **vor** den Datei- und Ordnernamen – unter macOS funktionieren sie sonst nicht.

---

## Terminal-Programme
Jedes Betriebssystem bringt ein Terminal mit (macOS: *Terminal.app* unter Programme → Dienstprogramme). Wer mehr Komfort möchte, kann ein anderes Terminal-Programm installieren. Die Befehle in diesem Cheatsheet funktionieren in allen gleich. Alle hier aufgeführten Programme sind kostenlos.

- **[iTerm2](https://iterm2.com/downloads.html)** (macOS)  
  → Der Klassiker unter den Mac-Terminals: geteilte Fenster, Suche, Profile.  
- **[cmux](https://www.cmux.dev/docs)** (macOS)  
  → Basiert auf Ghostty, mit vertikalen Tabs und Benachrichtigungen – gemacht für die Arbeit mit KI-Coding-Agenten.  
  Installation auch über Homebrew: `brew tap manaflow-ai/cmux` und danach `brew install --cask cmux`  
- **[Ghostty](https://ghostty.org/download)** (macOS, Linux)  
  → Schnell, schlicht und mit guten Voreinstellungen.  
- **[WezTerm](https://wezterm.org/installation.html)** (macOS, Linux, Windows)  
  → Läuft auf allen Systemen, mit Tabs und geteilten Fenstern.  
- **[kitty](https://sw.kovidgoyal.net/kitty/binary/)** (macOS, Linux)  
  → Schnelles Terminal mit vielen Erweiterungen.  
- **[Alacritty](https://alacritty.org/)** (macOS, Linux, Windows)  
  → Minimalistisch und sehr schnell, ohne Tabs.  
- **[Windows Terminal](https://aka.ms/terminal)** (Windows)  
  → Das moderne Terminal von Microsoft, für PowerShell, WSL und Git Bash.  
- **[Git for Windows](https://gitforwindows.org/)** (Windows)  
  → Enthält Git Bash, mit dem die Befehle aus diesem Cheatsheet auch unter Windows laufen.  

---

## Navigation
- **`pwd`**  
  → Zeigt den Pfad des aktuellen Ordners (**p**rint **w**orking **d**irectory).

- **`ls`**  
  → Listet Dateien und Ordner im aktuellen Ordner auf (**l**i**s**t).  
  Optionen:  
  - `ls -l` → Ausführliche Liste mit Details (Rechte, Grösse, Datum)  
  - `ls -a` → Zeigt auch versteckte Dateien (Namen beginnen mit `.`)  
  - `ls -lh` → Ausführliche Liste mit lesbaren Grössen (KB, MB)  
  - `ls -la` → Ausführliche Liste inklusive versteckter Dateien  

- **`cd [Pfad]`**  
  → Wechselt in einen anderen Ordner (**c**hange **d**irectory).  
  Beispiele:  
  - `cd /Users/deinname/Documents` → Wechselt in den angegebenen Ordner  
  - `cd ..` → Wechselt eine Ebene nach oben  
  - `cd ~` → Wechselt in den Home-Ordner  
  - `cd -` → Wechselt zurück in den vorherigen Ordner  

---

## Ordner
- **`mkdir [Ordner]`**  
  → Erstellt einen Ordner (**m**a**k**e **dir**ectory).  
  Beispiele:  
  - `mkdir projekt` → Erstellt den Ordner `projekt`  
  - `mkdir test/projekt` → Erstellt den Ordner `projekt` im bestehenden Ordner `test`  
  - `mkdir -p a/b/c` → Erstellt `c` und alle übergeordneten Ordner, falls sie noch nicht existieren  

- **`rmdir [Ordner]`**  
  → Löscht einen leeren Ordner (**r**e**m**ove **dir**ectory).  
  Beispiele:  
  - `rmdir projekt` → Löscht den Ordner `projekt`. Funktioniert nur, wenn er leer ist.  
  - `rmdir projekt/*` → Löscht alle leeren Unterordner von `projekt`, `projekt` selbst bleibt bestehen.  

---

## Dateien erstellen, kopieren, verschieben
- **`touch [Datei]`**  
  → Erstellt eine leere Datei. Existiert die Datei bereits, wird nur ihr Änderungsdatum aktualisiert.  
  Beispiel:  
  - `touch notizen.txt` → Erstellt die leere Datei `notizen.txt`  

- **`cp [Quelle] [Ziel]`**  
  → Kopiert (**c**o**p**y) eine Datei oder einen Ordner.  
  Beispiele:  
  - `cp datei1.txt datei2.txt` → Dupliziert `datei1.txt` als `datei2.txt`  
  - `cp datei1.txt ../anderer_ordner/` → Kopiert `datei1.txt` unter gleichem Namen in den Ordner `../anderer_ordner`  
  - `cp -r projekt projekt_backup` → Kopiert den ganzen Ordner `projekt` samt Inhalt (`-r`)  

- **`mv [Quelle] [Ziel]`**  
  → Verschiebt (**m**o**v**e) eine Datei oder einen Ordner.  
  Beispiele:  
  - `mv datei1.txt datei2.txt` → Benennt `datei1.txt` in `datei2.txt` um  
  - `mv datei1.txt ../anderer_ordner/` → Verschiebt `datei1.txt` unter gleichem Namen in den Ordner `../anderer_ordner`  

---

## Löschen
**Achtung:** Es gibt keinen Papierkorb. Was gelöscht ist, ist weg. Befehle vor dem Ausführen genau prüfen – besonders mit `-rf`.

- **`rm [Datei]`**  
  → Löscht (**r**e**m**ove) eine Datei.  
  Beispiele:  
  - `rm datei1.txt` → Löscht `datei1.txt`  
  - `rm *.txt` → Löscht **alle** Dateien im aktuellen Ordner, die auf `.txt` enden. _Gefährlich!_  
  - `rm -r projekt` → Löscht den Ordner `projekt` mit allen Dateien und Unterordnern (`-r`). _Sehr gefährlich!_  
  - `rm -rf projekt` → Wie `-r`, aber ohne Rückfrage, auch bei schreibgeschützten Dateien (`-f`). _Sehr, sehr gefährlich!_  

---

## Dateiinhalte anzeigen
- **`cat [Datei]`**  
  → Gibt den ganzen Inhalt einer Datei aus.  

- **`less [Datei]`**  
  → Zeigt lange Dateien seitenweise an. Scrollen mit den Pfeiltasten, beenden mit `q`.  

- **`head [Datei]`** und **`tail [Datei]`**  
  → Zeigen die ersten bzw. letzten 10 Zeilen einer Datei.  
  Beispiel:  
  - `tail -f log.txt` → Zeigt laufend neue Zeilen an, während die Datei wächst (praktisch für Logdateien). Beenden mit `Ctrl + C`.  

---

## Suchen
- **`grep "[Text]" [Datei]`**  
  → Zeigt alle Zeilen einer Datei, die den Text enthalten.  
  Beispiel:  
  - `grep -r "Text" .` → Durchsucht alle Dateien im aktuellen Ordner und in allen Unterordnern  

- **`find [Pfad] -name "[Muster]"`**  
  → Sucht Dateien nach Namen.  
  Beispiel:  
  - `find . -name "*.txt"` → Findet alle `.txt`-Dateien im aktuellen Ordner und darunter  

---

## Hilfe
- **`man [Befehl]`**  
  → Öffnet das Handbuch (**man**ual) zu einem Befehl, z. B. `man ls`. Beenden mit `q`.  

- **`[Befehl] --help`**  
  → Zeigt eine kurze Übersicht der Optionen, z. B. `grep --help`.  

---

## Rechte und Administration
- **`chmod +x [Datei]`**  
  → Macht eine Datei ausführbar (**ch**ange **mod**e), z. B. `chmod +x script.sh`.  

- **`sudo [Befehl]`**  
  → Führt einen Befehl mit Administratorrechten aus. Fragt nach dem Passwort. _Mit Vorsicht verwenden!_  

---

## Prozesse und System
- **`ps aux`**  
  → Listet alle laufenden Prozesse auf (**p**rocess **s**tatus).  

- **`top`**  
  → Zeigt laufende Prozesse live an. Beenden mit `q`. Komfortablere Alternative: `htop` (falls installiert).  

- **`kill [PID]`**  
  → Beendet einen Prozess anhand seiner Prozess-ID (PID, siehe `ps aux` oder `top`).  

- **`df -h`**  
  → Zeigt den freien Speicherplatz der Laufwerke (**d**isk **f**ree).  

- **`du -sh [Ordner]`**  
  → Zeigt, wie viel Speicherplatz ein Ordner belegt (**d**isk **u**sage).  

---

## Befehle kombinieren
- **`|`** (Pipe)  
  → Leitet die Ausgabe eines Befehls an den nächsten weiter.  
  Beispiel:  
  - `ls | grep ".py"` → Zeigt nur Einträge, die `.py` enthalten  

- **`>`** und **`>>`**  
  → Schreiben die Ausgabe in eine Datei. `>` überschreibt die Datei, `>>` hängt am Ende an.  
  Beispiele:  
  - `ls > liste.txt` → Speichert die Dateiliste in `liste.txt` (überschreibt den Inhalt)  
  - `echo "Neue Zeile" >> liste.txt` → Hängt eine Zeile an `liste.txt` an  

- **`&&`**  
  → Führt den zweiten Befehl nur aus, wenn der erste erfolgreich war.  
  Beispiel:  
  - `mkdir projekt && cd projekt` → Erstellt den Ordner `projekt` und wechselt hinein  

---

## Zeitsparer
- **`Tab`**  
  → Vervollständigt Datei-, Ordner- und Befehlsnamen automatisch.  

- **`↑`** / **`↓`**  
  → Blättert durch die zuletzt eingegebenen Befehle.  

- **`Ctrl + R`**  
  → Durchsucht die Befehlshistorie.  

- **`Ctrl + C`**  
  → Bricht einen laufenden Befehl ab.  

- **`history`**  
  → Listet die zuletzt eingegebenen Befehle auf.  

- Auf macOS lassen sich Ordner oder Dateien aus dem Finder ins Terminal ziehen. Nach dem Loslassen wird ihr Pfad eingefügt. Beispiel: `cd ` tippen (mit Leerzeichen), Ordner ins Terminal ziehen, `Enter` – schon ist man im Ordner.  

---

## Bildschirm und Sonstiges
- **`clear`** oder **`Ctrl + L`**  
  → Leert das Terminal-Fenster (der Verlauf bleibt durch Hochscrollen erreichbar).  
  Tipp: `Cmd + K` auf macOS leert den Bildschirm inklusive Verlauf.  

- **`echo "[Text]"`**  
  → Gibt Text im Terminal aus.  

- **`exit`**  
  → Beendet die Terminal-Session.  

---

## Wie weiter?
Wer Navigation, Dateioperationen, `grep`, Pipes und die Tab-Vervollständigung beherrscht, kann den Grossteil der alltäglichen Arbeit im Terminal erledigen. Sinnvolle nächste Schritte:

- **`ssh`** → Auf entfernten Rechnern arbeiten  
- **`curl`** oder **`wget`** → Dateien herunterladen  
- **`tar`** → Archive erstellen und entpacken  
- Paketmanager wie **`brew`** (macOS) oder **`apt`** (Linux) → Programme installieren  

---

# macOS-Spezialitäten

macOS bringt erstaunlich viele Spielereien und nützliche Werkzeuge mit – ganz ohne Installation.

---

## Der Mac spricht (und singt)
- **`say "[Text]"`**  
  → Liest einen Text laut vor.  
  Beispiele:  
  - `say "Hallo zusammen"` → Spricht den Text mit der Standardstimme  
  - `say -v '?'` → Listet alle verfügbaren Stimmen auf  
  - `say -v '?' | grep de_` → Zeigt nur die deutschen Stimmen  
  - `say -v Cellos "doo da doo da doo da doo"` → Singt den Text zu einer Melodie  
  - `say -v "Good News" "you won"` → Singt ebenfalls  
  - `say -v Whisper "I see you"` → Flüstert  
  - `say -v Zarvox "I am a robot"` → Spricht wie ein Roboter  
  - `say -o hallo.aiff "Hallo"` → Speichert die Sprachausgabe als Audiodatei  
  - `cal | say` → Liest den Kalender vor. So lässt sich die Ausgabe jedes Befehls an `say` weiterleiten.  

---

## Töne und Fenster
- **`afplay [Datei]`**  
  → Spielt eine Audiodatei ab.  
  Beispiele:  
  - `afplay /System/Library/Sounds/Glass.aiff` → Spielt einen Systemton  
  - `ls /System/Library/Sounds` → Listet alle Systemtöne auf (z. B. `Funk`, `Sosumi`, `Submarine`)  

- **`osascript -e '[AppleScript]'`**  
  → Führt einen AppleScript-Befehl aus.  
  Beispiele:  
  - `osascript -e 'display notification "Kaffeepause" with title "Hey"'` → Zeigt eine echte macOS-Mitteilung  
  - `osascript -e 'tell app "Finder" to display dialog "Bist du sicher?"'` → Öffnet ein Dialogfenster  
  - `osascript -e 'set volume output volume 30'` → Setzt die Lautstärke auf 30 %  

---

## Spielereien aus dem Internet
`curl` und `nc` sind auf macOS vorinstalliert.

- **`curl wttr.in`**  
  → Zeigt die Wettervorhersage als ASCII-Grafik. Mit Ort: `curl wttr.in/Zürich`  

- **`curl parrot.live`**  
  → Lässt den tanzenden Party-Papagei erscheinen. Beenden mit `Ctrl + C`.  

- **`nc towel.blinkenlights.nl 23`**  
  → Spielt Star Wars als ASCII-Animation (sofern der Server erreichbar ist). `telnet` gibt es auf macOS nicht mehr, `nc` funktioniert hier gleich. Beenden mit `Ctrl + C`.  

---

## Wirklich nützlich
- **`networkQuality`**  
  → Führt Apples eigenen Geschwindigkeitstest für die Internetverbindung durch.  

- **`caffeinate`**  
  → Verhindert, dass der Mac in den Ruhezustand wechselt, bis `Ctrl + C` gedrückt wird.  
  Beispiel:  
  - `caffeinate -t 3600` → Hält den Mac eine Stunde (3600 Sekunden) wach  

- **`pbcopy`** und **`pbpaste`**  
  → Verbinden das Terminal mit der Zwischenablage.  
  Beispiele:  
  - `ls | pbcopy` → Kopiert die Dateiliste in die Zwischenablage  
  - `pbpaste > text.txt` → Speichert den Inhalt der Zwischenablage in `text.txt`  

- **`open [Pfad]`**  
  → Öffnet eine Datei oder einen Ordner wie per Doppelklick.  
  Beispiele:  
  - `open .` → Öffnet den aktuellen Ordner im Finder  
  - `open -a Safari` → Startet das Programm Safari  

- **`qlmanage -p [Datei]`**  
  → Öffnet eine Quick-Look-Vorschau, z. B. `qlmanage -p foto.jpg`.  

- **`mdfind "[Text]"`**  
  → Führt eine Spotlight-Suche durch, z. B. `mdfind "Steuererklärung"`.  

- **`pmset -g batt`**  
  → Zeigt den Ladezustand der Batterie.  

---

## Retro-Kuriositäten
- **`banner -w 40 HI`**  
  → Druckt riesige, senkrecht verlaufende Buchstaben – gemacht für alte Zeilendrucker.  

- **`leave +0010`**  
  → Erinnert in 10 Minuten daran, zu gehen. Ein altes Unix-Werkzeug, das immer noch mit macOS ausgeliefert wird.  

- **`units`**  
  → Rechnet Einheiten um. Interaktiv: bei `You have:` z. B. `1 mile` eingeben, bei `You want:` `km`. Direkt: `units "1 mile" km`. Beenden mit `Ctrl + C`.  

---

## Versteckte Einstellungen mit `defaults`
- **`defaults write com.apple.dock autohide-delay -float 0; killall Dock`**  
  → Lässt das automatisch ausgeblendete Dock ohne Verzögerung erscheinen.  
  Rückgängig: `defaults delete com.apple.dock autohide-delay; killall Dock`  

- **`defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'; killall Dock`**  
  → Fügt dem Dock einen leeren Abstandhalter hinzu, mit dem sich Programme gruppieren lassen.  
  Rückgängig: Den Abstandhalter einfach aus dem Dock ziehen. _Nicht_ `defaults delete … persistent-apps` verwenden – das setzt das ganze Dock auf die Standardprogramme zurück.  

- **`defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder`**  
  → Zeigt versteckte Dateien im Finder an. Alternativ im Finder mit `Cmd + Shift + .` ein- und ausschalten.  
  Rückgängig: `defaults delete com.apple.finder AppleShowAllFiles; killall Finder`  

`killall Dock` bzw. `killall Finder` startet das Programm neu, damit die Einstellung wirksam wird.
