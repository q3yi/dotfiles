# pomodoro break timer

function p-break --description 'Pomodoro 5 minutes break.'
    timer -T 5min "Let's have a rest." && try_notify Pomodoro "Let's go to work."
end
