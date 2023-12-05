# kill tmux session with fzf

function tk --description 'Kill tmux session with fzf.'
    tmux kill-session -t $(tmux list-sessions | fzf | awk -F ':' '{print $1}')
end
