-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
    -- { family = "Iosevka Term Extended",  weight = "Regular", harfbuzz_features = { "ss15" } },
    -- { family = "Cascadia Code",          weight = "Light",   harfbuzz_features = { "calt", "ss01" } },
    { family = "Monego",                 weight = "Regular" },
    { family = "JetBrains Mono",         weight = "Regular" },

    { family = "LXGW WenKai",            weight = "Regular", scale = 1.2 },
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
})

config.font_size = 12.5
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
config.force_reverse_video_cursor = true -- change cursor fg base on bg.
config.mouse_bindings = {
    -- make CTRL-Click open hyperlinks, not working in tmux.
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

-- make both option key send alt in mac
config.send_composed_key_when_left_alt_is_pressed = false;
config.send_composed_key_when_right_alt_is_pressed = false;

local colorschemes = {
    -- dark = "Modus-Vivendi",
    dark = "Tomorrow Night",
    -- dark = "Catppuccin Mocha",
    -- dark = "Dark Pastel",

    -- light = "Catppuccin Latte",
    light = "Tomorrow",
    -- light = "Modus-Operandi",
}

config.color_scheme = colorschemes.dark

-- change theme with keys
wezterm.on("flip-colorscheme", function(window, _)
    local overrides = window:get_config_overrides()
    local selected = ""

    if not overrides or overrides.color_scheme == colorschemes.dark then
        selected = colorschemes.light
    else
        selected = colorschemes.dark
    end
    window:set_config_overrides {
        color_scheme = selected
    }
end)

-- config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 20
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 5, right = 5, top = 5, bottom = 0 }
config.hide_tab_bar_if_only_one_tab = true

config.automatically_reload_config = false

config.keys = {
    { mods = "CMD|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
    { mods = "CMD|SHIFT", key = "t", action = wezterm.action.EmitEvent "flip-colorscheme" },
}

return config
