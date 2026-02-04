# disk2iso-audio - Audio-CD Ripping für disk2iso

🎵 Professionelles Audio-CD Ripping mit MusicBrainz-Metadaten, MP3-Encoding und ISO-Erstellung.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.debian.org/)
[![Shell: Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/Version-1.2.1-blue.svg)](VERSION)

## ✨ Features

- 🎯 **MusicBrainz-Integration** - Automatische Metadaten-Abfrage via Disc-ID
- 📀 **CD-TEXT Fallback** - Metadaten von CD lesen wenn MusicBrainz keine Treffer hat
- 🎵 **High-Quality Ripping** - cdparanoia mit Fehlerkorrektur
- 🎧 **MP3-Encoding** - LAME VBR V2 (≈190 kbps) mit ID3v2-Tags
- 🖼️ **Cover-Art** - Album-Cover Download von MusicBrainz/CoverArt Archive
- 💿 **ISO-Erstellung** - MP3-Dateien als ISO-Image mit Metadaten
- 🔄 **State-Machine Integration** - Nahtlose Integration in disk2iso Workflow
- 🌍 **Mehrsprachig** - 4 Sprachen (de, en, es, fr)

## 📦 Installation

### Als disk2iso-Modul (empfohlen)

```bash
# Modul installieren
curl -L https://github.com/DirkGoetze/disk2iso-audio/releases/latest/download/audio-module.zip -o /tmp/audio.zip
cd /opt/disk2iso && sudo unzip /tmp/audio.zip && sudo systemctl restart disk2iso
```

### Standalone (für Entwicklung)

```bash
# Repository klonen
git clone https://github.com/DirkGoetze/disk2iso-audio.git
cd disk2iso-audio

# Abhängigkeiten installieren
sudo apt install -y cdparanoia lame eyed3 curl jq cd-discid wodim libcdio-utils

# Bibliothek einbinden
source lib/libaudio.sh

# Abhängigkeiten prüfen
audio_check_dependencies
```

## 🔧 Abhängigkeiten

**Erforderlich:**

- `cdparanoia` - CD-Ripping mit Fehlerkorrektur
- `lame` - MP3-Encoder
- `eyed3` - ID3-Tag Editor
- `cd-discid` - Disc-ID Berechnung für MusicBrainz
- `curl`, `jq` - API-Kommunikation

**Optional:**

