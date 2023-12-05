# Pomodoro work session timer

function pomodoro_work --description 'Pomodoro 25 minutes work session.'
    timer -T 25mins "Focus on working." && hs -c "NotifyWithSound('Pomodoro', 'Work Done! have a rest.')"
end
