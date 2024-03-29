local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local taglist = require("themes.zen.taglist")
local tasklist = require("themes.zen.tasklist")

awful.screen.connect_for_each_screen(function(s)

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))

	local mytextclock = awful.widget.textclock('<span color="' .. beautiful.special_text .. '">%a %m/%d %H:%M</span>')

	-- Create the wibox
	local temp_wibox = awful.wibox {
		screen = s,
		type = "normal",
		ontop = false,
		height = dpi(32),
		width = 170,
		shape = helpers.rrect(8),
		bg = "#00000000",
		margins = dpi(10),
	}
	awful.placement.top(temp_wibox, { margins = dpi(6) })
	-- temp_wibox:struts {
	-- 	top = dpi(40)
	-- }

	s.mywibox = temp_wibox
	-- Add widgets to the wibox
	s.mywibox:setup {
		{
			widget = wibox.container.background,
			-- TODO: use theme
			bg = "#00000033",
			{
				layout = wibox.layout.align.horizontal,
				{
					-- Left widgets (taglist)
					layout = wibox.layout.fixed.horizontal,
					spacing = dpi(15),
					taglist.gen_widget(s),
					mytextclock,
				},
				-- Middle widget (open apps)
				-- tasklist.gen_tasklist(s),
				-- {
				-- 	-- Right widgets
				-- 	layout = wibox.layout.fixed.horizontal,
				-- 	mytextclock,
				-- 	-- s.mylayoutbox,
				-- },
			}
		},
		widget = wibox.container.margin,
	}
end)
