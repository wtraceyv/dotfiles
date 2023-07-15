local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local my_ram_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	border_width = dpi(4),
	color = "#AA0000",
	border_color = "#34DCE6",
	max_value = 100,
	value = 80,
}

local ram_bar = wibox.widget {
    my_ram_bar_inner,
	{
        text   = "RAM Used",
        valign = "center",
        align = "center",
        widget = wibox.widget.textbox,
    },
	layout = wibox.layout.stack,
	spacing = 20 
}

awesome.connect_signal("evil::ram", function(used)
    local used_ram_percentage = used * 100
    my_ram_bar_inner.value = used_ram_percentage
end)

return ram_bar
