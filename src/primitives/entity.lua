local Scene = require "src.primitives.scene"
local Collider = require "src.primitives.collider"
local ShapeType = require "src.constants.shapes"
local draw = require("src.utils.draw")

---@class Entity : Scene, Shaped
---@field super Scene
---@field speed number
---@field color [number, number, number, number?]
local Entity = Scene:inherit("Entity")

---@class EntityArgs : ColliderArgs
---@field x number?
---@field y number?
---@field speed number?
---@field collidable boolean?
---@field color Color?

---@param args EntityArgs?
---@return Entity
function Entity.new(args)
    local self = setmetatable(Entity.super.new(), { __index = Entity })
    args = args or {}

    self.radius = args.radius or args.width or args.height or args.size or 10
    self.width = args.width or args.height or args.radius or args.size or 10
    self.height = args.height or args.width or args.radius or args.size or 10
    self.speed = args.speed or 100
    self.x = args.x or self.height / 2
    self.y = args.y or self.width / 2
    self.color = args.color or { 1, 1, 1 }
    self.shape_type = args.shape_type or ShapeType.RECTANGLE

    if args.collidable == nil and true or args.collidable then
        self:attach(Collider.new({ width = self.width, height = self.height, shape_type = self.shape_type }))
    end
    return self
end

function Entity:draw()
    love.graphics.setColor(1, 1, 1)
    draw.shaped(self)
end

return Entity
