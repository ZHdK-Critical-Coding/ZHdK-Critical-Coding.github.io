---
title: Printer Server
maincategory: utilities
category: servers
technology: Rust
author: Urs Hofer
date: 2026-10-20
repo: Servers_Printer
repo_url: https://github.com/ZHdK-Critical-Coding/Servers_Printer
screenshot: "/assets/examples/servers-printer/screenshot.png"
related:
- P5_Output_Printers_ThermalPrinter_Lines
- P5_Output_Printers_ThermalPrinter_Bitmap
- P5_Output_Printers_LinePrinter
- P5_Output_Printers_CUPS
render_with_liquid: false
languages:
- en
- de
---

<div class="lang" lang="en" markdown="1">

# Rust: Printer Server

A small macOS app that makes printers connected to a Mac available to p5
sketches over WebSocket. It speaks exactly the same protocols as the
Raspberry Pi servers `printer-websockets` (thermal printer) and
`lp-websockets` (line printer) from
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
so the sketches
[P5_Output_Printers_ThermalPrinter_Lines](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines),
[P5_Output_Printers_ThermalPrinter_Bitmap](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap) and
[P5_Output_Printers_LinePrinter](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter)
work without changes: only `printerConnection` has to point to the Mac.
A third, new protocol prints the sketch as an image on any CUPS printer
(office printers, inkjets, everything in *System Settings → Printers*), see
[P5_Output_Printers_CUPS](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_CUPS).

## Installation

