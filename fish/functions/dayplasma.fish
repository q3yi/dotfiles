# change to KDE plasma light theme

function dayplasma --description 'Change to breeze light theme in KDE Plasma'
    if command -v lookandfeeltool >/dev/null
        lookandfeeltool --a org.kde.breeze.desktop
    end
end
