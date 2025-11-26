local Scene = require "src.primitives.scene"

---@class Player : Scene
---@field speed number
---@field size number
local Player = Scene:inherits()

function Player.new()
    local self = Player.super.new()
    self.size = 10
    self.speed = 200
    self.x = self.size / 2
    self.y = self.size / 2
    return setmetatable(self, { __index = Player })
end

function Player:update(dt)
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

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x - self.size / 2, self.y - self.size / 2, self.size, self.size)
end

return Player
