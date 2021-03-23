--- hammerspoon config file

function sendNotification(title, text)
   hs.notify.new({title=title,informativeText=text}):send()
end

-- Resizing windows
function initWindowsManager()

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
	    --leftWidth, rightWidth = 2, 2

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
	 {key = "f", fn = resizeWin.full}
   }, function(meta)
	 hs.hotkey.bind(winModifier, meta.key, meta.fn)
   end)

end

function switchAppByShortcut()
   -- quick switch app
   local appSwitchModifier = {"alt"}

   hs.fnutils.each({
	 {key = "1", app = "Firefox"},
	 {key = "2", app = "iTerm"},
	 {key = "3", app = "Emacs"},
	 {key = "4", app = "ForkLift"}
   }, function(meta)
	 hs.hotkey.bind(appSwitchModifier, meta.key, function()
	       hs.application.launchOrFocus(meta.app)
	 end)
   end)
   
end

function setInputMethodByApp()
   
   function setToChineseInputMethod()
      hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
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
	 {app = "Emacs", func = setToDvorakInputMethod},
	 {app = "Code", func = setToDvorakInputMethod},
	 {app = "iTerm2", func = setToDvorakInputMethod},
	 {app = "Firefox", func = setToDvorakInputMethod},

	 {app = "WeChat", func = setToChineseInputMethod}
   }, function (config)
	 hs.window.filter.new(config.app):subscribe(
	    hs.window.filter.windowFocused,
	    function() config.func() end)
   end)

end

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

function installIPCClient()
   if not hs.ipc.cliInstall() then
      sendNotification('Hammerspoon', 'fail to instal hs ipc cli')
   end
end

function watchConfigFileChange()
   function reloadConfig(files)
      doReload = false
      for _,file in pairs(files) do
	 if file:sub(-4) == ".lua" then
            doReload = true
	 end
      end
      if doReload then
	 hs.reload()
	 sendNotification('Hammerspoon', 'config reloaded')
      end
   end
   
   hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/",
      reloadConfig):start()
   
end

function main()

   -- register hotkeys to arrange multiple windows
   initWindowsManager()
   
   -- change input method by app
   setInputMethodByApp()

   -- install ipc cli
   -- for more information, follow the documention
   -- https://www.hammerspoon.org/docs/hs.ipc.html#cliInstall
   installIPCClient()

   -- auto reload config file
   -- watchConfigFileChange()

   sendNotification('Hammerspoon', 'config loaded')
end

main()


