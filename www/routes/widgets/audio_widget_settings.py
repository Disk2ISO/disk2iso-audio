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
    Liest Audio-Einstellungen via libsettings.sh (BASH)
    Python = Middleware ONLY - keine direkten File-Zugriffe!
    """
    try:
        import subprocess
        
        # Audio Enabled
        script_enabled = """
        source /opt/disk2iso/lib/libsettings.sh
        settings_get_value_conf "disk2iso" "AUDIO_ENABLED" "true"
        """
        
        result_enabled = subprocess.run(
            ['/bin/bash', '-c', script_enabled],
            capture_output=True,
            text=True,
            timeout=2
        )
        
        audio_enabled = True
        if result_enabled.returncode == 0 and result_enabled.stdout.strip():
            audio_enabled = result_enabled.stdout.strip().lower() == 'true'
        
        # MP3 Quality
        script_quality = """
        source /opt/disk2iso/lib/libsettings.sh
        settings_get_value_conf "disk2iso" "MP3_QUALITY" "2"
        """
        
        result_quality = subprocess.run(
            ['/bin/bash', '-c', script_quality],
            capture_output=True,
            text=True,
            timeout=2
        )
        
        mp3_quality = 2
        if result_quality.returncode == 0 and result_quality.stdout.strip():
            try:
                mp3_quality = int(result_quality.stdout.strip())
            except ValueError:
                pass
        
        return {
            "audio_enabled": audio_enabled,
            "mp3_quality": mp3_quality,
        }
        
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
                         settings=settings,
                         t=t)

