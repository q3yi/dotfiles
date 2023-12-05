# Create tmux session with given session name or folder name

function tn --description 'Create new tmux session.'
    set name $argv[1]
    if test -z $name
        set name $(basename $PWD | tr '.' '_')
    end
    tmux new -t $name
end
