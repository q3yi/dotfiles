# Search and execute command

function hist --description "Search command history":
    eval "$(history | fzf)"
end
