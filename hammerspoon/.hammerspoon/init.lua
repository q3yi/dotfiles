--- hammerspoon config file

function sendNotification(title, text)
    hs.notify.new({ title = title, informativeText = text }):send()
end

-- Resizing windows
function setupWindowsManager()
    hs.grid.MARGINX = 0
    hs.grid.MARGINY = 0
    hs.grid.GRIDWIDTH = 12
    hs.grid.GRIDHEIGHT = 12

    local layout = {
        title = '',
        x = 0,
        y = 0,
        w = 2, -- max:12, 2 stand for (2 * 3) / 12
        h = 2, -- max:2 2 stand for screen max height
    }

    local function clearLayout()
        layout.title = ''
        layout.x = 0
        layout.y = 0
        layout.w = 2
        layout.h = 2
    end

    local function left()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        if title == layout.title then
            layout.w = layout.w % 3 + 1
        else
            clearLayout()
            layout.title = title
        end

        f.x, f.w = max.x, (max.w * layout.w * 3 / 12)
        f.y, f.h = max.y + layout.y * max.h / 2, layout.h * max.h / 2

        win:setFrame(f, 0)
    end

    local function right()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        if title == layout.title then
            layout.x = layout.x % 3 + 1
            layout.w = 4 - layout.x
        else
            clearLayout()
            layout.x = 2
            layout.w = 2
            layout.title = title
        end

        f.x, f.w = max.x + 3 * layout.x * max.w / 12, max.w * layout.w * 3 / 12
        f.y, f.h = max.y + layout.y * max.h / 2, layout.h * max.h / 2

        win:setFrame(f, 0)
    end

    local function topOrFull()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        if title == layout.title then
            layout.x, layout.y, layout.w, layout.h = 0, 0, 4, layout.h % 2 + 1
        else
            layout.x, layout.y, layout.h, layout.w = 0, 0, 2, 4
            layout.title = title
        end

        if layout.h == 2 then
            layout.w = 4
            win:maximize(0)
        else
            f.y, f.h = max.y, layout.h * max.h / 2
            f.x, f.w = max.x, max.w

            win:setFrame(f, 0)
        end
    end

    local function bottom()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        layout.title = title
        layout.x, layout.y, layout.h, layout.w = 0, 1, 1, 4

        f.y, f.h = max.y + max.h / 2, max.h / 2
        f.x, f.w = max.x, max.w

        win:setFrame(f, 0)
    end

    -- bind hotkeys
    hs.fnutils.each({
        { key = "Left",  fn = left },
        { key = "Right", fn = right },
        { key = "Up",    fn = topOrFull },
        { key = "Down",  fn = bottom },
    }, function(meta)
        hs.hotkey.bind({ 'ctrl', 'alt' }, meta.key, meta.fn)
    end)
end

-- function switchAppByShortcut()
--    -- quick switch app
--    local appSwitchModifier = {"alt"}

--    hs.fnutils.each({
--	 {key = "1", app = "Firefox"},
--	 {key = "2", app = "iTerm"},
--	 {key = "3", app = "Emacs"},
--	 {key = "4", app = "ForkLift"}
--    }, function(meta)
--	 hs.hotkey.bind(appSwitchModifier, meta.key, function()
--	       hs.application.launchOrFocus(meta.app)
--	 end)
--    end)
-- end

function setInputMethodByApp(keyToShowSourceID)
    function showInputMethodSourceID()
        hs.alert.show("App path:        "
            .. hs.window.focusedWindow():application():path()
            .. "\n"
            .. "App name:      "
            .. hs.window.focusedWindow():application():name()
            .. "\n"
            .. "IM source id:  "
            .. hs.keycodes.currentSourceID())
    end

    if (keyToShowSourceID) then
        hs.hotkey.bind({ 'ctrl', 'cmd' }, ".", showInputMethodSourceID)
    end

    function setToChineseInputMethod()
        hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
    end

    function setToDvorakInputMethod()
        hs.keycodes.currentSourceID("com.apple.keylayout.Dvorak")
    end

    function addAppInputMethodHook(appName, setInputMethodFunc, event)
        event = event or hs.window.filter.windowFocused

        hs.window.filter.new(appName):subscribe(event, setInputMethodFunc)
    end

    -- Automatic change input method base on current App focused
    hs.fnutils.each({
        -- {app = "Emacs", func = setToDvorakInputMethod},
        -- {app = "Code", func = setToDvorakInputMethod},
        { app = "iTerm2", func = setToDvorakInputMethod },
        -- {app = "Firefox", func = setToDvorakInputMethod},

        { app = "WeChat", func = setToChineseInputMethod }
    }, function(config)
        hs.window.filter.new(config.app):subscribe(
            hs.window.filter.windowFocused,
            function() config.func() end)
    end)
end

function installIPCClient()
    if not hs.ipc.cliInstall() then
        sendNotification('Hammerspoon', 'fail to instal hs ipc cli')
    end
end

function watchConfigFileChange()
    function reloadConfig(files)
        doReload = false
        for _, file in pairs(files) do
            if file:sub(-4) == ".lua" then
                doReload = true
            end
        end
        if doReload then
            hs.reload()
            sendNotification('Hammerspoon', 'config reloaded')
        end
    end

    hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
end

function main()
    -- register hotkeys to arrange multiple windows
    setupWindowsManager()

    -- change input method by app
    -- setInputMethodByApp()

    -- install ipc cli
    -- for more information, follow the documention
    -- https://www.hammerspoon.org/docs/hs.ipc.html#cliInstall
    installIPCClient()

    -- auto reload config file
    --watchConfigFileChange()

    sendNotification('Hammerspoon', 'config loaded')
end

main()
