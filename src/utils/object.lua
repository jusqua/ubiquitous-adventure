---@class Object
---@field super Object
---@field private __instance_of { [Object]: boolean }
local Object = {}
Object.__index = Object
Object.__instance_of = { Object = true }

function Object.new()
    local self = setmetatable({}, { __index = Object })
    self.super = Object
    return self
end

function Object:inherit()
    local other = setmetatable({}, { __index = self })
    other.super = self
    for key, value in pairs(self.__instance_of) do
        other.__instance_of[key] = value
    end
    other.__instance_of[other] = true
    return other
end

---@param other Object
function Object:isInstanceOf(other)
    return self.__instance_of[other] or false
end

return Object
