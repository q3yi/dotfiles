-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
    -- { family = "Iosevka Term Extended", weight = "Regular", harfbuzz_features = { "ss15" } },
    -- { family = "Monego", weight = "Regular" },
    -- { family = "Cascadia Code", weight = "Light", harfbuzz_features = { "calt", "ss01" } },
    { family = "JetBrains Mono", weight = "Regular" },

    { family = "LXGW WenKai", weight = "Regular", scale = 1.2 },
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
})

config.font_size = 13
config.freetype_load_target = "Light"
config.front_end = "WebGpu"
config.freetype_load_flags = "NO_AUTOHINT"
-- config.line_height = 0.9

-- Config cursor style
--
-- config.default_cursor_style = "BlinkingBlock"  -- "BlinkingBlock" is not working in neovim
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
-- config.cursor_blink_rate = 800
config.force_reverse_video_cursor = true
config.mouse_bindings = {
    -- make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

-- make both option key send alt in mac
config.send_composed_key_when_left_alt_is_pressed = false;
config.send_composed_key_when_right_alt_is_pressed = false;

-- Config theme, better to use a custom cursor color if using theme, some theme
-- override the cursor color and may cover the text color in neovim.
--
-- config.color_scheme = "Modus-Vivendi"
-- config.color_scheme = "Tomorrow Night"
-- config.color_scheme = "Solarized Dark (Gogh)"

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_padding = { left = "0.5cell", right = "0.5cell", top = 0, bottom = 0 }

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    { mods = "CMD|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
}
-- config.automatically_reload_config = true

return config
