local uid = require 'utils.uid'
local list = require 'utils.list'
local LayerType = require 'enums.LayerType'
local Object = require 'primitives.Object'

---@alias SceneId number
---@alias SceneMap table<SceneId,Scene>
---@alias LayersMap table<LayerType,SceneMap>

---@class Scene : Object
---@field super Object
---@field id SceneId
---@field current_layer LayerType
---@field parent Scene?
---@field scene_tree { count: number, children: SceneMap }
---@field layer_list { count: number, children: LayersMap }
---@field x number
---@field y number
---@field z number
local Scene = Object:inherit("Scene")

---@return Scene
function Scene.new()
    local self = setmetatable(Scene.super.new(), { __index = Scene })
    self.id = uid.generate()
    self.current_layer = LayerType.DEFAULT
    self.parent = nil
    self.x = 0
    self.y = 0
    self.z = 0

    self.scene_tree = {
        count = 0,
        children = {}
    }
    self.layer_list = {
        count = 0,
        children = {}
    }
    for _, layer in pairs(LayerType) do
        self.layer_list.children[layer] = {}
    end

    return self
end

---Perform update actions on scene. When override, parent method must be called.
---@param dt number delta time
function Scene:update(dt)
    for _, scene in pairs(self.scene_tree.children) do
        scene:update(dt)
    end
end

---Perform draw actions on scene. When override, parent method should not be called.
function Scene:draw()
    local draw_list = {}

    local layers = list.values(LayerType)
    table.sort(layers, function(a, b)
        return a < b
    end)

    for _, layer in ipairs(layers) do
        local scene_list = list.values(self.layer_list.children[layer])
        table.sort(scene_list, function(a, b)
            return a.z < b.z
        end)
        list.append(draw_list, scene_list)
    end

    for _, scene in pairs(draw_list) do
        scene:draw()
    end
end

---Perform draw actions on scene for debugging purposes.
function Scene:debug()
end

---Return an Unique Identifier of the scene
function Scene:getUID()
    return self.id .. ":" .. self:getType()
end

---Get the root scene
---@return Scene
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

    self.scene_tree.children[other.id] = other
    self.scene_tree.count = self.scene_tree.count + 1

    local node = self
    while node do
        node.layer_list.children[other.current_layer][other.id] = other
        node.layer_list.count = node.layer_list.count + 1

        for layer, scenes in pairs(other.layer_list.children) do
            for _, scene in pairs(scenes) do
                node.layer_list.children[layer][scene.id] = scene
                node.layer_list.count = node.layer_list.count + 1
            end
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

    self.parent.scene_tree.children[self.id] = nil
    self.parent.scene_tree.count = self.parent.scene_tree.count - 1

    local node = self.parent
    while node do
        node.layer_list.children[self.current_layer][self.id] = nil
        node.layer_list.count = node.layer_list.count - 1

        for layer, scenes in pairs(self.layer_list.children) do
            for _, scene in pairs(scenes) do
                node.layer_list.children[layer][scene.id] = nil
                node.layer_list.count = node.layer_list.count - 1
            end
        end

        ---@diagnostic disable-next-line
        node = node.parent
    end

    print(self:getUID() .. " detached from " .. self.parent:getUID())
    self.parent = nil
end

---Destroy the scene and its children
function Scene:destroy()
    for _, scene in pairs(self.scene_tree.children) do
        scene:destroy()
    end
    self:detach()
end

return Scene
