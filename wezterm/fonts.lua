-- fonts

local M = {
    -- latin fonts
    cascadia_code = {
        family = "Cascadia Code",
        weight = "Light",
        harfbuzz_features = { "calt", "ss01" },
    },
    fantasque_sans_mono = { family = "Fantasque Sans Mono" },
    iosevka = { family = "Iosevka Term", weight = "Regular" },
    intel_one_mono = { family = "Intel One Mono" },
    jetbrains_mono = { family = "JetBrains Mono", weight = "Regular" },
    monaco = { family = "Monaco", weight = "Regular" },
    monego = { family = "Monego", weight = "Regular" },
    monofur = { family = "Monofur Nerd Font" },
    m_plus = { family = "M PLUS Code Latin", weight = "Light" },

    -- cjk fonts
    lxgw = { family = "LXGW WenKai", weight = "Regular" },
    lxgw_x12 = { family = "LXGW WenKai", weight = "Regular", scale = 1.2 },
    honor_sans = { family = "HONOR Sans CN", weight = "Light" },
    harmony_sans = { family = "HarmonyOS Sans SC", weight = "Light" },
    noto_sans_cjk = { family = "Noto Sans CJK SC", weight = "Regular" },

    -- symbols
    symbols_only = { family = "Symbols Nerd Font Mono", scale = 0.75 },
}

return M
