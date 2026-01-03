local Object = require("primitives.Object")

---@class (exact) Color: Object
---@field r number
---@field g number
---@field b number
---@field a number
local Color = Object:inherit("Color")

---@param r number
---@param g number
---@param b number
---@param a number?
function Color.new(r, g, b, a)
    local self = setmetatable({}, { __index = Color })

    self.r = r or 0
    self.g = g or 0
    self.b = b or 0
    self.a = a or 1

    return self
end

---@param r integer
---@param g integer
---@param b integer
---@param a integer
function Color.fromByte(r, g, b, a)
    local self = setmetatable({}, { __index = Color })

    self.r = r / 255 or 0
    self.g = g / 255 or 0
    self.b = b / 255 or 0
    self.a = a / 255 or 1

    return self
end

return Color
