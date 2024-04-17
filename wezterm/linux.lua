-- Configs for linux
local wezterm = require("wezterm")
local fonts = require("fonts")

local M = {}

function M.add_config(cfg)
    cfg.enable_wayland = true
    cfg.initial_cols = 120
    cfg.initial_rows = 45

    cfg.window_padding = {
        left = "1px", right = "1px", top = "1px", bottom = "1px"
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
                fonts.iosevka, fonts.honor_sans, fonts.symbols_only
            },
            size = 11,
        },
        {
            font_with_fallback = {
                fonts.jetbrains_mono, fonts.lxgw_x12, fonts.symbols_only
            },
            size = 10,
        },
        {
            font_with_fallback = {
                fonts.monego, fonts.lxgw_x12, fonts.symbols_only
            },
            size = 10,
        },
    },
    selected = 1,
}

return M
