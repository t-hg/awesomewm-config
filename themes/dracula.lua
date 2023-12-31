local beautiful = require("beautiful")

local accent_color = "#614D6B"
local bg_normal = "#282C34"
local fg_normal = "#F8F8F2"

local taglist_square_size = beautiful.xresources.apply_dpi(5)
local taglist_squares_sel = beautiful.theme_assets.taglist_squares_sel(taglist_square_size, fg_normal)
local taglist_squares_unsel = beautiful.theme_assets.taglist_squares_unsel(taglist_square_size, fg_normal)
local taglist_squares_urgent = beautiful.theme_assets.taglist_squares_sel(taglist_square_size, bg_normal)

local font = "Iosevka Nerd Font Mono"
local font_size = 12

return {
  bg_focus = accent_color,
  bg_normal = bg_normal,
  bg_urgent = fg_normal,
  bg_systray = bg_normal,
  border_focus = accent_color,
  border_normal = bg_normal,
  border_width = 2,
  dmenu_params = { "-i", "-p", "Run:", "-fn", "'" .. font .. ":" .. font_size .. "'", "-sb", "'" .. accent_color .. "'" },
  fg_focus = fg_normal,
  fg_normal = fg_normal,
  fg_urgent = bg_normal,
  font = font .. " " .. font_size,
  panel_height = 23,
  taglist_squares_sel = taglist_squares_sel,
  taglist_squares_unsel = taglist_squares_unsel,
  taglist_squares_urgent = taglist_squares_urgent,
  useless_gap = 4,
}
