local Object = require("primitives.Object")

---@class (exact) Rectangle: Object
---@field x number
---@field y number
---@field width number
---@field height number
local Rectangle = Object:inherit("Rectangle")

---@param x number
---@param y number
---@param width number
---@param height number
---@overload fun()
function Rectangle.new(x, y, width, height)
    local self = setmetatable({}, { __index = Rectangle })

    self.x = x or 0
    self.y = y or 0
    self.width = width or 1
    self.height = height or 1

    return self
end

return Rectangle
