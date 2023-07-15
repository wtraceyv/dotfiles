local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local cpu = require("daemons.cpu")

local dpi = require("beautiful.xresources").apply_dpi

local my_cpu_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	border_width = dpi(8),
	border_color = beautiful.cpu_bar_fill,
	color = beautiful.cpu_bar_notfill,
	max_value = 100,
	value = 0,
}

local cpu_text_box = wibox.widget {
	text   = "CPU",
	valign = "center",
	align = "center",
	widget = wibox.widget.textbox,
}
local cpu_bar = wibox.widget {
	my_cpu_bar_inner,
	cpu_text_box,
	layout = wibox.layout.stack,
	spacing = 30
}

awesome.connect_signal("evil::cpu", function(value) 
	my_cpu_bar_inner.value = 100 - value;
	cpu_text_box.text = "CPU " .. value .. "%"
end)

return cpu_bar
