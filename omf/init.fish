# fish shell configuration, oh-my-fish required
# https://github.com/oh-my-fish/oh-my-fish

# add customed function path to fish_function_path
set fish_function_path $OMF_CONFIG/functions $fish_function_path

set -gx LANG en_US.UTF-8

if test "$WSL_DISTRO_NAME" != ""
    # set host in WSL
    set -gx WSL_HOST_IP (awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
    # set x11 forward server
    set -gx DISPLAY $WSL_HOST_IP:0
    set -gx LIBGL_ALWAYS_INDIRECT 1

    # set keyboard layout
    setxkbmap -layout "us(dvorak)"

    # gtk setting for high DPI
    # set -gx GDK_SCALE 0.5
    # set -gx GDK_DPI_SCALE 2
end

if test (uname) = Darwin
    # homebrew configuration
    set -gx PATH /usr/local/sbin $PATH
    # homebrew bottle mirrors
    set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
end

# use gnu coreutils instead `ls' in macOS which is origin from BSD
set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

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

# haskell configuration
set -gx PATH $HOME/.ghcup/bin $PATH
