local Scene = require "src.primitives.scene"
local Collider = require "src.primitives.collider"

---@class Entity : Scene
---@field super Scene
---@field speed number
---@field width number
---@field height number
---@field color [number, number, number, number?]
local Entity = Scene:inherit("Entity")

---@param args { collidable?: boolean, x?: number, y?: number, size?: number, width?: number, height?: number, speed?: number, color?: [number, number, number, number?] }
---@return Entity
function Entity.new(args)
    local self = setmetatable(Entity.super.new(), { __index = Entity })
    args = args or {}

    self.height = args.height or args.size or 10
    self.width = args.width or args.size or 10
    self.speed = args.speed or 100
    self.x = args.x or self.height / 2
    self.y = args.y or self.width / 2
    self.color = args.color or { 1, 1, 1 }

    if args.collidable == nil and true or args.collidable then
        self:attach(Collider.new({ width = self.width, height = self.height }))
    end
    return self
end

function Entity:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end

return Entity
