local gears = require("gears")
local beautiful = require("beautiful")
local themes = require("themes")

local function set_wallpaper()
  local wallpaper = os.getenv("HOME") .. "/Pictures/wallpaper.jpg"
  gears.wallpaper.maximized(wallpaper)
  screen.connect_signal("property::geometry", set_wallpaper)
end

local function init()
  beautiful.init(themes.dracula)
  set_wallpaper()
end

return {
  init = init,
}
