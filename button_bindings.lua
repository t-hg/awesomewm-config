local awful = require("awful")
local gears = require("gears")

local button1 = 1
local button3 = 3

local function activate_client(client)
  client:emit_signal("request::activate", "", { raise = true })
end

local function move_client(client)
  client.floating = true
  activate_client(client)
  awful.mouse.client.move(client)
end

local function resize_client(client)
  client.floating = true
  activate_client(client)
  awful.mouse.client.resize(client)
end

-- Button bindings for each client
local client_button_bindings = gears.table.join(
  awful.button({}, button1, activate_client),
  awful.button({ "Mod1" }, button1, move_client),
  awful.button({ "Mod1" }, button3, resize_client),
  awful.button({ "Mod1", "Shift" }, button1, resize_client)
)

-- Button bindings for taglists
local taglist_button_bindings = gears.table.join(awful.button({}, button1, function(tag)
  tag:view_only()
end))

-- Button bindings for tasklists
local tasklist_button_bindings = gears.table.join(awful.button({}, button1, activate_client))

return {
  client_button_bindings = client_button_bindings,
  taglist_button_bindings = taglist_button_bindings,
  tasklist_button_bindings = tasklist_button_bindings,
}
