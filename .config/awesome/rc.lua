local beautiful = require("beautiful")
local awful = require("awful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.autofocus")

-- ================= handle theme choices ======================

local theme = "zen"
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/"
beautiful.init(theme_dir .. "theme.lua")

require("keybinds")
require("signals")

require("themes.zen.wibar")

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
local function set_wallpaper(s)
  -- Use wallpaper defined in theme.lua no matter what
  -- if beautiful.wallpaper then
  --     local wallpaper = beautiful.wallpaper
  --     if type(wallpaper) == "function" then
  --         wallpaper = wallpaper(s)
  --     end
  --     gears.wallpaper.maximized(wallpaper, s, true)
  -- end

  -- use feh (last set by feh)
  awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
end

screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function (s)
  set_wallpaper(s)
end)

-- ================= preferences ======================

-- Default apps
terminal = "alacritty" -- or "xfce-terminal", etc
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
editor = "vim" or os.getenv("EDITOR")
editor_cmd = terminal .. " -e " .. editor
internet_browser = "firefox-developer-edition"

-- the cover-your-ass menu
myawesomemenu = {
  { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual",      terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart",     awesome.restart },
  { "quit",        function() awesome.quit() end },
}

mymainmenu = awful.menu({
  items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
      { "open terminal", terminal }
  }
})

-- ================= set any rules ======================
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
      rule = {},
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus = awful.client.focus.filter,
          raise = true,
          keys = clientkeys,
          buttons = clientbuttons,
          screen = awful.screen.preferred,
          placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
  },

  -- Add titlebars to normal clients and dialogs
  {
      rule_any = {
          type = { "normal", "dialog" }
      },
      properties = {
          titlebars_enabled = true 
      }
  },
}

-- ================= handle catastrophic errors ======================

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end
