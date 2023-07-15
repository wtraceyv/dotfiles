-- https://github.com/elenapan/dotfiles/tree/master/config/awesome

-- Provides:
-- evil::temperature
--      temperature (integer - in Celcius)
local awful = require("awful")

local update_interval = 5
local temp_script = [[
  sh -c "
    sensors | grep Tctl | tr -d \" \" | cut -d"+" -f2 | cut -c -2
  "]]

-- Periodically get temperature info
awful.widget.watch(temp_script, update_interval, function(widget, stdout)
    awesome.emit_signal("evil::temperature", tonumber(stdout))
end)
