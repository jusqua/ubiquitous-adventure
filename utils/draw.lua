local ShapeType = require 'enums.ShapeType'

local draw = {}

---@param c Circle
---@param draw_mode love.DrawMode?
function draw.circle(c, draw_mode)
    love.graphics.circle(
        draw_mode or "fill",
        c.x,
        c.y,
        c.radius
    )
end

---@param r Rectangle
---@param draw_mode love.DrawMode?
function draw.rectangle(r, draw_mode)
    love.graphics.rectangle(
        draw_mode or "fill",
        r.x - r.width / 2,
        r.y - r.height / 2,
        r.width,
        r.height
    )
end

---@type table<ShapeType, fun(shape: Shaped, draw_mode: love.DrawMode?)>
local draw_shape_map = {
    [ShapeType.RECTANGLE] = draw.rectangle,
    [ShapeType.CIRCLE] = draw.circle,
}

---@param s Shaped
---@param draw_mode love.DrawMode?
draw.shaped = function(s, draw_mode)
    draw_shape_map[s.shape_type](s, draw_mode)
end

return draw
