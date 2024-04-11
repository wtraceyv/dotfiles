local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local notes_block = require("sub-components.notes_block")

--[[
	You must require this module to show note blocks.
	Generate them with the notes_block, add to container, etc.
]]--

local todo_text = [[
---------------------------

Do Not Doom
1. Insta
2. YouTube
]]

local todo_markup = [[
<span color="]] .. beautiful.colors[9] .. [[" size="large">
<span size="xx-large">
todo
</span>
]] .. todo_text .. [[
</span>
]]

local hiragana_text = [[
あいうえお
かきくけこ
さしすせそ
たちつてと
なにぬねの
はひふへほ
まみむめも
やゆよ
らりるれろ
わを
っん
]]

local hiragana_markup = [[
<span color="]] .. beautiful.colors[7] .. [[" size="x-large">
]] .. hiragana_text .. [[
</span>
]]

local katakana_text = [[
アイウエオ
カキクケコ
サシスセソ
タチツテト
ナニヌネノ
ハヒフヘホ
マミムメモ
ヤユヨ
ラリルレロ
ワヲ
]]

local katakana_markup = [[
<span color="]] .. beautiful.colors[3] .. [[" size="x-large">
]] .. katakana_text .. [[
</span>
]]

-- ====== construction ====== --

function gen_notes_container(screen_index)
	local todo_block = notes_block.gen_notes_block(todo_markup)
	local hiragana_block = notes_block.gen_notes_block(hiragana_markup)
	local katakana_block = notes_block.gen_notes_block(katakana_markup)

	local end_container = wibox({
		visible = true,
		ontop = false,
		type = "normal",
		screen = screen_index,
		height = dpi(500),
		width = dpi(1100),
		-- rounded box
		shape = helpers.rrect(10)
	})
	awful.placement.centered(end_container, { margins = dpi(10) })

	end_container:setup {
		widget = wibox.container.background,
		layout = wibox.layout.flex.horizontal,
		todo_block,
		hiragana_block,
		katakana_block
	}

	return end_container
end

local i = 1
for scr in screen do
	gen_notes_container(i)
	i = i + 1
end
