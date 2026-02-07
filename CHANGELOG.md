# Changelog - disk2iso-audio

Alle wichtigen Änderungen am Audio-CD Ripping Modul werden in dieser Datei dokumentiert.

Das Format basiert auf [Keep a Changelog](https://keepachangelog.com/de/1.0.0/),
und dieses Projekt folgt [Semantic Versioning](https://semver.org/lang/de/).

## [1.3.0] - 2026-02-07

### Changed

- Kompatibilität mit disk2iso 1.3.0 Service-Struktur
- Installation nach `services/disk2iso-web/` statt `www/`
- Version auf 1.3.0 aktualisiert

## [1.2.1] - 2026-02-04

### Added in Version 1.2.1

- Auslagerung als eigenständiges Modul aus disk2iso Core
- Vollständige Dokumentation für Audio-CD Ripping
- MusicBrainz-Integration via disk2iso-metadata Framework
- CD-TEXT Fallback für Offline-Metadaten
- Cover-Art Download und Einbettung
- LAME VBR V2 als Standard-Encoding
- ISO-Erstellung mit MP3-Dateien

### Changed in Version 1.2.1

- Repository-Struktur für Standalone-Nutzung optimiert
- Mehrsprachige Unterstützung (de, en, es, fr)
- Konfigurationssystem verbessert
- Metadaten-Abfrage über Provider-System

### Documentation for Version 1.2.1

- README mit vollständiger API-Dokumentation
- Workflow-Beschreibung und Beispiele
- Audio-Qualitäts-Tabelle (LAME VBR Presets)
- Integration-Anleitung für disk2iso

## [1.2.0] - 2026-01-26

### Added in Version 1.2.0

- Initiale Version als Teil von disk2iso Core
- cdparanoia Ripping mit Fehlerkorrektur
- LAME MP3-Encoding
- MusicBrainz Disc-ID Lookup
- CD-TEXT Support

### Changed in Version 1.2.0

- Verbesserte Fehlerbehandlung
- Optimierte Metadaten-Verarbeitung

## [1.1.0] - 2025-12-15

### Added in Version 1.1.0

- ID3v2-Tag Support mit eyed3
- Album-Cover Einbettung
- Multi-Track parallel Encoding

### Fixed in Version 1.1.0

- CD-ROM Locking Issues
- Encoding-Fehler bei Sonderzeichen

---

**Legende:**

- `Added` - Neue Features
- `Changed` - Änderungen an bestehenden Features
- `Deprecated` - Features die bald entfernt werden
- `Removed` - Entfernte Features
- `Fixed` - Bugfixes
- `Security` - Sicherheits-Updates
