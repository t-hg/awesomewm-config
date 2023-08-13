local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local tags = require("tags")
local panel = require("panel")
local layouts = require("layouts")

local terminal_emulator = "alacritty"

local function launcher()
  local screen = mouse.screen.index - 1
  local dmenu = gears.table.join({ "dmenu", "-m", tostring(screen) }, beautiful.dmenu_params)

  local command = gears.table.join({
    "j4-dmenu-desktop",
    "--dmenu",
    table.concat(dmenu, " "),
    "--term",
    terminal_emulator,
  })

  awful.spawn(command, false)
end

local function focus_previous_client()
  local client_to_focus = awful.client.focus.history.list[2]

  if not client_to_focus then
    return
  end

  client.focus = client_to_focus
  local tag = client.focus and client.focus.first_tag or nil

  if tag then
    tag:view_only()
  end

  client_to_focus:raise()
end

local function move_client_x(i)
  local c = client.focus

  if c.floating then
    c.x = c.x + i
  end
end

local function move_client_y(i)
  local c = client.focus

  if c.floating then
    c.y = c.y + i
  end
end

local function resize_client_width(i)
  local c = client.focus

  if c.floating then
    c.width = c.width + i
  end
end

local function resize_client_height(i)
  local c = client.focus

  if c.floating then
    c.height = c.height + i
  end
end

local global_key_bindings = gears.table.join(
  awful.key({ "Mod1" }, "Left", function()
    move_client_x(-50)
  end),
  awful.key({ "Mod1" }, "Down", function()
    move_client_y(50)
  end),
  awful.key({ "Mod1" }, "Up", function()
    move_client_y(-50)
  end),
  awful.key({ "Mod1" }, "Right", function()
    move_client_x(50)
  end),
  awful.key({ "Mod1", "Shift" }, "Left", function()
    resize_client_width(-50)
  end),
  awful.key({ "Mod1", "Shift" }, "Down", function()
    resize_client_height(50)
  end),
  awful.key({ "Mod1", "Shift" }, "Up", function()
    resize_client_height(-50)
  end),
  awful.key({ "Mod1", "Shift" }, "Right", function()
    resize_client_width(50)
  end),
  awful.key({ "Mod1" }, "h", function()
    awful.tag.incmwfact(-0.05)
  end),
  awful.key({ "Mod1" }, "j", function()
    awful.client.focus.byidx(1)
  end),
  awful.key({ "Mod1" }, "k", function()
    awful.client.focus.byidx(-1)
  end),
  awful.key({ "Mod1" }, "l", function()
    awful.tag.incmwfact(0.05)
  end),
  awful.key({ "Mod1", "Shift" }, "h", function()
    awful.client.incwfact(-0.05)
  end),
  awful.key({ "Mod1", "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end),
  awful.key({ "Mod1", "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end),
  awful.key({ "Mod1", "Shift" }, "l", function()
    awful.client.incwfact(0.05)
  end),
  awful.key({ "Mod1" }, "space", launcher),
  awful.key({ "Mod1" }, "Return", function()
    awful.spawn(terminal_emulator, false)
  end),
  awful.key({ "Mod1" }, "i", function()
    awful.tag.incnmaster(1, nil, true)
  end),
  awful.key({ "Mod1" }, "d", function()
    awful.tag.incnmaster(-1, nil, true)
  end),
  awful.key({ "Mod1", "Shift" }, "i", function()
    awful.tag.incncol(1, nil, true)
  end),
  awful.key({ "Mod1", "Shift" }, "d", function()
    awful.tag.incncol(-1, nil, true)
  end),
  awful.key({ "Mod1", "Shift" }, "space", awful.client.floating.toggle),
  awful.key({ "Mod1" }, "Escape", function()
    awful.spawn("slock", false)
  end),
  awful.key({ "Mod1", "Shift" }, "Escape", awesome.quit),
  awful.key({ "Mod1" }, "Tab", focus_previous_client),
  awful.key({ "Mod1" }, ",", function()
    awful.screen.focus_relative(-1)
  end),
  awful.key({ "Mod1" }, ".", function()
    awful.screen.focus_relative(1)
  end),
  awful.key({ "Mod1" }, "r", tags.rename_selected),
  awful.key({ "Mod1", "Shift" }, "r", function()
    awful.spawn({ "awesome-client", "awesome.restart()" }, false)
  end),
  awful.key({ "Mod1" }, "p", function()
    panel.toggle(awful.screen.focused())
  end),
  awful.key({ "Mod1" }, "m", function()
    local tag = awful.tag.selected()
    if tag.layout == awful.layout.suit.tile then
      tag.layout = awful.layout.suit.max
    else
      tag.layout = awful.layout.suit.tile
    end
  end),
  awful.key({ "Mod1" }, "n", function()
    local tag = awful.tag.selected()
    if tag.layout == awful.layout.suit.tile then
      tag.layout = layouts.left_right
    else
      tag.layout = awful.layout.suit.tile
    end
  end)
)

for i = 1, tags.size() do
  global_key_bindings = gears.table.join(
    global_key_bindings,
    awful.key({ "Mod1" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end),
    awful.key({ "Mod1", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end),
    awful.key({ "Mod1", "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end),
    awful.key({ "Mod1", "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end)
  )
end

local client_key_bindings = gears.table.join(
  awful.key({ "Mod1", "Shift" }, "q", function(client)
    client:kill()
  end),
  awful.key({ "Mod1", "Shift" }, ".", function(client)
    client:move_to_screen(client.screen.index + 1)
  end),
  awful.key({ "Mod1", "Shift" }, ",", function(client)
    client:move_to_screen(client.screen.index - 1)
  end)
)

local function init()
  root.keys(global_key_bindings)
end

return {
  init = init,
  client_key_bindings = client_key_bindings,
}
