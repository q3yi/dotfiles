-- fonts

local wezterm = require("wezterm")

local fontconfigs = {
    configs = {
        fonts = { family = "monospace" },
        size = 14,
    },
    current_index = 1,
}

local M = {
    -- latin fonts
    cascadia_code = {
        family = "Cascadia Code",
        weight = "Light",
        harfbuzz_features = { "calt", "ss01" },
    },
    fantasque_sans_mono = { family = "Fantasque Sans Mono" },
    iosevka = {
        family = "Iosevka Term",
        weight = "Regular",
        -- stretch = "Expanded",
        harfbuzz_features = {
            "calt=1",
        },
    },
    ibm_plex_mono = { family = "IBM Plex Mono" },
    intel_one_mono = { family = "Intel One Mono" },
    input_mono_compressed = { family = "Input Mono Compressed" },
    jetbrains_mono = { family = "JetBrains Mono", weight = "Regular" },
    monaco = { family = "Monaco", weight = "Regular" },
    monego = { family = "Monego", weight = "Regular" },
    monofur = { family = "Monofur" },
    m_plus = { family = "M PLUS Code Latin", weight = "Light" },
    victor_mono = { family = "Victor Mono" },
    envy_code_r = { family = "Envy Code R" },
    pragmatapro = { family = "PragmataPro Mono Liga" },

    -- cjk fonts
    lxgw = { family = "LXGW WenKai", weight = "Regular" },
    lxgw_x12 = { family = "LXGW WenKai", weight = "Regular", scale = 1.2 },
    honor_sans = { family = "HONOR Sans CN", weight = "Light" },
    honor_sans_x12 = { family = "HONOR Sans CN", weight = "Light", scale = 1.2 },
    harmony_sans = { family = "HarmonyOS Sans SC", weight = "Light" },
    harmony_sans_x12 = { family = "HarmonyOS Sans SC", weight = "Light", scale = 1.2 },
    mi_sans = { family = "MiSans", weight = "Light" },
    mi_sans_x12 = { family = "MiSans", weight = "Light", scale = 1.2 },
    mi_sans_l3 = { family = "MiSans L3" },
    mi_sans_l3_x12 = { family = "MiSans L3", scale = 1.2 },
    noto_sans_cjk = { family = "Noto Sans CJK SC", weight = "Regular" },

    -- symbols
    symbols_only = { family = "Symbols Nerd Font Mono" },
}

function M.setup(config, fonts)
    if fonts then
        fontconfigs.configs = fonts
        fontconfigs.current_index = 1
    end

    local current_config = fontconfigs.configs[fontconfigs.current_index]

    config.font = wezterm.font_with_fallback(current_config.font_with_fallback)
    config.font_size = current_config.size

    -- register event handler
    wezterm.on("change-font", M.on_change_font)
end

function M.next_font()
    fontconfigs.current_index = fontconfigs.current_index % #fontconfigs.configs + 1
    return fontconfigs.configs[fontconfigs.current_index]
end

function M.on_change_font(window, _)
    local overrides = window:get_config_overrides() or {}
    local font = M.next_font()

    overrides.font = wezterm.font_with_fallback(font.font_with_fallback)
    overrides.font_size = font.size

    window:set_config_overrides(overrides)
end

return M
