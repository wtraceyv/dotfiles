local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local active_color = beautiful.temperature_bar_active_color or "#5AA3CC"
local background_color = beautiful.temperature_bar_background_color or "#222222"

local temperature_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	forced_width = dpi(30),
	border_width = dpi(4),
	color = "#AA0000",
	border_color = "#34DCE6",
	max_value = 100,
	value = 80,
}

local temperature_bar = wibox.widget {
  temperature_bar_inner,
	{
        text   = "CPU Temp",
        valign = "center",
        align = "center",
        widget = wibox.widget.textbox,
    },
	layout = wibox.layout.stack,
	spacing = 20
}

awesome.connect_signal("evil::temperature", function(value)
    temperature_bar_inner.value = value
end)

return temperature_bar
