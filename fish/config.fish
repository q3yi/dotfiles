# fish shell configuration

set -gx LANG en_US.UTF-8

# config for WSL on windows
if test "$WSL_DISTRO_NAME" != ""
    # set host in WSL
    set -gx WSL_HOST_IP (awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
    # set x11 forward server
    set -gx DISPLAY $WSL_HOST_IP:0
    set -gx LIBGL_ALWAYS_INDIRECT 1

    # set keyboard layout
    # setxkbmap -layout "us(dvorak)"

    # gtk setting for high DPI
    # set -gx GDK_SCALE 0.5
    # set -gx GDK_DPI_SCALE 2
end

# config for macOS
if test (uname) = Darwin
    # homebrew configuration
    set -gx PATH /usr/local/sbin $PATH
    # homebrew bottle mirrors
    set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
    # use gnu coreutils instead `ls' in macOS which is origin from BSD
    set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
end

# golang configuration
if test -d $HOME/go
    set -gx GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH
    set -gx GO111MODULE on
    set -gx GOPROXY "https://goproxy.cn"
    set -gx GOSUMDB "sum.golang.org" "https://goproxy.cn/sumdb/sum.golang.org"
    if test (uname) != Linux
        # only needed on mac or windows
        alias go4linux="GOOS=linux GOARCH=386 CGO_ENABLED=0 go build"
    end
end
if test -d /usr/local/go
    # go root on linux
    set -gx PATH /usr/local/go/bin $PATH
end

# rust configuration
if test -d $HOME/.cargo
    set -gx PATH $HOME/.cargo/bin $PATH
    set -gx RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
    set -gx RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
end

# haskell configuration
if test -d $HOME/.ghcup
    set -gx PATH $HOME/.ghcup/bin $PATH
    set -gx PATH $HOME/.cabal/bin $PATH
end

# foundry for solidity
if test -d $HOME/.foundry
    set -gx PATH $HOME/.foundry/bin $PATH
end

# flutter
if test -d $HOME/flutter
    set -gx PATH $HOME/flutter/bin $PATH
end

# dotnet configuration
if test -d $HOME/.dotnet
    set -gx PATH $PATH $HOME/.dotnet
    set -gx PATH $PATH $HOME/.dotnet/tools
    set -gx DOTNET_ROOT $HOME/.dotnet
end

# zig configuration
if test -d $HOME/zig
    set -gx PATH $PATH $HOME/zig/current
end

# ocaml
if test -d $HOME/.opam
    source /home/max/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
end

# fnm - node version manager
if command -v fnm >/dev/null
    fnm env | source
end

# starship
if command -v starship >/dev/null
    starship init fish | source
end

# pyenv
if command -v pyenv >/dev/null
    pyenv init - | source
end

if command -v nvim >/dev/null
    # set default editor to neovim
    set -gx EDITOR (command -v nvim)
    # set man pager to neovim
    set -gx MANPAGER "nvim +Man!"
end

# fzf
if command -v fzf >/dev/null
    fzf --fish | FZF_CTRL_T_COMMAND= source
end

# setup shell proxies
proxy shell on

# set repos folder for quick jump command `p`
set -gx REPOS $HOME/.emacs.d/
set -gx REPOS $REPOS $HOME/repos/
set -gx REPOS $REPOS $HOME/.config/
