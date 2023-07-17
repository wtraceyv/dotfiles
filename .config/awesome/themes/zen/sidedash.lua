local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local cpu_bar = require("sub-components.cpu_bar")
local ram_bar = require("sub-components.ram_bar")
local temperature_bar = require("sub-components.temperature_bar")
local mytextclock = wibox.widget.textclock()

local dash_content = wibox.widget {
	widget = wibox.container.margin,
	layout = wibox.layout.flex.vertical, -- 'flex' could be 'align'
	-- TODO: use theme
	{
		markup = "<span size=\"large\"><b>Dashboard</b></span>",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox,
		forced_height = dpi(20)
	},
	{
		widget = mytextclock,
		valign = "center",
		align = "center",
		height = dpi(10)
	},
	cpu_bar,
	temperature_bar,
	ram_bar,
}

sidedash = wibox({
	visible = false, 
	ontop = true, 
	type = "normal", 
	screen = screen.primary,
	height = dpi(800),
	width = dpi(350),
	shape = helpers.rrect(10),
})
-- TODO: use theme to define what side
awful.placement.right(sidedash, { margins = beautiful.useless_gap + dpi(5) })
-- struts is a standard wm way to shorten the workarea (move clients out of way by shrinking their workarea)
sidedash:struts {
	right = dpi(350) + beautiful.useless_gap + dpi(5)
}

-- TODO: use theme for these too
-- https://github.com/elenapan/dotfiles/blob/master/config/awesome/elemental/sidebar/lovelace.lua, line 311
sidedash:setup {
	widget = wibox.container.background,
	bg = beautiful.bg_normal,
	layout = wibox.layout.flex.vertical,
	dash_content,
}
