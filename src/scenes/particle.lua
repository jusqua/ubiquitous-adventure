local Scene = require "src.primitives.scene"

---@class Particle : Scene
---@field color [number, number, number, number]
---@field original_size number
---@field current_size number
---@field decay_factor number
local Particle = Scene:inherit("Particle")

function Particle.new()
    local self = setmetatable(Particle.super.new(), { __index = Particle })
    self.color = { math.random(127, 255) / 255, math.random(127, 255) / 255, math.random(127, 255) / 255, 1 }
    self.original_size = math.random(5, 20)
    self.current_size = self.original_size
    self.decay_factor = math.random(1, 3)
    self.x = math.random(0, love.graphics.getWidth())
    self.y = math.random(0, love.graphics.getHeight())
    return self
end

function Particle:update(dt)
    self.current_size = self.current_size - self.decay_factor * dt
    if self.current_size <= 0 then
        self:destroy()
    end
end

function Particle:draw()
    self.color[4] = self.current_size / self.original_size
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x - self.current_size / 2, self.y - self.current_size / 2, self.current_size)
end

return Particle
