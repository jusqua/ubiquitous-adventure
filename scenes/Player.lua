local ShapeType = require 'enums.ShapeType'
local Entity = require 'primitives.Entity'
local LayerType = require 'enums.LayerType'

---@class Player : Entity
---@field super Entity
local Player = Entity:inherit("Player")

---@param args EntityArgs?
---@return Player
function Player.new(args)
    ---@type EntityArgs
    args = args or {}
    args.collidable = true
    args.target_layer = LayerType.DEFAULT
    args.shape_type = ShapeType.CIRCLE

    return setmetatable(Player.super.new(args), { __index = Player })
end

function Player:update(dt)
    self.super.update(self, dt)

    if love.keyboard.isDown("w", "up") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("s", "down") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("a", "left") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("d", "right") then
        self.x = self.x + self.speed * dt
    end
end

return Player
