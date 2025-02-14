# change to KDE plasma dark theme

function nightplasma --description 'Change to breeze dark theme in KDE Plasma'
    if command -v lookandfeeltool >/dev/null
        lookandfeeltool --a org.kde.breezedark.desktop
        set -gx DARK_MODE true
    end
end
