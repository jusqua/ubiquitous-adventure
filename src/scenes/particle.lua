local Entity = require "src.primitives.entity"

---@class Particle : Entity
---@field super Entity
---@field original_size number
---@field decay_factor number
local Particle = Entity:inherit("Particle")

---@return Particle
function Particle.new()
    local args = {
        collidable = false,
        color = { math.random(127, 255) / 255, math.random(127, 255) / 255, math.random(127, 255) / 255, 1 },
        x = math.random(0, math.floor(love.graphics.getWidth())),
        y = math.random(0, math.floor(love.graphics.getHeight())),
        size = math.random(5, 20)
    }

    local self = setmetatable(Particle.super.new(args), { __index = Particle })
    self.original_size = self.width
    self.decay_factor = math.random(3, 5)
    return self
end

function Particle:update(dt)
    self.super.update(self, dt)

    self.width = self.width - self.decay_factor * dt
    self.height = self.width
    if self.width <= 0 then
        self:destroy()
    end
end

function Particle:draw()
    self.color[4] = self.width / self.original_size
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x - self.width / 2, self.y - self.width / 2, self.width)
end

return Particle
