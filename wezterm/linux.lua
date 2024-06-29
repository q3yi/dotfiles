-- Configs for linux
local wezterm = require("wezterm")
local fonts = require("fonts")

local M = {}

function M.add_config(cfg)
    cfg.enable_wayland = true
    cfg.initial_cols = 128
    cfg.initial_rows = 48

    cfg.window_padding = {
        left = "1px",
        right = "1px",
        top = "1px",
        bottom = "1px",
    }

    local gpus = wezterm.gui.enumerate_gpus()
    cfg.webgpu_preferred_adapter = gpus[1]
    cfg.front_end = "WebGpu"
    cfg.freetype_load_flags = "NO_AUTOHINT"
end

M.font_styles = {
    list = {
        {
            font_with_fallback = {
                fonts.iosevka,
                fonts.harmony_sans,
                fonts.symbols_only,
            },
            size = 11,
        },
        {
            font_with_fallback = {
                fonts.jetbrains_mono,
                fonts.harmony_sans_x12,
                fonts.symbols_only,
            },
            size = 10,
        },
        {
            font_with_fallback = {
                fonts.input_mono,
                fonts.harmony_sans_x12,
                fonts.symbols_only,
            },
            size = 11,
        },
        {
            font_with_fallback = {
                fonts.monego,
                fonts.harmony_sans_x12,
                fonts.symbols_only,
            },
            size = 10,
        },
    },
    selected = 1,
}

return M
