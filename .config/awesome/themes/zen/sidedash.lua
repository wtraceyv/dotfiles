local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
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
	},
	{
		widget = mytextclock,
		valign = "center",
		align = "center",
	},
	cpu_bar,
	temperature_bar,
	ram_bar,
}

sidedash = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
-- TODO: use theme for these too
sidedash.height = dpi(850)
sidedash.width = dpi(350)
-- TODO: use theme to define what side
-- https://github.com/elenapan/dotfiles/blob/master/config/awesome/elemental/sidebar/lovelace.lua, line 311
awful.placement.right(sidedash, { margins = dpi(45) })
sidedash.shape = helpers.rrect(10)
sidedash:setup {
	widget = wibox.container.background,
	bg = "#00000088",
	layout = wibox.layout.flex.vertical,
	dash_content,
}
