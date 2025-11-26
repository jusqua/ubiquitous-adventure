---@class Object
---@field super Object
local Object = {}

function Object.new()
    local self = {}
    self.super = Object
    return setmetatable(self, { __index = Object })
end

function Object:inherits()
    local other = setmetatable({}, { __index = self })
    other.super = self
    return other
end

return Object
