local awful = require("awful")

return awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 60, function(widget, stdout)
	widget:set_text(" BAT " .. stdout .. "% ")
end)
