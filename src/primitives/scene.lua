local uid = require "src.utils.uid"
local Object = require "src.utils.object"

---@class Scene : Object
---@field super Scene
---@field id number
---@field parent Scene?
---@field family_tree { count: number, children: { [number]: Scene } }
---@field family_list { count: number, children: { [number]: Scene } }
---@field x number
---@field y number
local Scene = Object:inherit("Scene")

function Scene.new()
    local self = setmetatable(Scene.super.new(), { __index = Scene })
    self.id = uid.generate()
    self.parent = nil
    self.family_tree = { count = 0, children = {} }
    self.family_list = { count = 0, children = {} }
    self.x = 0
    self.y = 0
    return self
end

---@param dt number
function Scene:update(dt)
    for _, scene in pairs(self.family_tree.children) do
        scene:update(dt)
    end
end

function Scene:draw()
    for _, scene in pairs(self.family_tree.children) do
        scene:draw()
    end
end

---Get the root scene
function Scene:getFamilyRoot()
    if self.parent then
        return self.parent:getFamilyRoot()
    end
    return self
end

---Assign the scene as parent to the given scene
---@param other Scene
function Scene:attach(other)
    other:detach()
    other.parent = self
    other.parent.family_tree.children[other.id] = other
    other.parent.family_tree.count = other.parent.family_tree.count + 1

    local scene = self
    while scene do
        scene.family_list.children[other.id] = other
        scene.family_list.count = scene.family_list.count + 1
        scene = scene.parent
    end
end

---Turn the scene orphaned
function Scene:detach()
    local scene = self.parent
    while scene do
        scene.family_list.children[self.id] = nil
        scene.family_list.count = scene.family_list.count - 1
        scene = scene.parent
    end

    if self.parent then
        self.parent.family_tree.children[self.id] = nil
        self.parent.family_tree.count = self.parent.family_tree.count - 1
        self.parent = nil
    end
end

---Destroy the scene and its children
function Scene:destroy()
    for _, scene in pairs(self.family_tree.children) do
        scene:destroy()
    end
    self:detach()
end

return Scene
