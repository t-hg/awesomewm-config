local awful = require("awful")

return awful.widget.watch("curl https://ifconfig.me", 10, function(widget, stdout)
  widget:set_text(" IP " .. stdout)
end)
