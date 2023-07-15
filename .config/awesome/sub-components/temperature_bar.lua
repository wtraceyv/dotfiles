local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local temperature = require("daemons.temperature")
local dpi = require("beautiful.xresources").apply_dpi

-- Set colors
local active_color = beautiful.temperature_bar_active_color or "#5AA3CC"
local background_color = beautiful.temperature_bar_background_color or "#222222"

local temperature_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	forced_width = dpi(30),
	border_width = dpi(4),
	border_color = "#AA0000",
	color = "#34DCE6",
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
	spacing = 20
}

awesome.connect_signal("evil::temperature", function(value)
    temperature_bar_inner.value = 100 - value
	temp_text.text = "CPU Temp " .. value .. "C"
end)

return temperature_bar
