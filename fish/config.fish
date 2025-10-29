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

    set HOMEBREW_NO_INSTALL_CLEANUP 1
    set HOMEBREW_NO_ENV_HINTS 1
end

# golang configuration
if test -d $HOME/go
    set -gx GOPATH $HOME/go
    set -gx GO111MODULE on
    set -gx GOPROXY "https://goproxy.cn"
    set -gx GOSUMDB "sum.golang.org" "https://goproxy.cn/sumdb/sum.golang.org"

    fish_add_path $GOPATH/bin
end

# rust configuration
if test -d $HOME/.cargo
    set -gx RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
    set -gx RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

    fish_add_path $HOME/.cargo/bin
end

# haskell configuration
if test -d $HOME/.ghcup
    fish_add_path $HOME/.ghcup/bin $HOME/.cabal/bin
end

# foundry for solidity
if test -d $HOME/.foundry
    fish_add_path $HOME/.foundry/bin
end

# flutter
if test -d $HOME/flutter
    fish_add_path $HOME/flutter/bin
end

# dotnet configuration
if test -d $HOME/.dotnet
    set -gx DOTNET_ROOT $HOME/.dotnet
    fish_add_path $HOME/.dotnet $HOME/.dotnet/tools
end

# zig configuration
if test -d $HOME/zig
    fish_add_path $HOME/zig/current
end

# ocaml
if test -d $HOME/.opam; and test -z "$OPAM_SWITCH_PREFIX"
    source $HOME/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
end

# fnm - node version manager
if command -v fnm >/dev/null; and test -z "$FNM_MULTISHELL_PATH"
    fnm env | source
end

# starship
if command -v starship >/dev/null
    starship init fish | source
end

if command -v nvim >/dev/null
    # set default editor to neovim
    set -gx EDITOR (command -v nvim)
    # set man pager to neovim
    set -gx MANPAGER "nvim +Man!"
end

# fzf
if command -v fzf >/dev/null
    fzf --fish | source
end

# setup shell proxies
proxy shell on

# set repos folder for quick jump command `p`
set -gx REPOS $HOME/.emacs.d/ $HOME/repos/ $HOME/.config/
