# nvim wrapper

function vim --description "nvim wrapper, set default nvim colorscheme base on system dark mode"
    if test "$NVIM_THEME" != ""
        nvim $argv
    else if is_dark_mode
        NVIM_THEME="nightfox" nvim $argv
    else
        NVIM_THEME="dayfox" nvim $argv
    end
end
