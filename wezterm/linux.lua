-- Configs for linux
local wezterm = require("wezterm")
local fonts = require("fonts")

local M = {}

local fontconfigs = {
    {
        font_with_fallback = {
            fonts.ibm_plex_mono,
            fonts.lxgw_x12,
            fonts.symbols_only,
        },
        size = 11,
    },
    {
        font_with_fallback = {
            fonts.pragmatapro,
            fonts.harmony_sans,
            fonts.symbols_only,
        },
        size = 13,
    },
    {
        font_with_fallback = {
            -- { family = "Pragmasevka", harfbuzz_features = { "calt=0" } },
            fonts.iosevka,
            fonts.harmony_sans,
            fonts.symbols_only,
        },
        size = 13,
    },
    {
        font_with_fallback = {
            fonts.input_mono_compressed,
            fonts.harmony_sans,
            fonts.symbols_only,
        },
        size = 12,
    },
}

function M.setup(cfg)
    cfg.enable_wayland = true
    cfg.initial_cols = 128
    cfg.initial_rows = 48

    cfg.window_padding = {
        left = "1px",
        right = "1px",
        top = "1px",
        bottom = "1px",
    }

    -- local gpus = wezterm.gui.enumerate_gpus()
    -- cfg.webgpu_preferred_adapter = gpus[1]
    -- cfg.front_end = "WebGpu"
    cfg.check_for_updates = false
    cfg.freetype_load_target = "Light"

    fonts.setup(cfg, fontconfigs)
end

return M
