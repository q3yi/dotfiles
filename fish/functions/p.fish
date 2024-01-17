# Find and jump to project folder in predinfined roots

function p --description 'Jump to git project folder'
    set --local options h/help 'has=+'

    argparse $options -- $argv

    if set --query _flag_help
        printf "Usage: p [OPTIONS] [FOLDERS]\n\n"
        printf "Options:\n"
        printf "  -h/--help           Prints help and exits\n"
        printf "  --has [SEARCH_FILE] Has file in folder(default is .git)\n"
        return 0
    end

    set --query _flag_has; or set --local _flag_has ".git"

    set --local folders $REPOS

    if test -n "$argv"
        set folders $argv
    end

    # or use fd command instead of fdir
    # fd '.git$' $root --prune -u -t d -d 3 -x echo {//}
    set --local jump_to $(fdir --has $_flag_has $folders | fzf)

    if test -n "$jump_to"
        cd $jump_to
    end
end
