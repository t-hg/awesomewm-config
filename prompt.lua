local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local panel = require("panel")

local bars = {}

local function create(screen)
  local bar = awful.wibar({
    position = "top",
    ontop = true,
    screen = screen,
    height = beautiful.panel_height,
    visible = false,
  })

  bar.prompt_text = wibox.widget({
    widget = wibox.container.background,
    bg = beautiful.bg_focus,
    fg = beautiful.fg_focus,
    {
      widget = wibox.container.margin,
      left = 10,
      right = 5,
      {
        widget = wibox.widget.textbox,
        text = "",
      },
    },
  })

  bar.prompt_input = wibox.widget({
    widget = wibox.container.margin,
    left = 5,
    right = 10,
    awful.widget.prompt(),
  })

  bar:setup({
    bar.prompt_text,
    bar.prompt_input,
    layout = wibox.layout.align.horizontal,
  })

  bars[screen] = bar
end

local function show(screen)
  local bar = bars[screen]
  if bar then
    bar.visible = true
    panel.hide(screen)
  end
end

local function hide(screen)
  local bar = bars[screen]
  if bar then
    bar.visible = false
    panel.show(screen)
  end
end

local function run(args)
  local screen = awful.screen.focused()
  local bar = bars[screen]
  if not bar then
    return
  end
  local run_args = {}
  bar.prompt_text.widget.widget.text = args.prompt
  run_args.text = args.text
  run_args.textbox = bar.prompt_input.widget.widget
  run_args.done_callback = function()
    hide(screen)
  end
  run_args.bg_cursor = beautiful.fg_normal
  run_args.fg_cursor = beautiful.bg_normal
  run_args.exe_callback = args.exe_callback
  run_args.selectall = args.selectall
  awful.prompt.run(run_args)
  show(screen)
end

local function init()
  awful.screen.connect_for_each_screen(create)
end

return {
  init = init,
  show = show,
  hide = hide,
  run = run,
}