Download `Printer-Server-<version>.dmg` from
[Releases](https://github.com/ZHdK-Critical-Coding/Servers_Printer/releases),
open it and drag **Printer Server** into *Applications*. The app is signed
and notarized and runs on Apple Silicon and Intel Macs with macOS 11 or
newer.

## How to Run

1. Start **Printer Server** from *Applications*. On first start, allow
   incoming connections when macOS asks.
2. The window lists all printers found: USB printers, printer device files
   and CUPS queues. Plugging a printer in or out updates the list.
3. Choose the **mode** of each printer in its drop-down and **check** the
   printer that should print. There is one checked printer per mode, so a
   thermal printer, a line printer and a CUPS printer can be used at the
   same time. The selection is remembered.
4. Put the address shown at the top into the sketch, e.g.
   `const printerConnection = 'ws://10.21.3.49:8080'`.

**Test** prints the server address on a printer, like the Pi servers do on
start.

| Mode | Port | Protocol | Sketch |
| --- | --- | --- | --- |
| Thermal (ESC/POS) | 8080 | `printer-websockets` | ThermalPrinter_Lines, ThermalPrinter_Bitmap |
| Line printer (ESC/P) | 8090 | `lp-websockets` | LinePrinter |
| CUPS image | 8070 | new, see below | CUPS |

### Without a Printer: Simulation

```sh
"/Applications/Printer Server.app/Contents/MacOS/printer-server" --simulate
```

adds three simulated printers that save every job to
`~/Documents/printer-simulation/`: the raw printer bytes (`.bin`) and a
`.png` of the dots the printer would print, or the `.pdf` for CUPS.

### Port Already in Use

If another program uses a port, the server takes the next free one
(8080 → 8081 → 8082 …, up to 20 tries). The address is then shown in
orange and noted in the log: put that address into the sketch. To choose
other start ports:

```sh
"/Applications/Printer Server.app/Contents/MacOS/printer-server" --thermal-port 9080 --line-port 9090 --cups-port 9070
```

On some Macs, Safari's WebDriver (`safaridriver`) occupies 8080 while it
runs.

## Coding Help

### Connections

| Connection | Found by | Used for |
| --- | --- | --- |
| USB | every USB device with the printer interface class | Thermal or Line mode, data goes directly to the printer (libusb) |
| Device file | `/dev/lp0`, `/dev/usb/lp0` … (Linux) | Thermal or Line mode, direct line printing |
| CUPS queue | `lpstat -e` | CUPS image mode, or Thermal / Line mode sent raw (`lp -o raw`) |

Epson TM printers (USB ids `04b8:0e..` or "TM-" in the name) start in
Thermal mode, other USB printers in Line mode, CUPS queues in CUPS image
mode.

On macOS the app talks to USB printers directly. This fails while a system
print job is running on the same printer: use its CUPS queue with Thermal
or Line mode instead.

### Protocol: Thermal Printer (port 8080)

Same as `printer-websockets`. Every request gets exactly one answer; the
server never sends anything else.

| Request | Answer |
| --- | --- |
| Text `{"text": "...", "w": 0, "h": 0, "style": "bu", "cut": false}` | `ok` |
| Text `cut` | `ok` |
| Binary PNG/JPEG: scaled to 256 dots, squeezed 1.6× vertically, threshold 128, centered | `ok` |
| Anything while the printer prints | `busy` |
| Broken JSON, no printer checked, printer error | `error: …` |

`w`, `h`: 0 = normal, 1 = double … 7 = eight times. `style`: `b` bold,
`u` underline.

### Protocol: Line Printer (port 8090)

Same as `lp-websockets`.

| Request | Answer |
| --- | --- |
| Text `{"text": "...", "w": 0, "h": 0, "style": "bu"}` | `ok` |
| Text `{"direction": "up" \| "down", "steps": 36}`, one step = 1/216 inch | `ok` |
| Binary PNG/JPEG: Floyd-Steinberg, 60 dpi, at most 480 dots (8 inches) | `printed_image` |
| Image could not be read or printed | `conversion_error` |
| Anything while the printer prints | `busy` |

### Protocol: CUPS Image (port 8070, new)

The sketch sends its canvas as PNG; the server places it on a PDF page and
sends it to the checked CUPS printer.

| Request | Answer |
| --- | --- |
| Binary PNG/JPEG | `ok` when the job is handed to CUPS |
| Text JSON with page options, valid for the following images of this connection | `ok` |
| Anything while the last job is handed over | `busy` |
| Errors | `error: …` |

Page options (all optional, missing ones keep their value):

```js
{
  media: 'A4',          // 'A3', 'A4', 'A5', 'A6', 'Letter', 'Legal'
  orientation: 'auto',  // 'auto' (follows the image), 'portrait', 'landscape'
  fit: true,            // true: fill the page inside the margin. false: size from dpi
  dpi: 96,              // only with fit: false. 96 = size on screen
  margin: 10,           // white border in mm
  copies: 1,
  dither: false,        // true: black and white dots, like the line printer
}
```

Use `pixelDensity(2)` or `3` in the sketch for a sharper print: the PNG
from `canvas.toBlob()` has the pixel density's resolution.

### Differences to the Raspberry Pi Servers

- Text is encoded as code page 437 (Umlauts work), like Electron_P5_Printers.
- Line printer images are scaled to at most 8 inches and corrected for the
  60 × 72 dpi dot shape, so retina canvases (pixelDensity 2) print at the
  right size. No ImageMagick / netpbm needed.
- Broken requests are answered with `error: …` instead of printing a help
  text on the paper.

### Project Structure

```
Servers_Printer/
├── src/
│   ├── main.rs       # Window (printer list, addresses, log), device scan
│   ├── server.rs     # WebSocket servers and the three protocols
│   ├── devices.rs    # Finding printers, USB / device file / CUPS / simulation
│   ├── state.rs      # Shared state, saved selection
│   ├── thermal.rs    # ESC/POS commands
│   ├── line.rs       # ESC/P commands
│   ├── bitmap.rs     # Image → black and white dots (threshold, dithering)
│   ├── pdf.rs        # Image → PDF page for CUPS
│   └── cp437.rs      # Text encoding
└── scripts/
    ├── bundle-macos.sh            # Builds the .app
    └── notarize-macos.sh          # Signs and notarizes app, zip and dmg
```

Image settings (thermal density and width, line printer resolution,
thresholds) are constants at the top of `thermal.rs` and `line.rs`.

The selection and modes are saved in
`~/Library/Application Support/printer-server/settings.json`. USB printers
are remembered by their USB ids (`usb:04b8:0e02`), so they stay selected in
any USB port; identical printers are numbered (`usb:04b8:0e02#2`). A
damaged settings file is kept as `settings.json.damaged`.

### Building the App

Requirements: [Rust](https://rustup.rs/), macOS 11 or newer. libusb is
built into the app, nothing else has to be installed. `cargo run` starts it
while developing (`cargo run -- --simulate` without printers).

```sh
./scripts/bundle-macos.sh              # dist/Printer Server.app for this Mac
./scripts/bundle-macos.sh --universal  # Apple Silicon and Intel
```

For `--universal`, add the targets once:
`rustup target add aarch64-apple-darwin x86_64-apple-darwin`.

Dependencies (`Cargo.toml`): `eframe` (GUI), `tokio` +
`tokio-tungstenite` (WebSocket), `rusb` (USB, with libusb built in),
`image` (PNG/JPEG), `flate2` (PDF compression).

#### Signed and Notarized

To pass the app on to other Macs without security warnings, sign and
notarize it with a Developer ID:

```sh
./scripts/notarize-macos.sh               # Apple Silicon and Intel
./scripts/notarize-macos.sh --native      # only this Mac's architecture
./scripts/notarize-macos.sh --sign-only   # sign and check, send nothing to Apple
```

Results in `dist/`: the stapled app, a `.zip` and a `.dmg`. Needed once:
a *Developer ID Application* certificate in the keychain and notary
credentials stored with an
[app-specific password](https://appleid.apple.com):

```sh
xcrun notarytool store-credentials printer-server \
  --apple-id you@example.com --team-id ABCDE12345 --password xxxx-xxxx-xxxx-xxxx
```

Other names: `NOTARY_PROFILE=<name>`, other certificate:
`IDENTITY="Developer ID Application: ..."`.

</div>

<div class="lang" lang="de" markdown="1">

# Rust: Printer Server

Eine kleine macOS-App, die Drucker an einem Mac per WebSocket für
p5-Sketches erreichbar macht. Sie spricht genau dieselben Protokolle wie die
Raspberry-Pi-Server `printer-websockets` (Thermodrucker) und
`lp-websockets` (Zeilendrucker) aus
[Servers_RaspberriPi](https://github.com/ZHdK-Critical-Coding/Servers_RaspberriPi),
darum funktionieren die Sketches
[P5_Output_Printers_ThermalPrinter_Lines](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Lines),
[P5_Output_Printers_ThermalPrinter_Bitmap](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_ThermalPrinter_Bitmap) und
[P5_Output_Printers_LinePrinter](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_LinePrinter)
ohne Änderungen: Nur `printerConnection` muss auf den Mac zeigen. Ein
drittes, neues Protokoll druckt den Sketch als Bild auf jedem
CUPS-Drucker (Bürodrucker, Tintenstrahler, alles in *Systemeinstellungen →
Drucker*), siehe
[P5_Output_Printers_CUPS](https://github.com/ZHdK-Critical-Coding/P5_Output_Printers_CUPS).

## Installation

`Printer-Server-<Version>.dmg` unter
[Releases](https://github.com/ZHdK-Critical-Coding/Servers_Printer/releases)
herunterladen, öffnen und **Printer Server** in *Programme* ziehen. Die App
ist signiert und notarisiert und läuft auf Macs mit Apple Silicon und Intel
ab macOS 11.

## Ausführen

1. **Printer Server** aus *Programme* starten. Beim ersten Start eingehende
   Verbindungen erlauben, wenn macOS fragt.
2. Das Fenster listet alle gefundenen Drucker: USB-Drucker,
   Drucker-Gerätedateien und CUPS-Warteschlangen. Ein- und Ausstecken
   aktualisiert die Liste.
3. Für jeden Drucker im Ausklappmenü den **Modus** wählen und den Drucker,
   der drucken soll, **anhaken**. Pro Modus ist ein Drucker angehakt, so
   lassen sich ein Thermodrucker, ein Zeilendrucker und ein CUPS-Drucker
   gleichzeitig verwenden. Die Auswahl bleibt gespeichert.
4. Die oben angezeigte Adresse in den Sketch eintragen, z.B.
   `const printerConnection = 'ws://10.21.3.49:8080'`.

**Test** druckt die Server-Adresse auf einem Drucker, wie die Pi-Server
beim Start.

| Modus | Port | Protokoll | Sketch |
| --- | --- | --- | --- |
| Thermal (ESC/POS) | 8080 | `printer-websockets` | ThermalPrinter_Lines, ThermalPrinter_Bitmap |
| Line printer (ESC/P) | 8090 | `lp-websockets` | LinePrinter |
| CUPS image | 8070 | neu, siehe unten | CUPS |

### Ohne Drucker: Simulation

```sh
"/Applications/Printer Server.app/Contents/MacOS/printer-server" --simulate
```

fügt drei simulierte Drucker hinzu, die jeden Auftrag in
`~/Documents/printer-simulation/` speichern: die rohen Drucker-Bytes
(`.bin`) und ein `.png` der Punkte, die der Drucker drucken würde, oder das
`.pdf` für CUPS.

### Port belegt

Benutzt ein anderes Programm einen Port, nimmt der Server den nächsten
freien (8080 → 8081 → 8082 …, bis zu 20 Versuche). Die Adresse erscheint
dann orange und steht im Log: diese Adresse in den Sketch eintragen.
Andere Start-Ports:

```sh
"/Applications/Printer Server.app/Contents/MacOS/printer-server" --thermal-port 9080 --line-port 9090 --cups-port 9070
```

Auf manchen Macs belegt Safaris WebDriver (`safaridriver`) Port 8080,
solange er läuft.

## Coding-Hilfe

### Verbindungen

| Verbindung | Gefunden über | Verwendet für |
| --- | --- | --- |
| USB | jedes USB-Gerät mit der Drucker-Schnittstellenklasse | Modus Thermal oder Line, Daten gehen direkt an den Drucker (libusb) |
| Gerätedatei | `/dev/lp0`, `/dev/usb/lp0` … (Linux) | Modus Thermal oder Line, direktes Zeilendrucken |
| CUPS-Warteschlange | `lpstat -e` | Modus CUPS image, oder Thermal / Line roh gesendet (`lp -o raw`) |

Epson-TM-Drucker (USB-IDs `04b8:0e..` oder "TM-" im Namen) starten im
Modus Thermal, andere USB-Drucker im Modus Line, CUPS-Warteschlangen im
Modus CUPS image.

Unter macOS spricht die App USB-Drucker direkt an. Das schlägt fehl,
solange ein Systemdruckauftrag auf demselben Drucker läuft: dann dessen
CUPS-Warteschlange im Modus Thermal oder Line verwenden.

### Protokoll: Thermodrucker (Port 8080)

Wie `printer-websockets`. Jede Anfrage bekommt genau eine Antwort; der
Server sendet nie etwas anderes.

| Anfrage | Antwort |
| --- | --- |
| Text `{"text": "...", "w": 0, "h": 0, "style": "bu", "cut": false}` | `ok` |
| Text `cut` | `ok` |
| Binär PNG/JPEG: auf 256 Punkte skaliert, vertikal 1,6× gestaucht, Schwelle 128, zentriert | `ok` |
| Alles, während der Drucker druckt | `busy` |
| Fehlerhaftes JSON, kein Drucker angehakt, Druckerfehler | `error: …` |

`w`, `h`: 0 = normal, 1 = doppelt … 7 = achtfach. `style`: `b` fett,
`u` unterstrichen.

### Protokoll: Zeilendrucker (Port 8090)

Wie `lp-websockets`.

| Anfrage | Antwort |
| --- | --- |
| Text `{"text": "...", "w": 0, "h": 0, "style": "bu"}` | `ok` |
| Text `{"direction": "up" \| "down", "steps": 36}`, ein Schritt = 1/216 Zoll | `ok` |
| Binär PNG/JPEG: Floyd-Steinberg, 60 dpi, höchstens 480 Punkte (8 Zoll) | `printed_image` |
| Bild nicht lesbar oder nicht druckbar | `conversion_error` |
| Alles, während der Drucker druckt | `busy` |

### Protokoll: CUPS image (Port 8070, neu)

Der Sketch sendet seine Zeichenfläche als PNG; der Server setzt sie auf
eine PDF-Seite und schickt sie an den angehakten CUPS-Drucker.

| Anfrage | Antwort |
| --- | --- |
| Binär PNG/JPEG | `ok`, sobald der Auftrag bei CUPS ist |
| Text-JSON mit Seitenoptionen, gültig für die folgenden Bilder dieser Verbindung | `ok` |
| Alles, während der letzte Auftrag übergeben wird | `busy` |
| Fehler | `error: …` |

Seitenoptionen (alle optional, fehlende behalten ihren Wert):

```js
{
  media: 'A4',          // 'A3', 'A4', 'A5', 'A6', 'Letter', 'Legal'
  orientation: 'auto',  // 'auto' (wie das Bild), 'portrait', 'landscape'
  fit: true,            // true: Seite innerhalb des Rands füllen. false: Grösse aus dpi
  dpi: 96,              // nur mit fit: false. 96 = Grösse auf dem Bildschirm
  margin: 10,           // weisser Rand in mm
  copies: 1,
  dither: false,        // true: schwarz-weisse Punkte wie beim Zeilendrucker
}
```

Für einen schärferen Druck im Sketch `pixelDensity(2)` oder `3` verwenden:
Das PNG aus `canvas.toBlob()` hat die Auflösung der Pixeldichte.

### Unterschiede zu den Raspberry-Pi-Servern

- Text wird als Codepage 437 kodiert (Umlaute funktionieren), wie bei
  Electron_P5_Printers.
- Bilder für den Zeilendrucker werden auf höchstens 8 Zoll skaliert und auf
  die 60 × 72 dpi der Punkte korrigiert, so drucken auch Retina-Zeichenflächen
  (pixelDensity 2) in der richtigen Grösse. Kein ImageMagick / netpbm nötig.
- Fehlerhafte Anfragen werden mit `error: …` beantwortet, statt einen
  Hilfetext aufs Papier zu drucken.

### Projektstruktur

```
Servers_Printer/
├── src/
│   ├── main.rs       # Fenster (Druckerliste, Adressen, Log), Druckersuche
│   ├── server.rs     # WebSocket-Server und die drei Protokolle
│   ├── devices.rs    # Drucker finden, USB / Gerätedatei / CUPS / Simulation
│   ├── state.rs      # Gemeinsamer Zustand, gespeicherte Auswahl
│   ├── thermal.rs    # ESC/POS-Befehle
│   ├── line.rs       # ESC/P-Befehle
│   ├── bitmap.rs     # Bild → schwarz-weisse Punkte (Schwelle, Dithering)
│   ├── pdf.rs        # Bild → PDF-Seite für CUPS
│   └── cp437.rs      # Text-Kodierung
└── scripts/
    ├── bundle-macos.sh            # Baut die .app
    └── notarize-macos.sh          # Signiert und notarisiert App, Zip und DMG
```

Bildeinstellungen (Dichte und Breite des Thermodruckers, Auflösung des
Zeilendruckers, Schwellen) sind Konstanten oben in `thermal.rs` und
`line.rs`.

Auswahl und Modi werden in
`~/Library/Application Support/printer-server/settings.json` gespeichert.
USB-Drucker werden an ihren USB-IDs erkannt (`usb:04b8:0e02`), so bleiben
sie an jedem USB-Anschluss ausgewählt; gleiche Drucker werden nummeriert
(`usb:04b8:0e02#2`). Eine beschädigte Einstellungsdatei wird als
`settings.json.damaged` aufbewahrt.

### App bauen

Voraussetzungen: [Rust](https://rustup.rs/), macOS 11 oder neuer. libusb
ist in die App eingebaut, sonst muss nichts installiert werden. `cargo run`
startet sie beim Entwickeln (`cargo run -- --simulate` ohne Drucker).

```sh
./scripts/bundle-macos.sh              # dist/Printer Server.app für diesen Mac
./scripts/bundle-macos.sh --universal  # Apple Silicon und Intel
```

Für `--universal` einmal die Targets hinzufügen:
`rustup target add aarch64-apple-darwin x86_64-apple-darwin`.

Abhängigkeiten (`Cargo.toml`): `eframe` (Oberfläche), `tokio` +
`tokio-tungstenite` (WebSocket), `rusb` (USB, mit eingebautem libusb),
`image` (PNG/JPEG), `flate2` (PDF-Kompression).

#### Signiert und notarisiert

Damit die App auf anderen Macs ohne Sicherheitswarnung startet, mit einer
Developer ID signieren und notarisieren:

```sh
./scripts/notarize-macos.sh               # Apple Silicon und Intel
./scripts/notarize-macos.sh --native      # nur die Architektur dieses Macs
./scripts/notarize-macos.sh --sign-only   # signieren und prüfen, nichts an Apple senden
```

Ergebnis in `dist/`: die App mit angeheftetem Ticket, ein `.zip` und ein `.dmg`. Einmal
nötig: ein *Developer ID Application*-Zertifikat im Schlüsselbund und
Notarisierungs-Zugangsdaten mit einem
[app-spezifischen Passwort](https://appleid.apple.com):

```sh
xcrun notarytool store-credentials printer-server \
  --apple-id you@example.com --team-id ABCDE12345 --password xxxx-xxxx-xxxx-xxxx
```

Anderer Name: `NOTARY_PROFILE=<Name>`, anderes Zertifikat:
`IDENTITY="Developer ID Application: ..."`.

</div>
