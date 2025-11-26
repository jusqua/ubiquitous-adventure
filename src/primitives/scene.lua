local uid = require "src.utils.uid"

---@class Scene
---@field super Scene
---@field id number
---@field parent Scene?
---@field children {[number]: Scene}
---@field x number
---@field y number
local Scene = {}

function Scene.new()
    local self = {}
    self.id = uid.generate()
    self.super = Scene
    self.parent = nil
    self.children = {}
    self.x = 0
    self.y = 0
    return setmetatable(self, { __index = Scene })
end

function Scene:inherits()
    local other = setmetatable({}, { __index = self })
    other.super = self
    return other
end

---@param dt number
function Scene:update(dt)
    for _, scene in pairs(self.children) do
        scene:update(dt)
    end
end

function Scene:draw()
    for _, scene in pairs(self.children) do
        scene:draw()
    end
end

---Assign the scene as parent to the given scene
---@param other Scene
function Scene:attach(other)
    other:detach()
    other.parent = self
    other.parent.children[other.id] = other
end

---Turn the scene orphaned
function Scene:detach()
    if self.parent then
        self.parent.children[self.id] = nil
        self.parent = nil
    end
end

---Destroy the scene and its children
function Scene:destroy()
    for _, scene in pairs(self.children) do
        scene:destroy()
    end
    self:detach()
end

return Scene
