local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local taglist = require("themes.zen.taglist")
local tasklist = require("themes.zen.tasklist")

require("daemons.cpu")
local cpu_bar = require("sub-components.cpu_bar")

awful.screen.connect_for_each_screen(function(s)

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))

	local mytextclock = wibox.widget.textclock()
	-- Create the wibox
	s.mywibox = awful.wibar {
		position = "top",
		screen = s,
		width = 550,
		border_width = 3
	}
	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- s.mytaglist,
			taglist.gen_widget(s),

		},
		-- s.mytasklist, -- Middle widget
		tasklist.gen_tasklist(s),
		{
			-- Right widgets
			cpu_bar,
			layout = wibox.layout.fixed.horizontal,
			mytextclock,
			s.mylayoutbox,
		},
	}
end)
