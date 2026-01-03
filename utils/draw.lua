local Circle = require("primitives.Circle")
local Rectangle = require("primitives.Rectangle")

--- Set environment color
---@param c Color
local function setColor(c)
    love.graphics.setColor(c.r, c.g, c.b, c.a)
end

--- Draw a circle
---@param c Circle
---@param draw_mode love.DrawMode?
local function circle(c, draw_mode)
    love.graphics.circle(draw_mode or "fill", c.x, c.y, c.radius)
end

--- Draw a rectangle
---@param r Rectangle
---@param draw_mode love.DrawMode?
local function rectangle(r, draw_mode)
    love.graphics.rectangle(draw_mode or "fill", r.x - r.width / 2, r.y - r.height / 2, r.width, r.height)
end

--- Draw based on given shape
---@param s Shape
---@param draw_mode love.DrawMode?
local function shape(s, draw_mode)
    if s:is(Circle) then ---@cast s Circle
        circle(s, draw_mode)
    elseif s:is(Rectangle) then ---@cast s Rectangle
        rectangle(s, draw_mode)
    end
end

return {
    setColor = setColor,
    circle = circle,
    rectangle = rectangle,
    shape = shape,
}
