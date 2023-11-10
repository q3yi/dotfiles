
function fd_git_proj --description 'Find all git projects in given paths using `fd` command'
    for root in $argv
        fd '.git$' $root --prune -u -t d -d 3 -x echo {//}
    end
end

function p --description 'Jump to git project folder'
    cd $(fd_git_proj $REPOS | fzf)
end
