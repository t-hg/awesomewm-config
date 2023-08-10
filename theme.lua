local gears = require("gears")
local beautiful = require("beautiful")

local theme_name = "dracula"
local theme = gears.filesystem.get_configuration_dir() .. "themes/" .. theme_name .. "/theme.lua"

local function set_wallpaper()
  local wallpaper = os.getenv("HOME") .. "/Pictures/wallpaper.jpg"
  gears.wallpaper.maximized(wallpaper)
  screen.connect_signal("property::geometry", set_wallpaper)
end

local function init()
  beautiful.init(theme)
  set_wallpaper()
end

return {
  init = init,
}
