-- fonts

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
        harfbuzz_features = { "calt=0" },
    },
    ibm_plex_mono = { family = "IBM Plex Mono" },
    intel_one_mono = { family = "Intel One Mono" },
    input_mono = { family = "Input Mono Compressed" },
    jetbrains_mono = { family = "JetBrains Mono", weight = "Regular" },
    monaco = { family = "Monaco", weight = "Regular" },
    monego = { family = "Monego", weight = "Regular" },
    monofur = { family = "Monofur" },
    m_plus = { family = "M PLUS Code Latin", weight = "Light" },

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
    symbols_only = { family = "Symbols Nerd Font Mono", scale = 0.75 },
}

return M
