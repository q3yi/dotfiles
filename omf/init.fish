# fish shell configuration, oh-my-fish required
# https://github.com/oh-my-fish/oh-my-fish

# add customed function path to fish_function_path
set fish_function_path $OMF_CONFIG/functions $fish_function_path

set -gx LANG en_US.UTF-8

# golang configuration
# add go to system path
set -gx PATH $HOME/go/bin $PATH
# set golang environments
set -gx GOPATH $HOME/go
set -gx GOPROXY "https://goproxy.cn"
set -gx GO111MODULE on

# shortcut for cross system compile
alias go4linux="GOOS=linux GOARCH=386 CGO_ENABLED=0 go build"


# rust configuration
# add cargo to system path
set -gx PATH $HOME/.cargo/bin $PATH
# set rustup and rust mirrors
set -gx RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static

# homebrew configuration
# homebrew bottle mirrors
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

# correction for common mistake
alias vim="nvim"
