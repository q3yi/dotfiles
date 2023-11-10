-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
    -- { family = "Fantasque Sans Mono" },
    -- { family = "Ubuntu Mono" },
    -- { family = "Iosevka Term SS08", weight = "Light" },
    { family = "M PLUS Code Latin", weight = "Light" },
    -- { family = "JetBrains Mono", weight = "Light" },
    -- { family = "STFangsong", weight = "Regular" },
    { family = "SimSong", weight = "Regular" },
    -- { family = "LXGW WenKai", weight = "Regular" },
    -- { family = "Noto Serif CJK SC", weight = "Regular" },

})

config.font_size = 14
config.freetype_load_target = "Light"

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
