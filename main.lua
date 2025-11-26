local Scene = require "src.primitives.scene"
local Player = require "src.scenes.player"
local Particle = require "src.scenes.particle"

---@type Scene
local scene

function love.load()
    scene = Scene:new()
    scene:attach(Player:new())
end

function love.update(dt)
    scene:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
    if key == "space" then
        scene:attach(Particle.new())
    end
end

function love.draw()
    scene:draw()
end
