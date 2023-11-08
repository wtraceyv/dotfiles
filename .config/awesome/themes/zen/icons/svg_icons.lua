local svg_icons = {}

-- want icons to come from fontawesome

svg_icons.power =
'<?xml version="1.0" encoding="UTF-8" standalone="no"?>'..
'<svg height="50" width="50"' ..
	'viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->' ..
	'<path' ..
		'd="M288 32c0-17.7-14.3-32-32-32s-32 14.3-32 32V256c0 17.7 14.3 32 32 32s32-14.3 32-32V32zM143.5 120.6c13.6-11.3 15.4-31.5 4.1-45.1s-31.5-15.4-45.1-4.1C49.7 115.4 16 181.8 16 256c0 132.5 107.5 240 240 240s240-107.5 240-240c0-74.2-33.8-140.6-86.6-184.6c-13.6-11.3-33.8-9.4-45.1 4.1s-9.4 33.8 4.1 45.1c38.9 32.3 63.5 81 63.5 135.4c0 97.2-78.8 176-176 176s-176-78.8-176-176c0-54.4 24.7-103.1 63.5-135.4z" />' ..
'</svg>'

svg_icons.example = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'..
'<svg width="190" height="60">'..
	'<rect x="10"  y="10" width="50" height="50" />'..
	'<rect x="70"  y="10" width="50" height="50" class="my_class" />'..
	'<rect x="130" y="10" width="50" height="50" id="my_id" />'..
'</svg>'

return svg_icons