local gears = require("gears")
local beautiful = require("beautiful")

local theme_name = "default"
local theme = gears.filesystem.get_configuration_dir() .. "themes/" .. theme_name .. "/theme.lua"

local function init()
  beautiful.init(theme)
end

return {
  init = init,
}
