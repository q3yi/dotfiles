-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
    -- { family = "Fantasque Sans Mono" },
    -- { family = "Envy Code R" },
    -- { family = "M PLUS Code Latin", weight = "Light" },
    -- "Terminus (TTF)",

    -- JetBrains Mono's width is 0.6, so you should scale CJK font to 1.2
    -- for better experience
    { family = "JetBrains Mono", weight = "Light" },

    -- CJK fonts
    -- { family = "STFangsong", weight = "Regular", scale = 1.2 },
    { family = "SimSong", weight = "Regular", scale = 1.2 },
    -- { family = "LXGW WenKai", weight = "Regular", scale = 1.2 },
    -- { family = "Noto Serif CJK SC", weight = "Regular", scale = 1.2 },

    -- Symbolics
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
})

config.font_size = 13
config.freetype_load_target = "Light"
config.front_end = "WebGpu"

-- config.color_scheme = "Modus-Vivendi"
-- config.color_scheme = "Tomorrow Night"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    { mods = "CMD|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
}
-- config.automatically_reload_config = true

return config
