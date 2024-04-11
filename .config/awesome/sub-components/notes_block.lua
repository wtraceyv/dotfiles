local wibox = require("wibox")

local notes_block_helper = {}

--[[
	Generate a generic block of notes with markup inside,
	which you can generate several of, and display them from notes_container.
]]--

function notes_block_helper.gen_notes_block(markup_to_show)
	local note_content = wibox.widget {
		widget = wibox.container.margin,
		layout = wibox.layout.flex.vertical,
		margins = dpi(1),
		{
			widget = wibox.widget.textbox,
			markup = markup_to_show,
			align = "center",
		}
	}

	return note_content
end

-- returning module
return notes_block_helper