--- The base class implementation
---@class (exact) Object
--- Map of inherited classes and implemented traits
---@field private __is table<Object, boolean>
--- Class defined name
---@field private __name string
local Object = {}
Object.__index = Object
Object.__is = { [Object] = true }
Object.__name = "Object"

--- Creates a new instance of the object
---@return self
function Object.new()
    return setmetatable({}, { __index = Object })
end

---@param name string
function Object:inherit(name)
    local cls = setmetatable({}, { __index = self })
    cls.__name = name
    cls.__is = {}
    for k, _ in pairs(self.__is) do
        cls.__is[k] = true
    end
    cls.__is[cls] = true
    return cls
end

--- Checks if the object is an instance of the given class
---@generic T: Object
---@param cls T
---@return boolean
function Object:is(cls)
    return self.__is[cls] or false
end

--- Return the name of the class of the given object
---@return string
function Object:className()
    return self.__name or "Unknown"
end

return Object
