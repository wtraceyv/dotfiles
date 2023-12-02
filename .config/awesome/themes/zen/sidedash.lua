local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- local mytextclock = wibox.widget.textclock()
local mytextclock = awful.widget.textclock('<span color="' .. beautiful.special_text .. '">%a %b %d, %H:%M</span>')

local function gen_button(display_text)
	local new_button = wibox.widget{
		{
			{
				markup = "<span foreground='".. beautiful.fg_focus .. "'><b>" .. display_text .. "</b></span>",
				-- markup = "<span><b>" .. display_text .. "</b></span>",
				align = "center",
				widget = wibox.widget.textbox,
			},
			widget = wibox.container.margin,
		},
		-- bg = beautiful.bg_normal,
		-- shape_border_width = 1, 
		-- shape_border_color = beautiful.fg_normal, -- outline
		shape = helpers.rrect(10), 
		widget = wibox.container.background
	}
	new_button:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_urgent_trans) end)
	new_button:connect_signal("mouse::leave", function(c) c:set_bg("#00000000") end)

	return new_button
end

local function gen_button_with_icon(icon_reference)
	local new_button = wibox.widget{
		{
			{
				{
					widget = wibox.widget.imagebox,
					image = icon_reference,
				},
				widget = wibox.container.margin,
				margins = 10
			},
			widget = wibox.container.place,
			halign = 'center'
		},
		shape = helpers.rrect(10), 
		widget = wibox.container.background,
	}
	new_button:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_urgent_trans) end)
	new_button:connect_signal("mouse::leave", function(c) c:set_bg("#00000000") end)

	return new_button
end

local file_manager_button = gen_button_with_icon(beautiful.file_icon)
local sleep_button = gen_button_with_icon(beautiful.sleep_icon)
local poweroff_button = gen_button_with_icon(beautiful.poweroff_icon)

local launch_spotify = gen_button_with_icon(beautiful.spotify_icon)
local launch_insta = gen_button_with_icon(beautiful.insta_icon)
local launch_yt = gen_button_with_icon(beautiful.youtube_icon)
local launch_server = gen_button("Launch Local Server")
local kill_server = gen_button("Kill Local Server")

file_manager_button:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("thunar &") end
end)

sleep_button:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("systemctl suspend") end
end)

poweroff_button:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("poweroff") end
end)

launch_spotify:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("chromium https://open.spotify.com &") end
end)

launch_insta:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("chromium https://instagram.com &") end
end)

launch_yt:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("chromium https://youtube.com &") end
end)

launch_server:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("~/Desktop/serve/server-start.sh &") end
end)

kill_server:connect_signal("button::press", function (c, _, _, button)
	if button == 1 then os.execute("~/Desktop/serve/server-kill.sh &") end
end)

local dash_content = wibox.widget {
	widget = wibox.container.margin,
	layout = wibox.layout.flex.vertical, -- 'flex' could be 'align'
	margins = dpi(10),
	-- TODO: use theme
	{
		widget = mytextclock,
		valign = "center",
		align = "center",
		height = dpi(10)
	},
	{
		widget = wibox.container.background,
		layout = wibox.layout.flex.horizontal,
		{
			sleep_button,
			widget = wibox.container.margin,
			margins = dpi(10)
		},
		{
			poweroff_button,
			widget = wibox.container.margin,
			margins = dpi(10),
		},
	},
	{
		widget = wibox.widget.separator,
		orientation = "horizontal",
		span_ratio = .9,
		-- color = beautiful.fg_focus,
	},
	{
		widget = wibox.container.background,
		layout = wibox.layout.flex.horizontal,
		{
			file_manager_button,
			widget = wibox.container.margin,
			margins = dpi(10)
		},
		{
			launch_spotify,
			widget = wibox.container.margin,
			margins = dpi(10)
		},
		{
			launch_insta,
			widget = wibox.container.margin,
			margins = dpi(10)
		},
		{
			launch_yt,
			widget = wibox.container.margin,
			margins = dpi(10)
		},
	},
	{
		widget = wibox.widget.separator,
		orientation = "horizontal",
		span_ratio = .9,
		-- color = beautiful.fg_focus,
	},
	{
		launch_server,
		widget = wibox.container.margin,
		margins = dpi(10)
	},
	{
		kill_server,
		widget = wibox.container.margin,
		margins = dpi(10)
	},
}

sidedash = wibox({
	visible = false, 
	ontop = true, 
	type = "normal", 
	screen = screen.primary,
	height = dpi(650),
	width = dpi(300),
	shape = helpers.rrect(10),
})
-- TODO: use theme to define what side
awful.placement.right(sidedash, { margins = beautiful.useless_gap + dpi(5) })
-- struts is a standard wm way to shorten the workarea (move clients out of way by shrinking their workarea)
sidedash:struts {
	right = dpi(300) + beautiful.useless_gap + dpi(5)
}

-- TODO: use theme for these too
-- https://github.com/elenapan/dotfiles/blob/master/config/awesome/elemental/sidebar/lovelace.lua, line 311
sidedash:setup {
	widget = wibox.container.background,
	-- bg = beautiful.bg_normal,
	layout = wibox.layout.flex.vertical,
	dash_content,
}
