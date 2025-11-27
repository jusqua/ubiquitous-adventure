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

---@param dt number
function Scene:debugUpdate(dt)
    for _, scene in pairs(self.family_tree.children) do
        scene:debugUpdate(dt)
    end
end

function Scene:draw()
    for _, scene in pairs(self.family_tree.children) do
        scene:draw()
    end
end

function Scene:debugDraw()
    for _, scene in pairs(self.family_tree.children) do
        scene:debugDraw()
    end
end

function Scene:getUID()
    return self.id .. ":" .. self:getType()
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

    self.family_tree.children[other.id] = other
    self.family_tree.count = self.family_tree.count + 1

    local node = self
    while node do
        node.family_list.children[other.id] = other
        node.family_list.count = node.family_list.count + 1

        for _, scene in pairs(other.family_list.children) do
            node.family_list.children[scene.id] = scene
            node.family_list.count = node.family_list.count + 1
        end

        node = node.parent
    end

    print(other:getUID() .. " attached to " .. self:getUID())
    other.parent = self
end

---Turn the scene orphaned
function Scene:detach()
    if not self.parent then
        return
    end

    self.parent.family_tree.children[self.id] = nil
    self.parent.family_tree.count = self.parent.family_tree.count - 1

    local node = self.parent
    while node do
        node.family_list.children[self.id] = nil
        node.family_list.count = node.family_list.count - 1

        for _, scene in pairs(self.family_list.children) do
            node.family_list.children[scene.id] = nil
            node.family_list.count = node.family_list.count - 1
        end

        node = node.parent
    end

    print(self:getUID() .. " detached from " .. self.parent:getUID())
    self.parent = nil
end

---Destroy the scene and its children
function Scene:destroy()
    for _, scene in pairs(self.family_tree.children) do
        scene:destroy()
    end
    self:detach()
end

return Scene
