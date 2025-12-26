local Entity = require 'primitives.entity'
local draw = require('utils.draw')

---@class Particle : Entity
---@field super Entity
---@field original_radius number
---@field decay_factor number
local Particle = Entity:inherit("Particle")

---@return Particle
function Particle.new()
    ---@type EntityArgs
    local args = {
        collidable = false,
        color = { math.random(127, 255) / 255, math.random(127, 255) / 255, math.random(127, 255) / 255, 1 },
        x = math.random(0, math.floor(love.graphics.getWidth())),
        y = math.random(0, math.floor(love.graphics.getHeight())),
        size = math.random(5, 20)
    }

    local self = setmetatable(Particle.super.new(args), { __index = Particle })
    self.original_radius = self.radius
    self.decay_factor = math.random(3, 5)
    return self
end

function Particle:update(dt)
    self.super.update(self, dt)

    self.radius = self.radius - self.decay_factor * dt
    self.height = self.radius
    if self.radius <= 0 then
        self:destroy()
    end
end

function Particle:draw()
    self.color[4] = self.radius / self.original_radius
    love.graphics.setColor(self.color)
    draw.circle(self)
end

return Particle
