-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local fonts = {
    -- latin fonts
    cascadia_code = { family = "Cascadia Code", weight = "Light", harfbuzz_features = { "calt", "ss01" } },
    fantasque_sans_mono = { family = "Fantasque Sans Mono" },
    iosevka_plex = { family = "Iosevka Term", weight = "Regular", harfbuzz_features = { "ss15" } },
    intel_one_mono = { family = "Intel One Mono" },
    jetbrains_mono = { family = "JetBrains Mono", weight = "Regular" },
    monego = { family = "Monego", weight = "Regular" },
    monofur = { family = "Monofur Nerd Font" },
    m_plus = { family = "M PLUS Code Latin", weight = "Light" },
    -- cjk fonts
    lxgw = { family = "LXGW WenKai", weight = "Regular" },
    lxgw_x12 = { family = "LXGW WenKai", weight = "Regular", scale = 1.2 },
    -- symbols
    symbols_only = { family = "Symbols Nerd Font Mono", scale = 0.75 },
}

local font_styles = {
    list = {
        {
            font_with_fallback = { fonts.jetbrains_mono, fonts.lxgw_x12, fonts.symbols_only },
            size = 12.5,
        },
        {
            font_with_fallback = { fonts.monego, fonts.lxgw_x12, fonts.symbols_only },
            size = 12.5,
        },
        {
            font_with_fallback = { fonts.fantasque_sans_mono, fonts.lxgw, fonts.symbols_only },
            size = 14,
        },
        {
            font_with_fallback = { fonts.monofur, fonts.lxgw, fonts.symbols_only },
            size = 14.5,
        },
    },
    selected = 2,
}

local function build_font_config_overrides(overrides, selected)
    local style = font_styles.list[selected]
    font_styles.selected = selected
    overrides.font = wezterm.font_with_fallback(style.font_with_fallback)
    overrides.font_size = style.size
end

build_font_config_overrides(config, font_styles.selected)

wezterm.on("change-font", function(window, _)
    local overrides = window:get_config_overrides() or {}
    local selected = font_styles.selected % #font_styles.list + 1

    build_font_config_overrides(overrides, selected)

    window:set_config_overrides(overrides)
end)

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
    { mods = "CTRL|ALT|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
    { mods = "CTRL|ALT|SHIFT", key = "t", action = wezterm.action.EmitEvent "flip-colorscheme" },
    { mods = "CTRL|ALT|SHIFT", key = "f", action = wezterm.action.EmitEvent "change-font" },
}

return config
