# Add some defaults config to git

function git_default_configs --description "Add some basic config to git config"
    git config --global user.name "Qing Yi"
    git config --global user.email "qing.yi@outlook.com"
    git config --global user.signingkey "F0EE6D5C89089BC1"

    git config --global init.defaultBranch main
    git config --global commit.gpgsign true
    git config --global pull.rebase true
end
