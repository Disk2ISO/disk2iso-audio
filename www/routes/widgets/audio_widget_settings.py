"""
disk2iso - Audio Widget Settings Routes
Stellt die Audio-CD-Einstellungen bereit (Settings Widget)
"""

import os
import sys
from flask import Blueprint, render_template, jsonify
from i18n import t

# Blueprint für Audio Settings Widget
audio_settings_bp = Blueprint('audio_settings', __name__)

def get_audio_settings():
    """
    Liest die Audio-Einstellungen aus der Konfigurationsdatei
    Analog zu get_mqtt_settings() in mqtt_widget_settings.py
    """
    try:
        # Lese Einstellungen aus config.sh
        config_sh = '/opt/disk2iso/conf/config.sh'
        
        config = {
            "audio_enabled": True,  # Default: aktiviert
            "mp3_quality": 2,  # Default: Hohe Qualität
        }
        
        if os.path.exists(config_sh):
            with open(config_sh, 'r') as f:
                for line in f:
                    line = line.strip()
                    
                    # AUDIO_ENABLED (optional, wenn nicht gesetzt = enabled)
                    if line.startswith('AUDIO_ENABLED='):
                        value = line.split('=', 1)[1].strip('"').strip("'").lower()
                        config['audio_enabled'] = value in ['true', '1', 'yes']
                    
                    # MP3_QUALITY
                    elif line.startswith('MP3_QUALITY='):
                        value = line.split('=', 1)[1].strip('"').strip("'")
                        try:
                            config['mp3_quality'] = int(value)
                        except ValueError:
                            pass
        
        return config
        
    except Exception as e:
        print(f"Fehler beim Lesen der Audio-Einstellungen: {e}", file=sys.stderr)
        return {
            "audio_enabled": True,
            "mp3_quality": 2,
        }


@audio_settings_bp.route('/api/widgets/audio/settings')
def api_audio_settings_widget():
    """
    Rendert das Audio Settings Widget
    Zeigt Audio-CD-Einstellungen
    """
    config = get_audio_settings()
    
    # Rendere Widget-Template
    return render_template('widgets/audio_widget_settings.html',
                         config=config,
                         t=t)
