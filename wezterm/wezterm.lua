-- config wezterm

local function detect_system()
    local kernel_to_sys = {
        Linux = "linux",
        Darwin = "macos",
        Windows = "window",
    }

    local kernal = "Windows"

    -- Unix, Linux variants
    local r, _ = assert(io.popen("uname -s 2>/dev/null", "r"))
    if r then
        kernal = r:read()
    end

    return kernel_to_sys[kernal]
end

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local ok, system_cfg = pcall(require, detect_system())
if ok then
    system_cfg.setup(config)
end

config.force_reverse_video_cursor = true -- change cursor fg base on bg.
config.mouse_bindings = {
    -- make CTRL-Click open hyperlinks, not working in tmux.
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

local colorschemes = {
    -- dark = "Wez",
    dark = "Brogrammer (Gogh)",
    -- dark = "Pro",
    -- dark = "tokyonight_night",

    -- light = "Terminal Basic (Gogh)",
    light = "Bluloco Light (Gogh)",

    current = "dark",
}

config.color_scheme = colorschemes.dark

-- change theme with keys
wezterm.on("flip-colorscheme", function(window, _)
    if colorschemes.current == colorschemes.dark then
        colorschemes.current = colorschemes.light
    else
        colorschemes.current = colorschemes.dark
    end

    window:set_config_overrides({
        color_scheme = colorschemes.current,
    })
end)

config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true

config.keys = {
    { mods = "CTRL|ALT|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
    { mods = "CTRL|ALT|SHIFT", key = "t", action = wezterm.action.EmitEvent("flip-colorscheme") },
    { mods = "CTRL|ALT|SHIFT", key = "f", action = wezterm.action.EmitEvent("change-font") },
}

return config
