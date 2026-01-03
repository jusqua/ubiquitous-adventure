local Circle = require("primitives.Circle")
local Entity = require("primitives.Entity")
local LayerType = require("enums.LayerType")

---@class (exact) Player: Entity
local Player = Entity:inherit("Player")

---@param args EntityArgs?
function Player.new(args)
    ---@type EntityArgs
    args = args or {}
    args.collidable = args.collidable or true
    args.target_layer = args.target_layer or LayerType.DEFAULT
    args.shape = args.shape or Circle.new(0, 0, 10)

    return setmetatable(Entity.new(args), { __index = Player })
end

function Player:update(dt)
    Entity.update(self, dt)

    if love.keyboard.isDown("w", "up") then
        self.shape.y = self.shape.y - self.speed * dt
    end
    if love.keyboard.isDown("s", "down") then
        self.shape.y = self.shape.y + self.speed * dt
    end
    if love.keyboard.isDown("a", "left") then
        self.shape.x = self.shape.x - self.speed * dt
    end
    if love.keyboard.isDown("d", "right") then
        self.shape.x = self.shape.x + self.speed * dt
    end
end

return Player
