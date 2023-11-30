# Find and jump to project folder in predinfined roots

function p --description 'Jump to git project folder'
    # or use fd command instead of fdir
    # fd '.git$' $root --prune -u -t d -d 3 -x echo {//}
    cd $(fdir $REPOS | fzf)
end
