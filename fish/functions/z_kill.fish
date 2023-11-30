# Kill selected zellij session

function z_kill --description "Kill zellij session":
    zellij kill-session $(zellij list-sessions |fzf --ansi | awk '{print $1}')
end
