local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

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

	local mytextclock = wibox.widget.textclock()
	-- Create the wibox
	s.mywibox = awful.wibar {
		screen = s,
		height = dpi(40),
		width = 500,
		bg = "#00000000"
	}
	-- Add widgets to the wibox
	s.mywibox:setup {
		{
			widget = wibox.container.background,
			-- TODO: use theme
			bg = "#00000088",
			{
				layout = wibox.layout.align.horizontal,
				{
					-- Left widgets (taglist)
					layout = wibox.layout.fixed.horizontal,
					taglist.gen_widget(s),

				},
				-- Middle widget (open apps)
				tasklist.gen_tasklist(s),
				{
					-- Right widgets
					layout = wibox.layout.fixed.horizontal,
					mytextclock,
					s.mylayoutbox,
				},
			}
		},
		widget = wibox.container.margin,
		top = dpi(12),
	}
end)
