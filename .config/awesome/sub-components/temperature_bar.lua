local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local temperature = require("daemons.temperature")
local dpi = require("beautiful.xresources").apply_dpi

local temperature_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	border_width = dpi(8),
	border_color = beautiful.temp_bar_fill,
	color = beautiful.temp_bar_notfill,
	max_value = 100,
	value = 50,
}

local temp_text = wibox.widget {
	text   = "CPU Temp",
	valign = "center",
	align = "center",
	widget = wibox.widget.textbox,
}

local temperature_bar = wibox.widget {
  	temperature_bar_inner,
	temp_text,
	layout = wibox.layout.stack,
	spacing = 30
}

awesome.connect_signal("evil::temperature", function(value)
    temperature_bar_inner.value = 100 - value
	temp_text.text = "CPU Temp " .. value .. "C"
end)

return temperature_bar
