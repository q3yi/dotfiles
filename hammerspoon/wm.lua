-- resizing window with shortcuts
-- the up, down, left, right function take screen as a 6*2 grid
local WindowManager = {
    previous = { win_title = "", x = 0, y = 0, w = 6, h = 2, timestamp = 0 },
}

function WindowManager.get_prev_layout()
    local now = hs.timer.secondsSinceEpoch()
    if now - WindowManager.previous.timestamp > 10 then
        return { win_title = "", x = 0, y = 0, w = 3, h = 2, timestamp = 0 }
    end

    return WindowManager.previous
end

function WindowManager.save_prev_layout(win_title, cell)
    local prev = WindowManager.previous
    prev.win_title = win_title
    prev.x = cell.x
    prev.y = cell.y
    prev.w = cell.w
    prev.h = cell.h
    prev.timestamp = hs.timer.secondsSinceEpoch()
end

function WindowManager.set_frame(win, cell)
    local win_frame = win:frame()
    local screen_frame = win:screen():frame()

    win_frame.x = screen_frame.x + screen_frame.w * cell.x / 6
    win_frame.w = screen_frame.w * cell.w / 6
    win_frame.y = screen_frame.y + screen_frame.h * cell.y / 2
    win_frame.h = screen_frame.h * cell.h / 2

    win:setFrame(win_frame, 0)

    WindowManager.save_prev_layout(win:title(), cell)
end

function WindowManager.to_left()
    local win = hs.window.focusedWindow()
    local prev = WindowManager.get_prev_layout()
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
    WindowManager.set_frame(win, cell)
end

function WindowManager.to_right()
    local win = hs.window.focusedWindow()
    local prev = WindowManager.get_prev_layout()
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
    WindowManager.set_frame(win, cell)
end

function WindowManager.to_top()
    local win = hs.window.focusedWindow()
    local prev = WindowManager.get_prev_layout()
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
        WindowManager.save_prev_layout(win_title, cell)
    else
        WindowManager.set_frame(win, cell)
    end
end

-- to_bottom function always place current window to lower half screen
function WindowManager.to_bottom()
    local win = hs.window.focusedWindow()
    local cell = { x = 0, y = 1, w = 6, h = 2 }
    WindowManager.set_frame(win, cell)
end

function WindowManager.to_center()
    local win = hs.window.focusedWindow()
    local cell = { x = 1, y = 0, w = 4, h = 2 }
    WindowManager.set_frame(win, cell)
end

function WindowManager.setup(opts)
    hs.grid.MARGINX = 0
    hs.grid.MARGINY = 0

    if not opts.modifier then
        return
    end

    hs.hotkey.bind(opts.modifier, "Left", WindowManager.to_left)
    hs.hotkey.bind(opts.modifier, "Right", WindowManager.to_right)
    hs.hotkey.bind(opts.modifier, "Up", WindowManager.to_top)
    hs.hotkey.bind(opts.modifier, "Down", WindowManager.to_bottom)
    hs.hotkey.bind(opts.modifier, "c", WindowManager.to_center)
    hs.hotkey.bind(opts.modifier, "g", function()
        local win = hs.window.focusedWindow()
        hs.grid.setGrid({ w = 6, h = 4 }, win:screen())
        hs.grid.toggleShow()
    end)
end

return WindowManager
