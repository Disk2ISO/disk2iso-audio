/**
 * Audio Module - Dependencies Widget (4x1)
 * Zeigt Audio-CD spezifische Tools (cdparanoia, lame, etc.)
 * Version: 1.0.0
 */

function loadAudioDependencies() {
    fetch('/api/system')
        .then(response => response.json())
        .then(data => {
            if (data.success && data.software) {
                updateAudioDependencies(data.software);
            }
        })
        .catch(error => {
            console.error('Fehler beim Laden der Audio-Dependencies:', error);
            showAudioDependenciesError();
        });
}

function updateAudioDependencies(softwareList) {
    const tbody = document.getElementById('audio-dependencies-tbody');
    if (!tbody) return;
    
    // Audio-spezifische Tools (aus libaudio.ini [dependencies])
    const audioTools = [
        { name: 'cdparanoia', display_name: 'cdparanoia' },
        { name: 'lame', display_name: 'LAME MP3 Encoder' }
    ];
    
    let html = '';
    
    audioTools.forEach(tool => {
        const software = softwareList.find(s => s.name === tool.name);
        if (software) {
            const statusBadge = getStatusBadge(software);
            const rowClass = !software.installed_version ? 'row-inactive' : '';
            
            html += `
                <tr class="${rowClass}">
                    <td><strong>${tool.display_name}</strong></td>
                    <td>${software.installed_version || '<em>Nicht installiert</em>'}</td>
                    <td>${statusBadge}</td>
                </tr>
            `;
        }
    });
    
    if (html === '') {
        html = '<tr><td colspan="3" style="text-align: center; padding: 20px; color: #999;">Keine Informationen verfügbar</td></tr>';
    }
    
    tbody.innerHTML = html;
}

function showAudioDependenciesError() {
    const tbody = document.getElementById('audio-dependencies-tbody');
    if (!tbody) return;
    
    tbody.innerHTML = '<tr><td colspan="3" style="text-align: center; padding: 20px; color: #e53e3e;">Fehler beim Laden</td></tr>';
}

// Auto-Load
if (document.getElementById('audio-dependencies-widget')) {
    loadAudioDependencies();
}
