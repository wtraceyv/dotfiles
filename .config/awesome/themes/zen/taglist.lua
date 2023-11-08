local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local taglist = {}

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Generate and return taglist for given screen
taglist.gen_widget = function(s)
	-- Each screen has its own tag table.
	local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
	awful.tag(tagnames, s, awful.layout.layouts[1])

	-- Create a taglist widget
	mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = function (t) return t.selected end,
		buttons = taglist_buttons
		-- For fun, I'm only showing the tag symbol I'm currently on.
		-- Replace filter with the following to get all the tags showing again
		-- filter  = awful.widget.taglist.filter.all,
	}

	return mytaglist
end


return taglist