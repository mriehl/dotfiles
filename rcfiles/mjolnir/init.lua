local application = require "mjolnir.application"
local alert = require "mjolnir.alert"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local hotkey = require "mjolnir.hotkey"
local hints = require "mjolnir.th.hints"

local grid = require "mjolnir.sd.grid"
grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDWIDTH = 2
grid.GRIDHEIGHT = 2

local prefix = {"ctrl", "shift"}

local gridset = function(x, y, w, h)
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

hotkey.bind(prefix, "R", function()
          mjolnir.reload()
          alert.show("Mjolnir config reload successful!")
        end)


-- Tiling
--
hotkey.bind(prefix, 'Y', gridset(0, 1, 1, 1)) -- low left
hotkey.bind(prefix, 'C', gridset(1, 1, 1, 1)) -- low right
hotkey.bind(prefix, 'Q', gridset(0, 0, 1, 1)) -- upper left
hotkey.bind(prefix, 'E', gridset(1, 0, 1, 1)) -- upper right
hotkey.bind(prefix, 'A', gridset(0, 0, 1, 2)) -- full left
hotkey.bind(prefix, 'D', gridset(1, 0, 1, 2)) -- full right
hotkey.bind(prefix, 'W', gridset(0, 0, 2, 1)) -- full upper
hotkey.bind(prefix, 'X', gridset(0, 1, 2, 1)) -- full lower
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

hotkey.bind(prefix, "I", callBackWithWindow(function(cur_window)
    cur_app = cur_window:application()
    if cur_app then
        cur_app:hide()
    else
        alert.show("No current app!")
    end
end))

hotkey.bind(prefix, "F", hints.windowHints)

