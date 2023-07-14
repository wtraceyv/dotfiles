local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")

require("daemons.cpu")
require("daemons.ram")
require("daemons.temperature")

local my_cpu_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	forced_width = dpi(30),
	border_width = dpi(4),
	color = "#AA0000",
	border_color = "#34DCE6",
	max_value = 100,
	value = 50,
}

local my_cpu_bar = wibox.widget {
	my_cpu_bar_inner,
	{
        text   = "CPU",
        valign = "center",
        align = "center",
        widget = wibox.widget.textbox,
    },
	layout = wibox.layout.stack,
	spacing = 2
}

awesome.connect_signal("evil::cpu", function(value) 
	my_cpu_bar_inner.value = value;
end)

local dash_content = wibox.widget {
	widget = wibox.container.margin,
	right = dpi(10),
	layout = wibox.layout.flex.vertical, -- 'flex' could be 'align'
	-- TODO: use theme
	{
		text   = "CPU",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
	},
	{
		text   = "Temp",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
	},
	{
		text   = "RAM",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
	},
	{
		text   = "Network",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
	},
	{
		text   = "YouTube search",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
	},
	{
		text   = "Wikipedia search",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
	},
}

sidedash = wibox({visible = true, ontop = true, type = "dock", screen = screen.primary})
-- TODO: use theme for these too
sidedash.height = dpi(850)
sidedash.width = dpi(350)
-- TODO: use theme to define what side
-- https://github.com/elenapan/dotfiles/blob/master/config/awesome/elemental/sidebar/lovelace.lua, line 311
awful.placement.right(sidedash, { margins = dpi(15) })
sidedash.shape = helpers.rrect(10)
sidedash:setup {
	widget = wibox.container.background,
	bg = "#00000088",
	layout = wibox.layout.flex.vertical,
	dash_content,
}
