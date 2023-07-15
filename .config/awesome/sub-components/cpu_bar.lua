local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local cpu = require("daemons.cpu")

local dpi = require("beautiful.xresources").apply_dpi

local my_cpu_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	forced_width = dpi(30),
	border_width = dpi(4),
	border_color = "#AA0000",
	color = "#34DCE6",
	max_value = 100,
	value = 50,
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
	spacing = 20
}

awesome.connect_signal("evil::cpu", function(value) 
	my_cpu_bar_inner.value = 100 - value;
	cpu_text_box.text = "CPU " .. value .. "%"
end)

return cpu_bar
