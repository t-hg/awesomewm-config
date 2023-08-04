local awful = require("awful")
local prompt = require("prompt")

local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

local function set_tags(screen)
  awful.tag(tags, screen, awful.layout.suit.tile)
end

-- returns the amout of tags
local function size()
  return #tags
end

-- renames selected tag
local function rename_selected()
  local tag = awful.tag.selected()

  prompt.run({
    prompt = "Rename:",
    text = tag.name,
    selectall = true,
    exe_callback = function(input)
      if not input or #input == 0 then
        return
      end
      tag.name = input
    end,
  })
end

local function init()
  awful.screen.connect_for_each_screen(set_tags)
end

return {
  size = size,
  rename_selected = rename_selected,
  init = init,
}
