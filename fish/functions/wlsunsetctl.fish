# Toggle wlsunset

function __start_wlsunset
    systemctl --user start wlsunset.service
    notify-send -t 3000 -a wlsunset 'Gamma adjustments' "🌛 wlsunset enabled."
end

function __stop_wlsunset
    systemctl --user stop wlsunset.service
    notify-send -t 3000 -a wlsunset 'Gamma adjustments' "🌞 wlsunset disabled."
end

function wlsunsetctl --description "Toggle wlsunset."

    set flag $(systemctl --user is-active wlsunset.service)

    switch $argv[1]
        case toggle
            if test $flag = active
                __stop_wlsunset
            else
                __start_wlsunset
            end
            # notify waybar
            pkill -35 waybar
        case '*'
            if test $flag = active
                echo '{"alt": "on"}'
            else
                echo '{"alt": "off"}'
            end
    end
end
