local gears = require("gears")
local beautiful = require("beautiful")

local theme_name = "dracula"
local theme = gears.filesystem.get_configuration_dir() .. "themes/" .. theme_name .. "/theme.lua"

local wallpaper = "~/Pictures/wallpaper.jpg"

local function init()
  beautiful.init(theme)
  gears.wallpaper.maximized(wallpaper, nil)
end

return {
  init = init,
}
