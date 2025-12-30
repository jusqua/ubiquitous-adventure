---@class Object
---@field super Object
---@field private __is { [Object]: boolean }
---@field private __name string
local Object = {}
Object.__index = Object
Object.super = Object
Object.__is = { [Object] = true }
Object.__name = "Object"

function Object.new()
    return setmetatable({}, { __index = Object })
end

---@param name string
function Object:inherit(name)
    local cls = setmetatable(self.new(), { __index = self })
    cls.super = self
    cls.__name = name
    cls.__is = { [cls] = true }
    for key, value in pairs(self.__is) do
        cls.__is[key] = value
    end
    return cls
end

---@param cls Object
function Object:is(cls)
    return self.__is[cls] or false
end

function Object:class()
    return self.__name
end

return Object
