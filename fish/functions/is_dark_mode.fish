# test if the OS is dark mode

function linux_gbus
    set scheme (gdbus call --session --timeout=1000 \
                           --dest=org.freedesktop.portal.Desktop \
                           --object-path /org/freedesktop/portal/desktop \
                           --method org.freedesktop.portal.Settings.Read org.freedesktop.appearance color-scheme)

    switch $scheme
        case '(<<uint32 1>>,)'
            # prefer dark theme
            return 0
        case '(<<uint32 2>>,)'
            # prefer light theme
            return 1
        case '*'
            return 1
    end
end

function is_dark_mode --description "Test if the OS is dark mode"
    switch (uname -s)
        case Darwin
            defaults read -g AppleInterfaceStyle &>/dev/null
            return $status
        case Linux
            linux_gbus
            return $status
        case '*'
            return 1
    end
end
