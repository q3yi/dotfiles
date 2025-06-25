--- hammerspoon config file

-- install SpoonInstall,
-- reference: https://www.hammerspoon.org/Spoons/SpoonInstall.html
hs.loadSpoon("SpoonInstall")

-- install PaperWM.spoon
spoon.SpoonInstall.repos.PaperWM = {
    url = "https://github.com/mogenson/PaperWM.spoon",
    desc = "PaperWM.spoon repository",
    branch = "release",
}

function UpdateSpoons()
    spoon.SpoonInstall:updateAllRepos()
end

-- config and start PaperWM
spoon.SpoonInstall:andUse("PaperWM", {
    repo = "PaperWM",
    config = {
        window_gap = 2,
        window_ratios = { 0.5, 0.7, 1 },
        -- swipe_fingers = 3,
    },
    start = true,
    hotkeys = {
        focus_left = { { "cmd", "ctrl" }, "h" },
        focus_right = { { "cmd", "ctrl" }, "l" },
        focus_up = { { "cmd", "ctrl" }, "k" },
        focus_down = { { "cmd", "ctrl" }, "j" },

        -- focus_prev = { { "cmd", "ctrl" }, "o" },

        swap_left = { { "cmd", "ctrl", "shift" }, "h" },
        swap_right = { { "cmd", "ctrl", "shift" }, "l" },
        swap_up = { { "cmd", "ctrl", "shift" }, "k" },
        swap_down = { { "cmd", "ctrl", "shift" }, "j" },

        center_window = { { "cmd", "ctrl" }, "c" },
        full_width = { { "cmd", "ctrl" }, "f" },
        cycle_width = { { "cmd", "ctrl" }, "up" },
        cycle_height = { { "cmd", "ctrl" }, "down" },

        increase_width = { { "cmd", "ctrl" }, "=" },
        decrease_width = { { "cmd", "ctrl" }, "-" },

        slurp_in = { { "cmd", "ctrl" }, "i" },
        barf_out = { { "cmd", "ctrl" }, "o" },

        toggle_floating = { { "cmd", "ctrl" }, "escape" },
    },
})

function Notify(title, text)
    hs.notify.new({ title = title, informativeText = text }):send()
end

function NotifyWithSound(title, text)
    hs.notify.new({ title = title, informativeText = text, soundName = "Blow" }):send()
end

-- quick switch app by shortcuts
local QuickSwitcher = {
    shortcuts = {
        { key = "1", app = "Ghostty" },
        { key = "2", app = "Zen" },
        { key = "3", app = "Obsidian" },
    },
}

function QuickSwitcher.setup(opt)
    if not opt.modifier then
        return
    end

    hs.fnutils.each(QuickSwitcher.shortcuts, function(config)
        hs.hotkey.bind(opt.modifier, config.key, function()
            hs.application.launchOrFocus(config.app)
        end)
    end)
end

-- change input source automatically by app
local InputSourceSwitcher = {
    SQUIRREL_SOURCE_ID = "im.rime.inputmethod.Squirrel.Hans",
    DVORAK_SOURCE_ID = "com.apple.keylayout.Dvorak",
    APPLE_US_SOURCE_ID = "com.apple.keylayout.US",
    APPLE_CHINESE_SOURCE_ID = "com.apple.inputmethod.SCIM.ITABC",
}

function InputSourceSwitcher.copy_source_id()
    local source_id = hs.keycodes.currentSourceID()
    local app_name = hs.window.focusedWindow():application():name()
    hs.pasteboard.setContents(source_id)
    Notify("App: " .. app_name, "Input source id copied.")
end

function InputSourceSwitcher.setup(opts)
    if opts.add_shortcut then
        hs.hotkey.bind({ "ctrl", "cmd" }, ".", InputSourceSwitcher.copy_source_id)
    end

    local app_source = {
        ["Code"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,
        ["Emacs"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,
        ["iTerm2"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,
        ["Alacritty"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,
        ["WezTerm"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,
        ["Ghostty"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,
        ["Zed"] = InputSourceSwitcher.APPLE_US_SOURCE_ID,

        -- ["WeChat"] = InputSourceSwitcher.SQUIRREL_SOURCE_ID,
        -- ["Obsidian"] = InputSourceSwitcher.SQUIRREL_SOURCE_ID,
        -- ["Firefox"] = InputSourceSwitcher.SQUIRREL_SOURCE_ID,
    }

    for app, source_id in pairs(app_source) do
        hs.window.filter.new(app):subscribe(hs.window.filter.windowFocused, function()
            hs.keycodes.currentSourceID(source_id)
        end)
    end
end

local function watch_config()
    local function reload(files)
        local flag = hs.fnutils.some(files, function(file)
            return file:sub(-4) == ".lua"
        end)

        if flag then
            hs.reload()
            Notify("Hammerspoon", "config reloaded")
        end
    end

    hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload):start()
end

local function main()
    -- install ipc cli
    -- for more information, follow the documention
    -- https://www.hammerspoon.org/docs/hs.ipc.html#cliInstall
    local ipc = require("hs.ipc")
    if not ipc.cliInstall() then
        Notify("Hammerspoon", "fail to instal hs ipc cli")
    end

    -- FIX: why option as modifier not work?
    QuickSwitcher.setup({ modifier = { "cmd" } })

    -- change input method by app
    InputSourceSwitcher.setup({ add_shortcut = false })

    -- auto reload config file
    -- watch_config()

    Notify("Hammerspoon", "config loaded")
end

main()
