# attach tmux session with fzf

function ta --description 'Attach tmux session with fzf.'
    tmux attach -t $(tmux list-sessions | fzf | awk -F ':' '{print $1}')
end
