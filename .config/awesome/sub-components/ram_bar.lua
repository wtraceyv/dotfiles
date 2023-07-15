local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local ram = require("daemons.ram")

local my_ram_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	border_width = dpi(8),
	border_color = beautiful.ram_bar_fill,
	color = beautiful.ram_bar_notfill,
	max_value = 100,
	value = 0,
}

local ram_string = "RAM 0%"
local ram_textbox = wibox.widget {
	text   = ram_string,
	valign = "center",
	align = "center",
	widget = wibox.widget.textbox,
}

local ram_bar = wibox.widget {
    my_ram_bar_inner,
	ram_textbox,
	layout = wibox.layout.stack,
	spacing = 30 
}

awesome.connect_signal("evil::ram", function(used)
    local used_ram_percentage = used * 100
    my_ram_bar_inner.value = 100 - used_ram_percentage
	ram_textbox.text = "RAM " .. used_ram_percentage .. "% Used"
end)

return ram_bar
