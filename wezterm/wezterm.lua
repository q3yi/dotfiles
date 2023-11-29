-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
    -- Fonts which are exactly 0.5em width, do not need to scale CJK font.
    -- { family = "Fantasque Sans Mono" },
    { family = "Iosevka Term", weight = "Regular", harfbuzz_features = { "ss08", "calt=0", "dlig" } },
    -- { family = "M PLUS Code Latin", weight = "Regular" },
    -- { family = "Monofur Nerd Font", weight = "Regular" },


    -- Fonts which are 0.6em width, scale CJK font to 1.2 when use.
    -- { family = "JetBrains Mono", weight = "Regular" },
    -- { family = "Monego", weight = "Regular" },
    -- { family = "JuliaMono", weight = "Regular" },
    -- { family = "Victor Mono", weight = "Regular" },
    -- { family = "Sometype Mono", weight = "Regular" },
    -- {
    --     family = "Rec Mono Linear",
    --     weight = "Regular",
    --     harfbuzz_features = {"calt", "dlig"}
    -- },

    -- Fonts which width is not 0.5em nor 0.6em
    -- { family = "Envy Code R" },
    -- { family = "Sudo Var", weight = "Regular" },

    -- CJK fonts
    -- { family = "STFangsong", weight = "Regular", scale = 1.2 },
    -- { family = "SimSong", weight = "Regular" },
    { family = "Sarasa Term SC", weight = "Regular" },
    -- { family = "LXGW WenKai", weight = "Regular", scale = 1.2 },
    -- { family = "Noto Sans CJK SC", weight = "Regular" },

    -- Symbolics
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
})

config.font_size = 14
config.freetype_load_target = "Light"
config.front_end = "WebGpu"

-- Config cursor style
--
-- config.default_cursor_style = "BlinkingBlock"  -- "BlinkingBlock" is not working in neovim
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
-- config.cursor_blink_rate = 800
-- config.force_reverse_video_cursor = true
config.mouse_bindings = {
    -- make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

-- Config theme, better to use a custom cursor color if using theme, some theme
-- override the cursor color and may cover the text color in neovim.
--
-- config.color_scheme = "Modus-Vivendi"
-- config.color_scheme = "Tomorrow Night"
-- config.color_scheme = "Solarized Dark (Gogh)"

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    { mods = "CMD|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
}
-- config.automatically_reload_config = true

return config
