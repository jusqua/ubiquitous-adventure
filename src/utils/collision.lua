local ShapeType = require "src.constants.shapes"

local M = {}

---@param r1 Shaped
---@param r2 Shaped
---@return boolean
function M.betweenRectangleRectangle(r1, r2)
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

---@param c1 Shaped
---@param c2 Shaped
---@return boolean
function M.betweenCircleCircle(c1, c2)
    local dx = c1.x + c1.radius / 2 - c2.x
    local dy = c1.y + c1.radius / 2 - c2.y
    local d = math.sqrt(dx * dx + dy * dy)
    return d < c1.radius / 2 + c2.radius / 2
end

---@param c Shaped
---@param r Shaped
---@return boolean
function M.betweenCircleRectangle(c, r)
    local rx = math.max(r.x - r.width / 2, math.min(c.x, r.x + r.width / 2))
    local ry = math.max(r.y - r.height / 2, math.min(c.y, r.y + r.height / 2))
    local dx = rx - c.x
    local dy = ry - c.y
    local d = math.sqrt(dx * dx + dy * dy)
    return d < c.radius
end

---@type table<ShapeType, table<ShapeType, fun(first: Shaped, second: Shaped): boolean>>
local collision_map = {
    [ShapeType.RECTANGLE] = {
        [ShapeType.RECTANGLE] = M.betweenRectangleRectangle,
        [ShapeType.CIRCLE] = function(r, c) return M.betweenCircleRectangle(c, r) end
    },
    [ShapeType.CIRCLE] = {
        [ShapeType.RECTANGLE] = M.betweenCircleRectangle,
        [ShapeType.CIRCLE] = M.betweenCircleCircle
    },
}

---@param first Shaped
---@param second Shaped
---@return boolean
M.between = function(first, second)
    return collision_map[first.shape_type][second.shape_type](first, second)
end

return M
