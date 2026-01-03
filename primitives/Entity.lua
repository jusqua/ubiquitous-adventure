local Collider = require("primitives.Collider")
local Color = require("primitives.Color")
local Rectangle = require("primitives.Rectangle")
local Scene = require("primitives.Scene")
local draw = require("utils.draw")

---@class (exact) Entity: Scene
---@field shape Shape
---@field color Color
---@field speed number
local Entity = Scene:inherit("Entity")

---@class EntityArgs
---@field speed number?
---@field color Color?
---@field shape Shape?
---@field target_layer LayerType?
---@field collidable boolean?

---@param args EntityArgs?
function Entity.new(args)
    local self = setmetatable(Scene.new(), { __index = Entity })
    args = args or {}

    self.speed = args.speed or 100
    self.color = args.color or Color.new(1, 1, 1)
    self.shape = args.shape or Rectangle.new()

    if args.collidable == nil and true or args.collidable then
        self:attach(Collider.new({ shape = self.shape, target_layer = args.target_layer }))
    end
    return self
end

function Entity:draw()
    love.graphics.setColor(1, 1, 1)
    draw.shape(self.shape)
end

return Entity
