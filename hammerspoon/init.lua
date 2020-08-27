
-- Resizing windows

hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 12
hs.grid.GRIDHEIGHT = 12

local winModifier = {"ctrl", "alt"}

local verticalLayout = {
    {0, 0, 4, 12},
    {0, 0, 6, 12},
    {0, 0, 8, 12},
    {8, 0, 8, 12},
    {6, 0, 6, 12},
    {4, 0, 4, 12}
}

local horizontalLayout = {
    {0, 0, 12, 4},
    {0, 0, 12, 6},
    {0, 0, 12, 8},
    {0, 4, 12, 8},
    {0, 6, 12, 6},
    {0, 8, 12, 4}
}

local resizeWin = (function()
    local leftWidth = 2
    local rightWidth = 2
    local topHeight = 2
    local bottomHeight = 2
    local preWds = ''

    local function left()
        -- clear vertical align
        topHeight, bottomHeight = 2, 2

        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        f.x = max.x
        f.y = max.y
        f.h = max.h
        if title == preWds then
            leftWidth = (leftWidth) % 3 + 1
        else
            leftWidth = 4 - rightWidth
        end

        if leftWidth == 1 then
            f.w = max.w / 3
        elseif leftWidth == 2 then
            f.w = max.w / 2
        else
            f.w = max.w / 3 * 2
        end

        preWds = title
        win:setFrame(f, 0)
    end

    local function right()
        -- clear vertical align
        topHeight, bottomHeight = 2, 2

        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        f.y = max.y
        f.h = max.h
        if title == preWds then
            rightWidth = (rightWidth) % 3 + 1
        else
            rightWidth = 4 - leftWidth
        end

        if rightWidth == 1 then
            f.w = max.w / 3
            f.x = max.x + (max.w / 3 * 2)
        elseif rightWidth == 2 then
            f.w = max.w / 2
            f.x = max.x + (max.w / 2)
        else
            f.w = max.w / 3 * 2
            f.x = max.x + (max.w / 3)
        end

        preWds = title
        win:setFrame(f, 0)

    end

    local function top()
        -- clear horizontal align
        leftWidth, rightWidth = 2, 2

        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        f.y = max.y
        f.x = max.x
        f.w = max.w
        if title == preWds then
            topHeight = (topHeight) % 3 + 1
        else
            topHeight = 4 - bottomHeight
        end

        if topHeight == 1 then
            f.h = max.h / 3
        elseif topHeight == 2 then
            f.h = max.h / 2
        else
            f.h = max.h / 3 * 2
        end

        preWds = title
        win:setFrame(f, 0)
    end

    local function bottom()
        -- clear horizontal align
        leftWidth, rightWidth = 2, 2

        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local title = win:title()

        f.x = max.x
        f.w = max.w
        if title == preWds then
            bottomHeight = (bottomHeight) % 3 + 1
        else
            bottomHeight = 4 - topHeight
        end

        if bottomHeight == 1 then
            f.h = max.h / 3
            f.y = max.y + (max.h / 3 * 2)
        elseif bottomHeight == 2 then
            f.h = max.h / 2
            f.y = max.y + (max.h / 2)
        else
            f.h = max.h / 3 * 2
            f.y = max.y + (max.h / 3)
        end

        preWds = title
        win:setFrame(f, 0)
    end

    local function full()
        local win = hs.window.focusedWindow()
        leftWidth, rightWidth, topHeight, bottomHeight = 2, 2, 2, 2
        preWds = ''
        win:maximize(0)
    end

    return {
        left = left,
        right = right,
        top = top,
        bottom = bottom,
        full = full
    }
end)()

hs.fnutils.each({
    {key = "Left", fn = resizeWin.left},
    {key = "Right", fn = resizeWin.right},
    {key = "Up", fn = resizeWin.top},
    {key = "Down", fn = resizeWin.bottom},
    {key = "u", fn = resizeWin.full}
}, function(meta)
    hs.hotkey.bind(winModifier, meta.key, meta.fn)
end)


-- quick switch app
local appSwitchModifier = {"alt"}

hs.fnutils.each({
    {key = "1", app = "2Do"},
    {key = "2", app = "Firefox"},
    {key = "3", app = "Visual Studio Code"},
    {key = "4", app = "iTerm"},
    {key = "5", app = "DevDocs"},
    {key = "6", app = "ForkLift"},
    {key = "7", app = "Postman"},
    {key = "0", app = "Spotify"},
}, function(meta)
    hs.hotkey.bind(appSwitchModifier, meta.key, function()
        hs.application.launchOrFocus(meta.app)
    end)
end)

local function Chinese()
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end

local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.Dvorak")
end

local function set_app_input_method(app_name, set_input_method_function, event)
    event = event or hs.window.filter.windowFocused

    hs.window.filter.new(app_name):subscribe(event, function()
        set_input_method_function()
    end)
end

set_app_input_method('Code', English)
set_app_input_method('iTerm2', English)
set_app_input_method('2Do', English)
set_app_input_method('Slack', Chinese)
set_app_input_method('WeChat', Chinese)
set_app_input_method('Microsoft Word', Chinese)
set_app_input_method('Firefox', English)

--   set_app_input_method('Hammerspoon', English, hs.window.filter.windowCreated)
--   set_app_input_method('Spotlight', English, hs.window.filter.windowCreated)
--   set_app_input_method('Alfred', English, hs.window.filter.windowCreated)
--   set_app_input_method('Google Chrome', English)

-- Find source id with shortcuts
-- hs.hotkey.bind({'ctrl', 'cmd'}, ".", function()
--     hs.alert.show("App path:        "
--           ..hs.window.focusedWindow():application():path()
--           .."\n"
--           .."App name:      "
--           ..hs.window.focusedWindow():application():name()
--           .."\n"
--           .."IM source id:  "
--           ..hs.keycodes.currentSourceID())
-- end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(
    os.getenv("HOME") .. "/.hammerspoon/",
    reloadConfig
):start()

hs.alert.show("Config loaded")