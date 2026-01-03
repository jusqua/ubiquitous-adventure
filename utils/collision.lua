local Circle = require("primitives.Circle")
local Rectangle = require("primitives.Rectangle")

---@param r1 Rectangle
---@param r2 Rectangle
---@return boolean
local function collisionBetweenRectangleRectangle(r1, r2)
    local r1x1 = r1.x - r1.width / 2
    local r1y1 = r1.y - r1.height / 2
    local r1x2 = r1.x + r1.width / 2
    local r1y2 = r1.y + r1.height / 2
    local r2x1 = r2.x - r2.width / 2
    local r2y1 = r2.y - r2.height / 2
    local r2x2 = r2.x + r2.width / 2
    local r2y2 = r2.y + r2.height / 2
    return r1x1 < r2x2 and r1x2 > r2x1 and r1y1 < r2y2 and r1y2 > r2y1
end

---@param c1 Circle
---@param c2 Circle
---@return boolean
local function collisionBetweenCircleCircle(c1, c2)
    local dx = c1.x + c1.radius / 2 - c2.x
    local dy = c1.y + c1.radius / 2 - c2.y
    local d = math.sqrt(dx * dx + dy * dy)
    return d < c1.radius / 2 + c2.radius / 2
end

---@param c Circle
---@param r Rectangle
---@return boolean
local function collisionBetweenCircleRectangle(c, r)
    local rx = math.max(r.x - r.width / 2, math.min(c.x, r.x + r.width / 2))
    local ry = math.max(r.y - r.height / 2, math.min(c.y, r.y + r.height / 2))
    local dx = rx - c.x
    local dy = ry - c.y
    local d = math.sqrt(dx * dx + dy * dy)
    return d < c.radius
end

--- Check if two shapes collided
---@param p Shape
---@param q Shape
---@return boolean
local function between(p, q)
    if p:is(Circle) and q:is(Circle) then ---@cast p Circle ---@cast q Circle
        return collisionBetweenCircleCircle(p, q)
    elseif p:is(Circle) and q:is(Rectangle) then ---@cast p Circle ---@cast q Rectangle
        return collisionBetweenCircleRectangle(p, q)
    elseif p:is(Rectangle) and q:is(Circle) then ---@cast p Rectangle ---@cast q Circle
        return collisionBetweenCircleRectangle(q, p)
    elseif p:is(Rectangle) and q:is(Rectangle) then ---@cast p Rectangle ---@cast q Rectangle
        return collisionBetweenRectangleRectangle(p, q)
    end
    return false
end

return {
    between = between,
}
