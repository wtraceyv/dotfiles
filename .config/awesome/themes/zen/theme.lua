local theme = {}
theme.wallpaper = '~/.wallpapers/GhibliForest.jpg'

local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/zen/icons/"
dpi = require("beautiful.xresources").apply_dpi

theme.tagnames = {"一", "二", "三", "四", "五", "六", "七", "八", "九"}

theme.useless_gap = dpi(8)
theme.wibar_margins = { dpi(30) }

theme.font      = "Ubuntu Mono derivative Powerline 12"
--theme.font      = "Noto Mono for Powerline 11"

-- some specific colors I like:
-- darks
local dark_trans_bg = "#000000bb"

-- blue/putp
local sexy_magenta = "#cd23b9"
local deep_pink = "#ff1493"
local sexy_focus_blue = "#22e5f7"
local sexy_unfocus_blue = "#68B3B0"
local sexy_rofi_purp = "#A05EB5"

-- aliz red
local aliz_red = "#f0544c"
local aliz_red_dim = "#8C312C"
local aliz_dark = "#1a1a1a88"
local aliz_bg_focus = "#393939"

-- greeny
local tokyo_green = "#26A98B"
local tokyo_green_dim = "#114A3D"
local old_dark_green = "#1e2320"

-- tokyonight
-- https://github.com/enkia/tokyo-night-vscode-theme
local tokyonightstorm_bg = "#24283b"
local tokyonightstorm_bg_trans = "#24283bdd"
local tokyonightstorm_1 = "#f7768e"
local tokyonightstorm_2 = "#ff9e64"
local tokyonightstorm_3 = "#e0af68"
local tokyonightstorm_4 = "#9ece6a"
local tokyonightstorm_5 = "#73daca"
local tokyonightstorm_6 = "#b4f9f8"
local tokyonightstorm_7 = "#2ac3de"
local tokyonightstorm_8 = "#7dcfff"
local tokyonightstorm_9 = "#7aa2f7"
local tokyonightstorm_10 = "#bb9af7"
local tokyonightstorm_11 = "#c0caf5"
local tokyonightstorm_12 = "#a9b1d6"
local tokyonightstorm_13 = "#9aa5ce"
local tokyonightstorm_14 = "#cfc9c2"
local tokyonightstorm_15 = "#565f89"
local tokyonightstorm_16 = "#414868"

-- general 
theme.fg_normal  = "#f7f7f7"

theme.special_text = tokyonightstorm_5

theme.fg_focus   = tokyonightstorm_1
theme.fg_focus_dim = tokyonightstorm_9
theme.fg_urgent  = "#fc4949"

theme.bg_normal = tokyonightstorm_bg_trans
theme.bg_focus   = aliz_dark
theme.bg_urgent  = "#3F3F3F"
theme.bg_urgent_trans  = tokyonightstorm_10 .. "77"
theme.bg_systray = theme.bg_normal

theme.border_focus  = tokyonightstorm_1
theme.border_width  = dpi(0)
theme.border_normal = "#00000000"
theme.border_marked = "#CC9393"

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
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"


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
