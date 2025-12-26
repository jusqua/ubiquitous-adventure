local Scene = require 'primitives.scene'
local LayerType = require 'enums.layers'
local ShapeType = require 'enums.shapes'
local collision = require 'utils.collision'
local draw = require('utils.draw')

---@class Collider : Scene, Shaped
---@field super Scene
---@field target_layer LayerType
---@field collisions Collider[]
local Collider = Scene:inherit("Collider")

---@class ColliderArgs
---@field size number?
---@field width number?
---@field height number?
---@field radius number?
---@field shape_type ShapeType?
---@field target_layer LayerType?

---@param args ColliderArgs?
---@return Collider
function Collider.new(args)
    local self = setmetatable(Collider.super.new(), { __index = Collider })
    args = args or {}

    self.target_layer = args.target_layer or LayerType.DEFAULT
    self.shape_type = args.shape_type or ShapeType.RECTANGLE
    self.radius = args.radius or args.width or args.height or args.size or 0
    self.width = args.width or args.height or args.radius or args.size or 0
    self.height = args.height or args.width or args.radius or args.size or 0
    self.collisions = {}
    return self
end

function Collider:update(dt)
    if not self.parent then
        return
    end

    self.super.update(self, dt)
    self.x = self.parent.x
    self.y = self.parent.y
    self.collisions = {}

    local root = self:getFamilyRoot()
    for _, other in pairs(root.layer_list.children[self.target_layer]) do
        if other.id ~= self.id and other:isInstanceOf(Collider) then
            ---@cast other Collider
            if collision.between(self, other) then
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
        love.graphics.setColor(1, 0, 0, .5)
    else
        love.graphics.setColor(1, 1, 0, .5)
    end

    self.x = self.parent.x
    self.y = self.parent.y
    draw.shaped(self)
end

return Collider
