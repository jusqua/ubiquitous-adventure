---@class Object
---@field super nil
---@field private __instance_of { [Object]: boolean }
local Object = {}
Object.super = nil
Object.__index = Object
Object.__name = "Object"
Object.__instance_of = { [Object] = true }

function Object.new()
    return setmetatable({}, { __index = Object })
end

---@param name string
function Object:inherit(name)
    local other = setmetatable(self.new(), { __index = self })
    other.super = self
    other.__name = name
    other.__instance_of = { [other] = true }
    for key, value in pairs(self.__instance_of) do
        other.__instance_of[key] = value
    end
    return other
end

---@param other Object
function Object:isInstanceOf(other)
    return self.__instance_of[other] or false
end

function Object:getType()
    return self.__name
end

return Object
