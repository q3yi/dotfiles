-- config wezterm

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local ok, helper = pcall(require, "helper")

if ok then
    helper.add_config(config)
end

local font_styles = { list = {}, selected = 0 }

if helper.font_styles ~= nil then
    font_styles = helper.font_styles
end

local function build_font_config_overrides(overrides, selected)
    if #font_styles.list == 0 then
        return
    end

    local style = font_styles.list[selected]
    font_styles.selected = selected

    overrides.font = wezterm.font_with_fallback(style.font_with_fallback)
    overrides.font_size = style.size
end

build_font_config_overrides(config, font_styles.selected)

wezterm.on("change-font", function(window, _)
    if #font_styles.list == 0 then
        return
    end

    local overrides = window:get_config_overrides() or {}
    local selected = font_styles.selected % #font_styles.list + 1

    build_font_config_overrides(overrides, selected)
    window:set_config_overrides(overrides)
end)

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

local colorschemes = {
    -- dark = "Ibm 3270 (High Contrast) (Gogh)",
    dark = "Jellybean (Gogh)",
    -- dark = "Brogrammer (Gogh)",
    -- dark = "Campbell (Gogh)",
    -- dark = "Borland (Gogh)",

    light = "Terminal Basic (Gogh)",
    -- light = "Bluloco Light (Gogh)",
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

config.hide_tab_bar_if_only_one_tab = true

config.automatically_reload_config = false

config.keys = {
    { mods = "CTRL|ALT|SHIFT", key = "r", action = wezterm.action.ReloadConfiguration },
    { mods = "CTRL|ALT|SHIFT", key = "t", action = wezterm.action.EmitEvent "flip-colorscheme" },
    { mods = "CTRL|ALT|SHIFT", key = "f", action = wezterm.action.EmitEvent "change-font" },
}

return config
