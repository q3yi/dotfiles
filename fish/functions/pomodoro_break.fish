# pomodoro break timer

function pomodoro_break --description 'Pomodoro 5 minutes break.'
    timer -T 5min "Let's have a rest." && hs -c "NotifyWithSound('Pomodoro', 'Let\'s go to work.')"
end
