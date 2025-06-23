# Find and jump to project folder in predinfined roots

function p --description 'Jump to project folder'
    set --local options h/help 'has=+' 'in=+'

    argparse $options -- $argv

    if set --query _flag_help
        printf "Jump to project folder that has given subfolder or file.\n\n"
        printf "Usage: p [OPTIONS] [QUERY_STRING]\n\n"
        printf "Options:\n"
        printf "  -h/--help           Prints help and exits\n"
        printf "  --in  [FOLDER]      Search in given folder, default is set in env [REPOS]\n"
        printf "  --has [SEARCH_FILE] Has file in folder(default is .git)\n"
        return 0
    end

    set --query _flag_in; or set --local _flag_in $REPOS
    set --query _flag_has; or set --local _flag_has ".git"

    set --local _fzf fzf
    if test -n "$argv"
        set _fzf fzf --query $argv
    end

    # or use fd command instead of fdir
    # fd '.git$' $root --prune -u -t d -d 3 -x echo {//}
    set --local jump_to $(fdir --has $_flag_has $_flag_in | $_fzf)

    if test -n "$jump_to"
        cd $jump_to
    end
end
