
# AUDIO_DATA: Metadaten des KÜNSTLERISCHEN INHALTS
#   - Informationen über Album (nicht über die physische Disc)
#   - Typ-spezifisch: Unterschiedliche Felder für Audio
#   - Beispiel: Sampler → album_year=2021, aber track.1.year=1989 (Original-Song-Jahr)
declare -A AUDIO_DATA=(
    # ========== AUDIO-CD ==========
    ["artist"]=""              # Haupt-Künstler / Album-Artist
    ["album"]=""               # Album-Name (kann von DISC_INFO[title] abweichen bei Compilations)
    ["year"]=""                # Original-Erscheinungsjahr des Albums (nicht der Disc!)
    ["original_release_date"]="" # Original-Veröffentlichungsdatum (YYYY-MM-DD)
    ["original_country"]=""    # Original-Produktionsland (kann von DISC_INFO[country] abweichen)
    ["original_label"]=""      # Original-Plattenlabel (z.B. "Apple Records")
    ["genre"]=""               # Musik-Genre
    ["track_count"]=0          # Anzahl Tracks
    ["duration"]=0             # Gesamtlaufzeit (Millisekunden)
    ["toc"]=""                 # Table of Contents (MusicBrainz DiscID-Berechnung)
    # ["track.1.title"]="..."  # Dynamisch: Track-Titel
    # ["track.1.artist"]="..." # Dynamisch: Artist des Tracks (bei Compilations unterschiedlich)
    # ["track.1.duration"]="..." # Dynamisch: Track-Laufzeit (Millisekunden)
    # ["track.1.year"]="..."   # Dynamisch: Original-Jahr des Tracks (wichtig bei Compilations!)
)

# ===========================================================================
# DISC_DATA GETTER/SETTER - AUDIO-CD METADATA
# ===========================================================================

# Artist (Album-Artist / Haupt-Künstler)
discdata_get_artist() {
    echo "${DISC_DATA[artist]}"
}

discdata_set_artist() {
    DISC_DATA[artist]="$1"
    log_debug "$MSG_DEBUG_SET_ARTIST: '$1'"
}

# Album-Name
discdata_get_album() {
    echo "${DISC_DATA[album]}"
}

discdata_set_album() {
    DISC_DATA[album]="$1"
    log_debug "$MSG_DEBUG_SET_ALBUM: '$1'"
}

# Original-Erscheinungsjahr
discdata_get_year() {
    echo "${DISC_DATA[year]}"
}

discdata_set_year() {
    DISC_DATA[year]="$1"
    log_debug "$MSG_DEBUG_SET_YEAR: '$1'"
}

# Genre
discdata_get_genre() {
    echo "${DISC_DATA[genre]}"
}

discdata_set_genre() {
    DISC_DATA[genre]="$1"
    log_debug "$MSG_DEBUG_SET_GENRE: '$1'"
}

# Track-Anzahl
discdata_get_track_count() {
    echo "${DISC_DATA[track_count]}"
}

discdata_set_track_count() {
    DISC_DATA[track_count]="$1"
    log_debug "$MSG_DEBUG_SET_TRACK_COUNT: '$1'"
}

# Gesamtlaufzeit (Millisekunden)
discdata_get_duration() {
    echo "${DISC_DATA[duration]}"
}

discdata_set_duration() {
    DISC_DATA[duration]="$1"
    log_debug "$MSG_DEBUG_SET_DURATION: '$1'"
}

# Table of Contents (für MusicBrainz)
discdata_get_toc() {
    echo "${DISC_DATA[toc]}"
}

discdata_set_toc() {
    DISC_DATA[toc]="$1"
    log_debug "$MSG_DEBUG_SET_TOC: '$1'"
}

# Original-Veröffentlichungsdatum
discdata_get_original_release_date() {
    echo "${DISC_DATA[original_release_date]}"
}

discdata_set_original_release_date() {
    DISC_DATA[original_release_date]="$1"
    log_debug "$MSG_DEBUG_SET_ORIGINAL_RELEASE_DATE: '$1'"
}

# Original-Produktionsland
discdata_get_original_country() {
    echo "${DISC_DATA[original_country]}"
}

discdata_set_original_country() {
    DISC_DATA[original_country]="$1"
    log_debug "$MSG_DEBUG_SET_ORIGINAL_COUNTRY: '$1'"
}

# Original-Plattenlabel
discdata_get_original_label() {
    echo "${DISC_DATA[original_label]}"
}

discdata_set_original_label() {
    DISC_DATA[original_label]="$1"
    log_debug "$MSG_DEBUG_SET_ORIGINAL_LABEL: '$1'"
}

# Composer (Album-Komponist)
discdata_get_composer() {
    echo "${DISC_DATA[composer]}"
}

discdata_set_composer() {
    DISC_DATA[composer]="$1"
    log_debug "$MSG_DEBUG_SET_COMPOSER: '$1'"
}

# Songwriter (Album-Texter)
discdata_get_songwriter() {
    echo "${DISC_DATA[songwriter]}"
}

discdata_set_songwriter() {
    DISC_DATA[songwriter]="$1"
    log_debug "$MSG_DEBUG_SET_SONGWRITER: '$1'"
}

# Arranger (Album-Arrangeur)
discdata_get_arranger() {
    echo "${DISC_DATA[arranger]}"
}

discdata_set_arranger() {
    DISC_DATA[arranger]="$1"
    log_debug "$MSG_DEBUG_SET_ARRANGER: '$1'"
}
