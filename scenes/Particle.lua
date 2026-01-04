local Color = require("primitives.Color")
local Entity = require("scenes.Entity")
local draw = require("utils.draw")

---@class (exact) Particle: Entity
---@field original_radius number
---@field decay_factor number
local Particle = Entity:inherit("Particle")

function Particle.new()
    local self = setmetatable(
        Entity.new({
            collidable = false,
            color = Color.new(math.random(127, 255) / 255, math.random(127, 255) / 255, math.random(127, 255) / 255, 1),
            x = math.random(0, math.floor(love.graphics.getWidth())),
            y = math.random(0, math.floor(love.graphics.getHeight())),
            size = math.random(5, 20),
        }),
        { __index = Particle }
    )

    self.original_radius = self.radius
    self.decay_factor = math.random(3, 5)

    return self
end

function Particle:update(dt)
    Entity.update(self, dt)

    self.radius = self.radius - self.decay_factor * dt
    self.height = self.radius
    if self.radius <= 0 then
        self:destroy()
    end
end

function Particle:draw()
    self.color.a = self.radius / self.original_radius
    draw.setColor(self.color)
    draw.shape(self.shape)
end

return Particle
