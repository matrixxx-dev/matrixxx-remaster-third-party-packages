---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# HowTo: Remastering with container files generated from third-party packages

### File structure:
```
.
├── doc
│   ├── readme-HowTo.md                               - this file
│   └── readme-matrixxx.md                            - General description of the matrixxx Live System
├── LAYER
│   ├── squashfs_mount.sh                             - Enables mounting of the resulting SquashFS image file
│   │                                                   (the path to the resulting file is added to the
│   │                                                   IMAGE_ARRAY for this purpose)
│   └── squashfs_umount.sh                            - Enables unmounting of the resulting SquashFS image file
├── lib
│   ├── func_mk-squashfs-image-handling               - function for creating a squashFS image file
│   └── func_packages-handling                        - helper functions for third-party packages handling
├── scripts
│   ├── 01-process-part1.sh                           - process part1: determine and download packages
│   ├── 02-process-part2.sh                           - process part2: build layer files for amd64 and i386 OS
│   │                                                   - extract packages to working directory
│   │                                                   - build squashfs file
│   ├── 03-delete-working-directories.sh                - delete working data directories
│   ├── part1.ini                                     - Configuration file for the first part
│   ├── part1-generate-third-party-packages-list.sh   - get third party packages
|   |                                                   - try to get information for download from the respective homepage
|   |                                                   - generate a list of downloaded versions
|   |                                                   - generate a list for wget to download files [data*.list]
│   ├── part1-get-third-party-packages.sh               - download packages and generate the corresponding ./data directories
│   ├── part2.ini                                     - Configuration file for the second part
│   ├── part2-Xtract-packages.sh                      - extract packages in a corresponding data directory
│   └── part2-Xtract-generate-squashfs.sh             - generating a SquashFS image file from the downloaded packages
├── 00-generate_new_independent_packages.sh           - creating a squashFS image file from third-party packages (collection script)
├── func_packages                                     - functions for generating download lists for third-party packages
└── version.ini                                       - contains the version number to be used
```

### Brief description of the work steps
- **Manually:** Generate the file contents for `func_packages`
- The repository file contains (by way of example) the data and structure
  required to download packages for the `Tor Browser` and `VeraCrypt`
- **Manually:** Adjust the desired version number in the `version.ini` file.
- **Execute:** 00-generate_new_independent_packages.sh
- As a result, the SquashFS image file can be found within its corresponding subdirectory inside the `LAYER` directory.

> [!NOTE]
> The effort required to generate the `func_packages` file for a desired
> third-party package should not be underestimated.


********************************************************************************
> [!WARNING]
> **DISCLAIMER:** THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK. THE
> AUTHOR CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGE TO HARDWARE
> OR SOFTWARE, LOST DATA, OR OTHER DIRECT OR INDIRECT DAMAGE RESULTING FROM THE
> USE OF THIS SOFTWARE.
> YOU ARE RESPONSIBLE FOR YOUR OWN COMPLIANCE WITH ALL APPLICABLE LAWS.

Extrahieren Sie Pakete in ein entsprechendes Datenverzeichnis.
********************************************************************************
# Anleitung: Remastering mit Container-Dateien, die aus Drittanbieter-Paketen generiert werden

### Dateistruktur:
```
.
├── doc
│   ├── readme-HowTo.md                               - diese Datei
│   └── readme-matrixxx.md                            - allgemeine Beschreibung des matrixxx Live-System
├── LAYER
│   ├── squashfs_mount.sh                             - ermöglicht das Mounten der Ergebnis squashFS Imagedatei
│   │                                                   (der Pfad der Ergebnisdatei wird dazu in das IMAGE_ARRAY eingetragen)
│   └── squashfs_umount.sh                            - ermöglicht das Un-Mounten der Ergebnis squashFS Imagedatei
├── lib
│   ├── func_mk-squashfs-image-handling               - Funktion für die Erzeugung einer squashFS Imagedatei
│   └── func_packages-handling                        - Hilfsfunktionen für die Handhabung von Drittanbieterpaketen
├── scripts
│   ├── 01-process-part1.sh                           - Prozess Teil 1: Pakete bestimmen und herunterladen
│   ├── 02-process-part2.sh                           - Prozess Teil 2: Erstellung von Layer-Dateien für die Betriebssystem
│   │                                                                   Varianten für amd64 und i386
│   │                                                   - Extrahieren der Pakete in das Arbeitsverzeichnis
│   │                                                   - Erstellung der SquashFS-Datei
│   ├── 03-delete-working-directories.sh              - Arbeitsdatenverzeichnisse löschen
│   ├── part1.ini                                     - Konfigurationsdatei für den ersten Teil
│   ├── part1-generate-third-party-packages-list.sh   - Drittanbieter-Pakete beschaffen
|   |                                                   - Versuch Download-Informationen von der jeweiligen Homepage abzurufen
|   |                                                   - Liste der heruntergeladenen Versionen erstellen
|   |                                                   - Liste für wget zum Herunterladen der Dateien erstellen [data*.list]
│   ├── part1-get-third-party-packages.sh             - Herunterladen der Pakete und generieren der zugehörigen ./data Verzeichnisse
│   ├── part2.ini                                     - Konfigurationsdatei für den zweiten Teil
│   ├── part2-Xtract-packages.sh                      - Extrahieren der Pakete in ein entsprechendes Datenverzeichnis
│   └── part2-Xtract-generate-squashfs.sh             - Erzeugen einer squashf Imagedatei aus den heruntergeladenen Paketen
├── 00-generate_new_independent_packages.sh           - Erzeugen einer squashFS Imagedatei aus Fremdpaketen (Sammelskript)
├── func_packages                                     - Funktionen für das Erzeugen der Downloadlisten für Drittanbieter-Pakete
└── version.ini                                       - Enthält die zu verwendende Versionsnummer
```

### Kurzbeschreibung der Arbeitsschritte
- **manuell:** Erzeugen der Dateiinhalte von `func_packages`
  - die Repository Datei enthält beispielhaft die Daten und Struktur für den
    Download der Pakete für den `Tor Browser` und für `VeraCrypt`
- **manuell:** Anpassen der gewünschten Versionsnummer in der Datei `version.ini`
- **ausführen:** 00-generate_new_independent_packages.sh
  - Als Ergebnis ist im Verzeichnis `LAYER` die squashFS Imagedatei im
    zugehörigen Verzeichnis zu finden

> [!NOTE]
> Der Aufwand für das Erzeugen der Datei `func_packages` für ein gewünschtes
> Drittanbieterpaket ist nicht zu unterschätzen

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** DIES IST EXPERIMENTELLE SOFTWARE. DIE BENUTZUNG ERFOLGT AUF
> EIGENE GEFAHR. DER AUTOR KANN UNTER KEINEN UMSTÄNDEN HAFTBAR GEMACHT
> WERDEN FÜR SCHÄDEN AN HARD- UND SOFTWARE, VERLORENE DATEN UND ANDERE DIREKT
> ODER INDIREKT DURCH DIE BENUTZUNG DER SOFTWARE ENTSTEHENDE SCHÄDEN.
> FÜR DIE EINHALTUNG GESETZLICHER VORSCHRIFTEN SIND SIE SELBST VERANTWORTLICH.

********************************************************************************
















