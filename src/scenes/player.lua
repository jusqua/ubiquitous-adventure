local Entity = require 'src.primitives.entity'
local LAYERS = require("src.constants.layers")

---@class Player : Entity
---@field super Entity
local Player = Entity:inherit("Player")

---@param args { x?: number, y?: number, size?: number, width?: number, height?: number, speed?: number, color?: [number, number, number, number?] }
---@return Player
function Player.new(args)
    args = args or {}
    args.collidable = true
    args.target_layer = LAYERS.default

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
