function fish_title
    if set -q ZMX_SESSION
        echo "[$ZMX_SESSION"] (status current-command) (prompt_pwd)
    else
        echo (status current-command) (prompt_pwd)
    end
end