- `wodim` - CD-Informationen auslesen
- `libcdio-utils` (cd-info) - CD-TEXT Support
- [disk2iso-musicbrainz](https://github.com/DirkGoetze/disk2iso-musicbrainz) - MusicBrainz Provider

```bash
# Alle Abhängigkeiten installieren
sudo apt install -y cdparanoia lame eyed3 curl jq cd-discid wodim libcdio-utils
```

## 🚀 Verwendung

### In disk2iso

Das Modul wird automatisch verwendet wenn eine Audio-CD erkannt wird:

```bash
# Audio-CD einlegen
# disk2iso erkennt automatisch den Typ und startet Audio-Workflow
```

### Standalone

```bash
# Audio-CD Ripping starten
source lib/libaudio.sh
audio_check_dependencies

# CD-Informationen auslesen
audio_get_cd_info /dev/cdrom

# Mit MusicBrainz-Metadaten rippen
audio_rip_with_metadata /dev/cdrom /output/path

# Oder manuell ohne Metadaten
audio_rip_simple /dev/cdrom /output/path
```

## ⚙️ Konfiguration

**Datei:** `conf/libaudio.ini`

```ini
# Audio-CD Ripping Konfiguration
AUDIO_ENCODER=lame
AUDIO_BITRATE=V2
AUDIO_FORMAT=mp3
AUDIO_PARANOIA_MODE=3
AUDIO_METADATA_PROVIDER=musicbrainz
AUDIO_COVER_SIZE=500
AUDIO_CREATE_ISO=true
```

**Parameter:**

| Parameter | Standard | Beschreibung |
| --------- | -------- | ------------ |
| `AUDIO_ENCODER` | `lame` | MP3-Encoder |
| `AUDIO_BITRATE` | `V2` | LAME VBR Qualität (V0-V9, V2≈190kbps) |
| `AUDIO_FORMAT` | `mp3` | Ausgabeformat |
| `AUDIO_PARANOIA_MODE` | `3` | cdparanoia Modus (0-3, 3=max) |
| `AUDIO_METADATA_PROVIDER` | `musicbrainz` | Metadaten-Provider |
| `AUDIO_COVER_SIZE` | `500` | Cover-Größe in Pixel |
| `AUDIO_CREATE_ISO` | `true` | ISO nach MP3-Ripping erstellen |

## 🎵 Workflow

### 1. Disc-ID Berechnung

```bash
# Disc-ID für MusicBrainz berechnen
audio_get_discid /dev/cdrom
# Ausgabe: ABcDEfGH123456789
```

### 2. Metadaten-Abfrage

```bash
# MusicBrainz abfragen (benötigt disk2iso-musicbrainz)
musicbrainz_query "audio" "ABcDEfGH123456789"

# Fallback: CD-TEXT von Disc lesen
audio_read_cdtext /dev/cdrom
```

### 3. CD-Ripping

```bash
# Track-by-Track mit cdparanoia
cdparanoia -d /dev/cdrom -B -w

# Ausgabe: track01.cdda.wav, track02.cdda.wav, ...
```

### 4. MP3-Encoding

```bash
# WAV → MP3 mit LAME VBR V2
lame -V 2 --vbr-new track01.cdda.wav track01.mp3

# ID3-Tags schreiben
eyed3 --artist "Artist" --album "Album" --title "Track 1" track01.mp3
```

### 5. Cover-Art

```bash
# Cover von MusicBrainz/CoverArt Archive
curl -o cover.jpg "https://coverartarchive.org/release/MBID/front-500"

# Cover in MP3 einbetten
eyed3 --add-image cover.jpg:FRONT_COVER track01.mp3
```

### 6. ISO-Erstellung

```bash
# MP3s + Cover als ISO
genisoimage -o album.iso -R -J -V "Album Title" /path/to/mp3s/
```

## 💻 API

### Hauptfunktionen

```bash
# Abhängigkeiten prüfen
audio_check_dependencies
# Return: 0=OK, 1=Fehler

# CD-Informationen auslesen
audio_get_cd_info <device>
# Setzt: AUDIO_TRACKS, AUDIO_DISCID, AUDIO_CDTEXT

# Audio-CD rippen (mit Metadaten)
audio_rip_with_metadata <device> <output_dir>
# Return: 0=Erfolg, 1=Fehler

# Audio-CD rippen (ohne Metadaten)
audio_rip_simple <device> <output_dir>
# Return: 0=Erfolg, 1=Fehler
```

### Helper-Funktionen

```bash
# Disc-ID berechnen
audio_get_discid <device>
# Ausgabe: MusicBrainz Disc-ID (String)

# CD-TEXT auslesen
audio_read_cdtext <device>
# Setzt: CDTEXT_ARTIST, CDTEXT_ALBUM, CDTEXT_TRACKS[]

# Track rippen
audio_rip_track <device> <track_nr> <output_file>
# Return: 0=OK, 1=Fehler

# MP3 encodieren
audio_encode_mp3 <wav_file> <mp3_file> [quality]
# quality: V0-V9 (default: V2)
# Return: 0=OK, 1=Fehler

# ID3-Tags schreiben
audio_write_tags <mp3_file> <artist> <album> <title> <track_nr> [year]
# Return: 0=OK, 1=Fehler

# Cover einbetten
audio_embed_cover <mp3_file> <cover_jpg>
# Return: 0=OK, 1=Fehler

# ISO erstellen
audio_create_iso <source_dir> <output_iso> <volume_label>
# Return: 0=OK, 1=Fehler
```

## 🔗 Integration mit disk2iso

### State-Machine

```bash
# In disk2iso State-Machine
state_rip_audio() {
    audio_rip_with_metadata "$DEVICE" "$OUTPUT_DIR" || return 1
    audio_create_iso "$OUTPUT_DIR" "$ISO_FILE" "$ALBUM_TITLE" || return 1
}
```

### Metadaten-Provider

Das Modul nutzt das [disk2iso-metadata](https://github.com/DirkGoetze/disk2iso-metadata) Framework:

```bash
# MusicBrainz Provider registrieren (in libmusicbrainz.sh)
metadata_register_provider "musicbrainz" \
    "musicbrainz_query" \
    "musicbrainz_wait_for_selection" \
    "musicbrainz_apply_metadata"

# Automatischer Aufruf durch libaudio
audio_rip_with_metadata() {
    # 1. Disc-ID berechnen
    local discid=$(audio_get_discid "$device")
    
    # 2. Metadaten abfragen
    metadata_query_all_providers "audio" "$discid"
    
    # 3. Auf Auswahl warten
    metadata_wait_for_selection
    
    # 4. Metadaten anwenden
    metadata_apply_selected
}
```

## 📊 Statistiken

- **Dateigröße:** ~58 KB (1.378 Zeilen)
- **Funktionen:** 30+ Audio-spezifische Funktionen
- **Encoding:** LAME VBR V2 ≈190 kbps (CD-Qualität)
- **Fehlerkorrektur:** cdparanoia Modus 3 (Maximum)
- **Metadaten:** MusicBrainz API + CD-TEXT Fallback

## 🎧 Audio-Qualität

**LAME VBR Einstellungen:**

| Preset | Bitrate | Qualität | Dateigröße (74min CD) |
| ------ | ------- | -------- | --------------------- |
| V0 | 220-260 kbps | Transparent | ~110 MB |
| V1 | 190-250 kbps | Sehr gut | ~95 MB |
| **V2** | **170-210 kbps** | **Exzellent** | **~85 MB** |
| V3 | 150-195 kbps | Gut | ~75 MB |
| V4 | 140-185 kbps | Akzeptabel | ~65 MB |

**Standard:** V2 (beste Balance aus Qualität und Dateigröße)

## 🐛 Debugging

```bash
# Debug-Modus aktivieren
export DEBUG_AUDIO=true

# cdparanoia Log
cdparanoia -d /dev/cdrom -vQ

# CD-Informationen
cd-discid /dev/cdrom
wodim -prcap dev=/dev/cdrom
cd-info -C /dev/cdrom

# LAME Test
lame --disptime 1 -V 2 test.wav test.mp3

# Log-Ausgabe
tail -f /var/log/disk2iso/disk2iso.log | grep AUDIO
```

## 📝 Changelog

Siehe [CHANGELOG.md](CHANGELOG.md) für Details zu allen Änderungen.

## 📄 Lizenz

MIT License - siehe [LICENSE](LICENSE) Datei.

## 🔗 Links

- **Hauptprojekt:** [disk2iso](https://github.com/DirkGoetze/disk2iso)
- **Metadata Framework:** [disk2iso-metadata](https://github.com/DirkGoetze/disk2iso-metadata)
- **MusicBrainz Provider:** [disk2iso-musicbrainz](https://github.com/DirkGoetze/disk2iso-musicbrainz)
- **MusicBrainz API:** [musicbrainz.org](https://musicbrainz.org/doc/Development)
- **CoverArt Archive:** [coverartarchive.org](https://coverartarchive.org/)
- **LAME MP3 Encoder:** [lame.sourceforge.io](https://lame.sourceforge.io/)

## 👤 Autor

D. Götze

## 🙏 Danksagungen

- MusicBrainz für die exzellente Musik-Datenbank
- LAME Team für den besten MP3-Encoder
- cdparanoia für zuverlässiges CD-Ripping
- disk2iso Community
