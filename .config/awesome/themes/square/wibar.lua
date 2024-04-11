local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local taglist = require("themes.square.taglist")
local tasklist = require("themes.square.tasklist")

------------------------
-- If don't have awesomewm-ip-capture script, add to somewhere in path:
--[[
#!/bin/bash

ip -o -4 addr list wlo1 | awk '{print $4}' | cut -d/ -f1
--]]

local ip_cmd = [[
bash -c "
awesomewm-ip-capture
"]]
local ip_run = io.popen(ip_cmd)
local ip = ip_run:read("*a")

awful.screen.connect_for_each_screen(function(s)

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))

	local mytextclock = wibox.widget {
		widget = wibox.widget.textclock,
		format = '<span color="' .. beautiful.special_text .. '">%a %m/%d %H:%M  </span>',
		align = "right",
	}

	-- Create the wibox
	local temp_wibox = awful.wibox {
		screen = s,
		type = "normal",
		ontop = false,
		height = dpi(32),
		bg = beautiful.bg_normal,
	}
	awful.placement.top(temp_wibox, { margins = 0 })

	s.mywibox = temp_wibox
	s.mywibox:setup {
		{
			widget = wibox.container.background,
			{
				layout = wibox.layout.flex.horizontal,
				taglist.gen_widget(s),
				tasklist.gen_tasklist(s),
				mytextclock
			}
		},
		widget = wibox.container.margin,
	}
end)
