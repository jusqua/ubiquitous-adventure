local Object = require("primitives.Object")

---@class (exact) Circle: Object
---@field x number
---@field y number
---@field radius number
local Circle = Object:inherit("Circle")

---@param x number
---@param y number
---@param radius number
---@overload fun()
function Circle.new(x, y, radius)
    local self = setmetatable({}, { __index = Circle })

    self.x = x or 0
    self.y = y or 0
    self.radius = radius or 1

    return self
end

return Circle
