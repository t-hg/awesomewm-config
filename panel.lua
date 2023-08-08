local awful = require("awful")
local beautiful = require("beautiful")
local button_bindings = require("button_bindings")
local wibox = require("wibox")
local ip = require("panel_widgets.ip")

local bars = {}

local function create(screen)
  local taglist = awful.widget.taglist({
    screen = screen,
    filter = awful.widget.taglist.filter.all,
    buttons = button_bindings.taglist_button_bindings,
    widget_template = {
      {
        {
          id = "text_role",
          widget = wibox.widget.textbox,
        },
        left = 7,
        right = 7,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })

  local tasklist = awful.widget.tasklist({
    screen = screen,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = button_bindings.tasklist_button_bindings,
    widget_template = {
      {
        {
          id = "text_role",
          widget = wibox.widget.textbox,
        },
        left = 7,
        right = 7,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })

  local textclock = wibox.widget.textclock()

  local bar = awful.wibar({
    position = "top",
    ontop = true,
    screen = screen,
    height = beautiful.panel_height,
  })

  bar:setup({
    {
      taglist,
      layout = wibox.layout.align.horizontal,
    },
    tasklist,
    {
      ip,
      textclock,
      layout = wibox.layout.align.horizontal,
    },
    layout = wibox.layout.align.horizontal,
  })

  bars[screen] = bar
end

local function show(screen)
  local bar = bars[screen]
  if bar then
    bar.visible = true
  end
end

local function hide(screen)
  local bar = bars[screen]
  if bar then
    bar.visible = false
  end
end

local function toggle(screen)
  local bar = bars[screen]
  if bar then
    if bar.visible == true then
      hide(screen)
    else
      show(screen)
    end
  end
end

local function is_visible(screen)
  local bar = bars[screen]
  if bar then
    return bar.visible
  end
  return false
end

local function init()
  awful.screen.connect_for_each_screen(create)
end

return {
  init = init,
  show = show,
  hide = hide,
  toggle = toggle,
  is_visible = is_visible,
}
