local function arrange(params)
  local tag = params.tag or screen[params.screen].selected_tag
  local x = params.workarea.x
  local y = params.workarea.y
  local width = math.floor(params.workarea.width / 2)
  local height = params.workarea.height
 
  for idx, client in ipairs(params.clients) do
    local geometry = {
      x = x,
      y = y,
      width = width,
      height = height,
    }
 
    if idx > tag.master_count then
      geometry.x = width
    end
 
    params.geometries[client] = geometry
  end
end
 
local function skip_gap(_, _)
  return true
end
 
return {
  name = "left_right",
  arrange = arrange,
  skip_gab = skip_gap,
}
