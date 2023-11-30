# select and attach to zellij session with fzf

function z_attach --description "Attach to zellij session.":
    zellij attach $(zellij list-sessions |fzf --ansi | awk '{print $1}')
end
