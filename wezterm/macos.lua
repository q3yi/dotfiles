-- configs for macos
local wezterm = require("wezterm")
local fonts = require("fonts")

local M = {}

local fontconfigs = {
    {
        font_with_fallback = {
            fonts.pragmatapro,
            fonts.lxgw,
            fonts.symbols_only,
        },
        size = 14,
    },
    {
        font_with_fallback = {
            fonts.jetbrains_mono,
            fonts.lxgw_x12,
            fonts.symbols_only,
        },
        size = 12.5,
    },
    {
        font_with_fallback = {
            fonts.monaco,
            fonts.lxgw_x12,
            fonts.symbols_only,
        },
        size = 12.5,
    },
    {
        font_with_fallback = {
            fonts.monofur,
            fonts.lxgw,
            fonts.symbols_only,
        },
        size = 14.5,
    },
}

function M.add_config(cfg)
    -- make both option key send alt in mac
    cfg.send_composed_key_when_left_alt_is_pressed = false
    cfg.send_composed_key_when_right_alt_is_pressed = false

    -- cfg.window_background_opacity = 0.85
    -- cfg.macos_window_background_blur = 20
    -- cfg.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    cfg.window_padding = { left = 5, right = 5, top = 5, bottom = 0 }

    local gpus = wezterm.gui.enumerate_gpus()
    cfg.webgpu_preferred_adapter = gpus[1]
    cfg.freetype_load_target = "Light"
    cfg.front_end = "WebGpu"
    cfg.freetype_load_flags = "NO_AUTOHINT"
    -- cfg.line_height = 0.9

    cfg.initial_cols = 120
    cfg.initial_rows = 45

    fonts.setup(cfg, fontconfigs)
end

return M
