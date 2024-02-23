# Pomodoro work session timer

function p-work --description 'Pomodoro 25 minutes work session.'
    timer -T 25mins "Focus on working." && try_notify Pomodoro "Work Done! have a rest."
end
