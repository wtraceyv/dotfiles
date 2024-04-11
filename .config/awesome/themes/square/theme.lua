local theme = {}
local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/zen/icons/"
dpi = require("beautiful.xresources").apply_dpi

local color_theme = "tokyonightstorm"
local colors = require('themes.colors.' .. color_theme)

theme.tagnames = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

theme.useless_gap = 0
theme.wibar_margins = { dpi(30) }
theme.font      = "Ubuntu Mono derivative Powerline 12"
theme.wallpaper = '~/.wallpapers/GhibliForest.jpg'

local aliz_dark = "#1a1a1a88"

-- general 
theme.colors = colors

theme.fg_normal  = "#f7f7f7"

theme.special_text = colors[4]

theme.fg_focus   = colors[0]
theme.fg_focus_dim = colors[8]
theme.fg_urgent  = colors[4]

theme.bg_normal = colors.bg_trans
-- theme.bg_normal = colors.bg_trans
theme.bg_focus   = colors.bg_trans
theme.bg_urgent  = colors[2]
theme.bg_urgent_trans  = colors[9] .. "77"
theme.bg_systray = colors[8]

theme.border_focus  = colors[0]
theme.border_width  = dpi(3)
theme.border_normal = colors.bg_trans
theme.border_marked = colors[1]

-- titlebar
theme.titlebar_bg_focus  = aliz_dark
theme.titlebar_bg_normal = aliz_dark

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(30)
theme.menu_width  = dpi(175)

-- {{{ Icons
theme.taglist_squares_sel   = themes_path .. "taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "taglist/squarez.png"

-- {{{ Misc (custom me)
theme.awesome_icon      = themes_path .. "awesome-icon.png"
theme.menu_submenu_icon = themes_path .. "default/submenu.png"

theme.poweroff_icon		= themes_path .. "extra/power-off-solid.png"
theme.sleep_icon		= themes_path .. "extra/moon-solid.png"
theme.lock_icon			= themes_path .. "extra/lock-solid.png"
theme.spotify_icon		= themes_path .. "extra/spotify.png"
theme.insta_icon		= themes_path .. "extra/instagram.png"
theme.youtube_icon		= themes_path .. "extra/youtube.png"
theme.file_icon			= themes_path .. "extra/file-solid.png"

-- {{{ Layout
theme.layout_tile       = themes_path .. "layouts/tile.png"
theme.layout_tileleft   = themes_path .. "layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "layouts/fairv.png"
theme.layout_fairh      = themes_path .. "layouts/fairh.png"
theme.layout_spiral     = themes_path .. "layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "layouts/dwindle.png"
theme.layout_max        = themes_path .. "layouts/max.png"
theme.layout_fullscreen = themes_path .. "layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "layouts/magnifier.png"
theme.layout_floating   = themes_path .. "layouts/floating.png"
theme.layout_cornernw   = themes_path .. "layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "layouts/cornerse.png"

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "titlebar/maximized_normal_inactive.png"

return theme
