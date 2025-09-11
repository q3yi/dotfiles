# Adjust volume with wpctl and notify through libnotify and mako

function volumectl --description "Adjust volume with wpctl and send notification."

    switch $argv[1]
        case up
            wpctl set-volume @DEFAULT_AUDIO_SINK@ "$argv[2]+"
        case down
            wpctl set-volume @DEFAULT_AUDIO_SINK@ "$argv[2]-"
        case '*'
            echo "Example: volumectl up/down 5%"
            return
    end

    set volume $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | string replace -ra '[^\d.]' '')
    set volume $(math "( $volume * 100 ) / 1")

    if test $volume -eq 0
        notify-send -t 1000 -a volumectl -h int:value:$volume "🔇"
    else if test $volume -le 33
        notify-send -t 1000 -a volumectl -h int:value:$volume "🔈 $volume%"
    else if test $volume -le 66
        notify-send -t 1000 -a volumectl -h int:value:$volume "🔉 $volume%"
    else
        notify-send -t 1000 -a volumectl -h int:value:$volume "🔊 $volume%"
    end
end
