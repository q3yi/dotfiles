# Try to send notification on different system


function try_notify --description "Try to send notification base on system."

    set summary $argv[1]
    set content $argv[2]

    if command -v notify-send >/dev/null
        # use notify-send command in linux
        notify-send "$summary" "$content"
    else if command -v hs >/dev/null
        # use hammerspoon command in macOS
        hs -c "NotifyWithSound('$summary', '$content')"
    else
        # otherwise we fallback to echo
        echo $summary
        echo $content
    end
end
