--[[

  Copyright 2017 Stefano Mazzucco <stefano AT curso DOT re>

  This program is free software: you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free Software
  Foundation, either version 3 of the License, or (at your option) any later
  version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  You should have received a copy of the GNU General Public License along with
  this program.  If not, see <https://www.gnu.org/licenses/gpl-3.0.html>.

]]

--[[
  A simple widget to show whether num Lock is active.
  Requirements:
  - Awesome 4.x
  - xset

  @usage
  numlock = require("numlock")
  -- Add widget to wibox
  s.mywibox:setup {
  layout = wibox.layout.align.horizontal,
  { -- Left widgets
    layout = wibox.layout.fixed.horizontal,
    numlock
  }
  -- more stuff
  }
  -- Add key to globalkeys
  globalkeys = awful.util.table.join(globalkeys, numlock.key)

]]

local awful = require("awful")
local wibox = require("wibox")

local numlock = wibox.widget {
  widget = wibox.widget.textbox,
  align = "center",
  valign = "center",
  --forced_width = 15,
}

numlock.activated = "<b>+numlock</b>"
numlock.deactivated = "<b>-numlock</b>"

local tooltip = awful.tooltip({})

tooltip:add_to_object(numlock)

function numlock:check()
  awful.spawn.with_line_callback(
    "bash -c 'sleep 0.2 && xset q'",
    {
      stdout = function (line)
        if line:match("Num Lock") then
          local status = line:gsub(".*(Num Lock:%s+)(%a+).*", "%2")
          tooltip.text = "Num Lock " .. status
          if status == "on" then
            self.markup = self.activated
          else
            self.markup = self.deactivated
          end
        end
      end
    }
  )
end

numlock.key = awful.key(
  {},
  "Num_Lock",
  function () numlock:check() end)

numlock:check()

return numlock
