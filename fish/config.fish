# fish shell configuration

# set path
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/go/bin $PATH

# golang environments
set -gx GOPATH $HOME/go
set -gx GOPROXY "https://goproxy.cn"
set -gx GO111MODULE "on"
alias go4linux="GOOS=linux GOARCH=386 CGO_ENABLED=0 go build"

# set rustup and rust mirrors
set -gx RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

# homebrew bottle mirrors
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles


# correction for common mistake
alias t="tmux"
alias tumx="tmux"
alias vim="nvim"
