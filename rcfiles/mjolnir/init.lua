local application = require "mjolnir.application"
local alert = require "mjolnir.alert"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local hotkey = require "mjolnir.hotkey"
local hints = require "mjolnir.th.hints"
local tiling = require "mjolnir.tiling"

local grid = require "mjolnir.sd.grid"
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
            current_window = window.focusedwindow()
            if current_window then
                callback(current_window)
            else
                alert.show("No current window!")
            end
    end
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
          mjolnir.reload()
          alert.show("Mjolnir config reload successful!")
        end)


-- Tiling
--
hotkey.bind(prefix, 'Y', snapCurrentWindowToGrid(0, 1, 1, 1)) -- low left
hotkey.bind(prefix, 'C', snapCurrentWindowToGrid(1, 1, 1, 1)) -- low right
hotkey.bind(prefix, 'Q', snapCurrentWindowToGrid(0, 0, 1, 1)) -- upper left
hotkey.bind(prefix, 'E', snapCurrentWindowToGrid(1, 0, 1, 1)) -- upper right
hotkey.bind(prefix, 'A', snapCurrentWindowToGrid(0, 0, 1, 2)) -- full left
hotkey.bind(prefix, 'D', snapCurrentWindowToGrid(1, 0, 1, 2)) -- full right
hotkey.bind(prefix, 'W', snapCurrentWindowToGrid(0, 0, 2, 1)) -- full upper
hotkey.bind(prefix, 'X', snapCurrentWindowToGrid(0, 1, 2, 1)) -- full lower
hotkey.bind(prefix, 'S', callBackWithWindow(function(_)
    grid.maximize_window()
end))


-- Navigation
hotkey.bind(prefix, "H", callBackWithWindow(function(cur_window)
    cur_window:focuswindow_west()
end))
hotkey.bind(prefix, "J", callBackWithWindow(function(cur_window)
    cur_window:focuswindow_south()
end))
hotkey.bind(prefix, "K", callBackWithWindow(function(cur_window)
    cur_window:focuswindow_north()
end))
hotkey.bind(prefix, "L", callBackWithWindow(function(cur_window)
    cur_window:focuswindow_east()
end))

hotkey.bind(prefix, "F", hints.windowHints)


-- Automatic tiling
hotkey.bind(prefix, "I", function() tiling.cyclelayout() end)
hotkey.bind(prefix, "T", function() tiling.togglefloat(center) end)
hotkey.bind(prefix, "U", function() tiling.cycle(1) end)
hotkey.bind(prefix, "O", function() tiling.cycle(-1) end)
hotkey.bind(prefix, "space", function() tiling.promote() end)


tiling.set('layouts', {
  'main-horizontal', 'main-vertical', 'gp-vertical', 'gp-horizontal'
})
