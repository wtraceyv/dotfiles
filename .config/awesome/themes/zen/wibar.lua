local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local taglist = require("themes.zen.taglist")
local tasklist = require("themes.zen.tasklist")

require("daemons.cpu")
require("daemons.ram")
require("daemons.temperature")
local cpu_bar = require("sub-components.cpu_bar")
local ram_bar = require("sub-components.ram_bar")
local temperature_bar = require("sub-components.temperature_bar")


-- Helper function that changes the appearance of progress bars and their icons
local function format_progress_bar(bar)
	-- Since we will rotate the bars 90 degrees, width and height are reversed
	bar.forced_width = dpi(70)
	bar.forced_height = dpi(30)
	bar.shape = gears.shape.rounded_bar
	bar.bar_shape = gears.shape.rectangle
	local w = wibox.widget{
			bar,
			direction = 'east',
			layout = wibox.container.rotate,
	}
	return w
end

-- ******* bunch of cpu bar thinking

local my_cpu_bar_inner = wibox.widget {
	widget = wibox.container.radialprogressbar,
	forced_width = dpi(40),
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
	layout = wibox.layout.stack
}

awesome.connect_signal("evil::cpu", function(value) 
	my_cpu_bar_inner.value = value;
end)

-- ******* END bunch of cpu bar thinking

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
			bg = "#00000088",
			{
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
					layout = wibox.layout.fixed.horizontal,
					-- format_progress_bar(cpu_bar),
					my_cpu_bar,
					-- format_progress_bar(temperature_bar),
					-- format_progress_bar(ram_bar),
					mytextclock,
					s.mylayoutbox,
				},
			}
		},
		widget = wibox.container.margin,
		top = dpi(12),
	}
end)
