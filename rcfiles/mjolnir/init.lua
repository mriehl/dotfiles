local application = require "mjolnir.application"
local alert = require "mjolnir.alert"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local hotkey = require "mjolnir.hotkey"

local grid = require "mjolnir.sd.grid"
grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDWIDTH = 2
grid.GRIDHEIGHT = 2

local prefix = {"ctrl", "shift"}

local focus = function(w, s, n, e)
   return function()
       cur_window = window:focusedwindow()
       if w then cur_window:focuswindow_west() end
       if s then cur_window:focuswindow_south() end
       if n then cur_window:focuswindow_north() end
       if e then cur_window:focuswindow_east() end
   end
end

local gridset = function(x, y, w, h)
    return function()
        cur_window = window.focusedwindow()
        grid.set(
            cur_window,
            {x=x, y=y, w=w, h=h},
            cur_window:screen()
        )
    end
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

hotkey.bind(prefix, "R", function()
          mjolnir.reload()
          alert.show("Mjolnir config reload successful!")
        end)

-- Tiling
--
hotkey.bind(prefix, 'N', grid.pushwindow_nextscreen)
hotkey.bind(prefix, 'Y', gridset(0, 1, 1, 1)) -- low left
hotkey.bind(prefix, 'X', gridset(1, 1, 1, 1)) -- low right
hotkey.bind(prefix, 'Q', gridset(0, 0, 1, 1)) -- upper left
hotkey.bind(prefix, 'W', gridset(1, 0, 1, 1)) -- upper right
hotkey.bind(prefix, 'A', gridset(0, 0, 1, 2)) -- full left half
hotkey.bind(prefix, 'D', gridset(1, 0, 1, 2)) -- full right half
hotkey.bind(prefix, 'S', grid.maximize_window)

-- Navigation
--
hotkey.bind(prefix, "H", focus(true))
hotkey.bind(prefix, "J", focus(nil, true))
hotkey.bind(prefix, "K", focus(nil, nil, true))
hotkey.bind(prefix, "L", focus(nil, nil, nil, true))
