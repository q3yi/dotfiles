--- hammerspoon config file
require("hs.ipc")

function Notify(title, text)
    hs.notify.new({ title = title, informativeText = text }):send()
end

function NotifyWithSound(title, text)
    hs.notify.new({ title = title, informativeText = text, soundName = "Blow" }):send()
end

-- resizing window with shortcuts
-- the up, down, left, right function take screen as a 6*2 grid
local window_manager = {
    previous = { win_title = "", x = 0, y = 0, w = 6, h = 2, timestamp = 0 },
}

function window_manager.get_prev_layout()
    local now = hs.timer.secondsSinceEpoch()
    if now - window_manager.previous.timestamp > 10 then
        return { win_title = "", x = 0, y = 0, w = 3, h = 2, timestamp = 0 }
    end

    return window_manager.previous
end

function window_manager.save_prev_layout(win_title, cell)
    local prev = window_manager.previous
    prev.win_title = win_title
    prev.x = cell.x
    prev.y = cell.y
    prev.w = cell.w
    prev.h = cell.h
    prev.timestamp = hs.timer.secondsSinceEpoch()
end

function window_manager.set_frame(win, cell)
    local win_frame = win:frame()
    local screen_frame = win:screen():frame()

    win_frame.x = screen_frame.x + screen_frame.w * cell.x / 6
    win_frame.w = screen_frame.w * cell.w / 6
    win_frame.y = screen_frame.y + screen_frame.h * cell.y / 2
    win_frame.h = screen_frame.h * cell.h / 2

    win:setFrame(win_frame, 0)

    window_manager.save_prev_layout(win:title(), cell)
end

function window_manager.to_left()
    local win = hs.window.focusedWindow()
    local prev = window_manager.get_prev_layout()
    local win_title = win:title()
    local w = 3

    if prev.win_title == win_title then
        w = prev.w + 1
        if w > 4 then
            w = 2
        end
    else
        w = 6 - prev.w
    end

    local cell = { x = 0, y = prev.y, w = w, h = prev.h }
    window_manager.set_frame(win, cell)
end

function window_manager.to_right()
    local win = hs.window.focusedWindow()
    local prev = window_manager.get_prev_layout()
    local win_title = win:title()
    local w = 3

    if prev.win_title == win_title then
        w = prev.w + 1
        if w > 4 then
            w = 2
        end
    else
        w = 6 - prev.w
    end

    local cell = { x = 6 - w, y = prev.y, w = w, h = prev.h }
    window_manager.set_frame(win, cell)
end

function window_manager.to_top()
    local win = hs.window.focusedWindow()
    local prev = window_manager.get_prev_layout()
    local win_title = win:title()
    local h = 2

    if prev.win_title == win_title then
        h = prev.h + 1
        if h > 2 then
            h = 1
        end
    end

    local cell = { x = 0, y = 0, w = 6, h = h }
    if h == 2 then
        win:maximize(0)
        window_manager.save_prev_layout(win_title, cell)
    else
        window_manager.set_frame(win, cell)
    end
end

-- to_bottom function always place current window to lower half screen
function window_manager.to_bottom()
    local win = hs.window.focusedWindow()
    local cell = { x = 0, y = 1, w = 6, h = 2 }
    window_manager.set_frame(win, cell)
end

function window_manager.to_center()
    local win = hs.window.focusedWindow()
    local cell = { x = 1, y = 0, w = 4, h = 2 }
    window_manager.set_frame(win, cell)
end

function window_manager.setup(opts)
    hs.grid.MARGINX = 0
    hs.grid.MARGINY = 0

    if not opts.modifier then
        return
    end

    hs.hotkey.bind(opts.modifier, "Left", window_manager.to_left)
    hs.hotkey.bind(opts.modifier, "Right", window_manager.to_right)
    hs.hotkey.bind(opts.modifier, "Up", window_manager.to_top)
    hs.hotkey.bind(opts.modifier, "Down", window_manager.to_bottom)
    hs.hotkey.bind(opts.modifier, "c", window_manager.to_center)
    hs.hotkey.bind(opts.modifier, "g", function()
        local win = hs.window.focusedWindow()
        hs.grid.setGrid({ w = 6, h = 4 }, win:screen())
        hs.grid.toggleShow()
    end)
end

-- quick switch app by shortcuts
local quick_switcher = {
    shortcuts = {
        { key = "1", app = "Alacritty" },
        { key = "2", app = "Brave Browser" },
        { key = "3", app = "Obsidian" },
    },
}

function quick_switcher.setup(opt)
    if not opt.modifier then
        return
    end
    hs.fnutils.each(quick_switcher.shortcuts, function(config)
        hs.hotkey.bind(opt.modifier, config.key, function()
            hs.application.launchOrFocus(config.app)
        end)
    end)
end

-- change input source automatically by app
local input_source = {
    SQUIRREL_SOURCE_ID = "im.rime.inputmethod.Squirrel.Hans",
    DVORAK_SOURCE_ID = "com.apple.keylayout.Dvorak",
    APPLE_US_SOURCE_ID = "com.apple.keylayout.US",
    APPLE_CHINESE_SOURCE_ID = "com.apple.inputmethod.SCIM.ITABC",
}

function input_source.copy_source_id()
    local source_id = hs.keycodes.currentSourceID()
    local app_name = hs.window.focusedWindow():application():name()
    hs.pasteboard.setContents(source_id)
    Notify("App: " .. app_name, "Input source id copied.")
end

function input_source.setup(opts)
    if opts.add_shortcut then
        hs.hotkey.bind({ "ctrl", "cmd" }, ".", input_source.copy_source_id)
    end

    local app_source = {
        ["Code"] = input_source.APPLE_US_SOURCE_ID,
        ["Emacs"] = input_source.APPLE_US_SOURCE_ID,
        ["iTerm2"] = input_source.APPLE_US_SOURCE_ID,
        ["Alacritty"] = input_source.APPLE_US_SOURCE_ID,
        ["WezTerm"] = input_source.APPLE_US_SOURCE_ID,

        -- ["WeChat"] = input_source.SQUIRREL_SOURCE_ID,
        -- ["Obsidian"] = input_source.SQUIRREL_SOURCE_ID,
        -- ["Firefox"] = input_source.SQUIRREL_SOURCE_ID,
    }

    for app, source_id in pairs(app_source) do
        hs.window.filter.new(app):subscribe(hs.window.filter.windowFocused, function()
            hs.keycodes.currentSourceID(source_id)
        end)
    end
end

local function auto_reload_config(opt)
    local function check_reload(files)
        local flag = hs.fnutils.some(files, function(file)
            return file:sub(-4) == ".lua"
        end)

        if flag then
            hs.reload()
            Notify("Hammerspoon", "config reloaded")
        end
    end

    if opt.watch then
        hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", check_reload):start()
    end
end

local function main()
    -- install ipc cli
    -- for more information, follow the documention
    -- https://www.hammerspoon.org/docs/hs.ipc.html#cliInstall
    if not hs.ipc.cliInstall() then
        Notify("Hammerspoon", "fail to instal hs ipc cli")
    end

    -- register hotkeys to arrange multiple windows
    window_manager.setup({ modifier = { "ctrl", "alt" } })

    quick_switcher.setup({ modifier = { "alt" } })

    -- change input method by app
    input_source.setup({ add_shortcut = false })

    -- auto reload config file
    auto_reload_config({ watch = false })

    Notify("Hammerspoon", "config loaded")
end

main()
