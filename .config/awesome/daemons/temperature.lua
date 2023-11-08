-- https://github.com/elenapan/dotfiles/tree/master/config/awesome

local awful = require("awful")

local update_interval = 8 
local temp_script = [[
  sh -c "
  sensors -u | grep temp1_input | tr -d ' ' | cut -d ':' -f2 | head -n 1
  "]]

-- Periodically get temperature info
awful.widget.watch(temp_script, update_interval, function(widget, stdout)
    awesome.emit_signal("evil::temperature", tonumber(stdout))
end)