local LayerType = require("enums.LayerType")
local Rectangle = require("primitives.Rectangle")
local Scene = require("scenes.Scene")
local collision = require("utils.collision")
local draw = require("utils.draw")

---@class (exact) Collider: Scene
---@field shape Shape
---@field target_layer LayerType
---@field collisions Collider[]
local Collider = Scene:inherit("Collider")

---@class ColliderArgs
---@field shape Shape?
---@field target_layer LayerType?

---@param args ColliderArgs?
function Collider.new(args)
    local self = setmetatable(Scene.new(), { __index = Collider })
    args = args or {}

    self.target_layer = args.target_layer or LayerType.DEFAULT
    self.shape = args.shape or Rectangle.new()
    self.collisions = {}

    return self
end

function Collider:update(dt)
    if not self.parent then
        return
    end

    Scene.update(self, dt)
    self.collisions = {}

    local root = self:getFamilyRoot()
    for _, other in pairs(root.layer_list.children[self.target_layer]) do
        if other.id ~= self.id and other:is(Collider) then ---@cast other Collider
            if collision.between(self.shape, other.shape) then
                table.insert(self.collisions, other)
            end
        end
    end
end

function Collider:debug()
    if not self.parent then
        return
    end

    if #self.collisions > 0 then
        love.graphics.setColor(1, 0, 0, 0.5)
    else
        love.graphics.setColor(1, 1, 0, 0.5)
    end

    draw.shape(self.shape)
end

return Collider
