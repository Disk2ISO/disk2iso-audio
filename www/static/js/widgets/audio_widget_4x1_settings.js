/**
 * disk2iso - Audio Widget Settings
 * Dynamisches Laden und Verwalten der Audio-CD-Einstellungen
 * Auto-Save bei Fokus-Verlust (moderne UX)
 */

(function() {
    'use strict';

    /**
     * Lädt das Audio Settings Widget vom Backend
     */
    async function loadAudioSettingsWidget() {
        try {
            const response = await fetch('/api/widgets/audio/settings');
            if (!response.ok) throw new Error('Failed to load audio settings widget');
            return await response.text();
        } catch (error) {
            console.error('Error loading audio settings widget:', error);
            return `<div class="error">Fehler beim Laden der Audio-Einstellungen: ${error.message}</div>`;
        }
    }

    /**
     * Injiziert das Audio Settings Widget in die Settings-Seite
     */
    async function injectAudioSettingsWidget() {
        const targetContainer = document.querySelector('#audio-settings-container');
        if (!targetContainer) {
            console.warn('Audio settings container not found');
            return;
        }

        const widgetHtml = await loadAudioSettingsWidget();
        targetContainer.innerHTML = widgetHtml;
        
        // Event Listener registrieren
        setupEventListeners();
    }

    /**
     * Registriert alle Event Listener für das Audio Settings Widget
     */
    function setupEventListeners() {
        // Audio Enable/Disable Toggle
        const audioEnabledCheckbox = document.getElementById('audio_enabled');
        if (audioEnabledCheckbox) {
            audioEnabledCheckbox.addEventListener('change', function() {
                const audioSettings = document.getElementById('audio-settings');
                if (audioSettings) {
                    audioSettings.style.display = this.checked ? 'block' : 'none';
                }
                
                // Nutzt die zentrale handleFieldChange Funktion aus settings.js
                if (window.handleFieldChange) {
                    window.handleFieldChange({ target: audioEnabledCheckbox });
                }
            });
        }
        
        // MP3 Quality - Auto-Save bei Change
        const mp3QualityField = document.getElementById('mp3_quality');
        if (mp3QualityField) {
            mp3QualityField.addEventListener('change', function() {
                // Nutzt die zentrale handleFieldChange Funktion aus settings.js
                if (window.handleFieldChange) {
                    window.handleFieldChange({ target: mp3QualityField });
                }
            });
        }
    }

    // Auto-Injection beim Laden der Settings-Seite
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', injectAudioSettingsWidget);
    } else {
        injectAudioSettingsWidget();
    }

})();
