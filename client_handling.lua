local awful = require("awful")
local beautiful = require("beautiful")
local client_button_bindings = require("button_bindings").client_button_bindings
local client_key_bindings = require("key_bindings").client_key_bindings

-- all clients will match this rule
local general_rule = {
	rule = {},
	properties = {
		border_width = beautiful.border_width,
		border_color = beautiful.border_normal,
		buttons = client_button_bindings,
		focus = awful.client.focus.filter,
		keys = client_key_bindings,
		maximized = false,
		maximized_horizontal = false,
		maximized_vertical = false,
		placement = awful.placement.centered,
		raise = true,
		screen = awful.screen.preferred,
		size_hints_honor = false,
		floating = true,
	},
}

local function init()
	require("awful.autofocus")
	awful.mouse.snap.edge_enabled = false

	awful.rules.rules = {
		general_rule,
	}

	client.connect_signal("mouse::enter", function(client)
		client:emit_signal("request::activate", "mouse_enter", { raise = false })
	end)

	client.connect_signal("focus", function(client)
		client.border_color = beautiful.border_focus
	end)

	client.connect_signal("unfocus", function(client)
		client.border_color = beautiful.border_normal
	end)

	client.connect_signal("manage", function(client)
		awful.client.setslave(client)
	end)

	client.connect_signal("property::maximized", function(client)
		if client.maximized then
			client.maximized = false
		end
	end)

	client.connect_signal("property::fullscreen", function(client)
		if client.fullscreen then
			client.fullscreen = false
		end
	end)

	client.connect_signal("property::geometry", function(client)
		client.floating_geometry = client.geometry
	end)
end

return {
	init = init,
}
