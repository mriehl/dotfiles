local application = hs.application
local alert = hs.alert
local window = hs.window
local fnutils = hs.fnutils
local hotkey = hs.hotkey
local hints = hs.hints

local grid = hs.grid
grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDWIDTH = 2
grid.GRIDHEIGHT = 2

local prefix = {"ctrl", "shift"}

local snapCurrentWindowToGrid = function(x, y, w, h)
    return callBackWithWindow(function(cur_window)
        grid.set(
            cur_window,
            {x=x, y=y, w=w, h=h},
            cur_window:screen()
        )
     end)
end

function spawnAndCaptureStdout(command, raw)
  local f = assert(io.popen(command, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function callBackWithWindow(callback)
    return function()
            current_window = window.focusedWindow()
            if current_window then
                callback(current_window)
            else
                notifyNative("No current window!")
            end
    end
end

function notifyNative(text)
   hs.notify.new({title="Hammerspoon", informativeText=text}):send()
end

local function center(window)
  frame = window:screen():frame()
  frame.x = (frame.w / 2) - (frame.w / 4)
  frame.y = (frame.h / 2) - (frame.h / 4)
  frame.w = frame.w / 2
  frame.h = frame.h / 2
  window:setframe(frame)
end


hotkey.bind(prefix, "R", function()
          hs.reload()
          notifyNative("Config reloaded!")
        end)


-- Tiling
--
hotkey.bind(prefix, 'B', snapCurrentWindowToGrid(0, 1, 1, 1)) -- low left
hotkey.bind(prefix, 'C', snapCurrentWindowToGrid(1, 1, 1, 1)) -- low right
hotkey.bind(prefix, 'Q', snapCurrentWindowToGrid(0, 0, 1, 1)) -- upper left
hotkey.bind(prefix, 'E', snapCurrentWindowToGrid(1, 0, 1, 1)) -- upper right
hotkey.bind(prefix, 'A', snapCurrentWindowToGrid(0, 0, 1, 2)) -- full left
hotkey.bind(prefix, 'D', snapCurrentWindowToGrid(1, 0, 1, 2)) -- full right
hotkey.bind(prefix, 'W', snapCurrentWindowToGrid(0, 0, 2, 1)) -- full upper
hotkey.bind(prefix, 'X', snapCurrentWindowToGrid(0, 1, 2, 1)) -- full lower
hotkey.bind(prefix, 'S', callBackWithWindow(function(_)
    grid.maximizeWindow()
end))


-- Navigation
hotkey.bind(prefix, "H", callBackWithWindow(function(cur_window)
    cur_window:focusWindowWest()
end))
hotkey.bind(prefix, "J", callBackWithWindow(function(cur_window)
    cur_window:focusWindowSouth()
end))
hotkey.bind(prefix, "K", callBackWithWindow(function(cur_window)
    cur_window:focusWindowNorth()
end))
hotkey.bind(prefix, "L", callBackWithWindow(function(cur_window)
    cur_window:focusWindowEast()
end))

hotkey.bind(prefix, "F", hints.windowHints)
