local Scene = require 'primitives.Scene'
local Debug = require 'primitives.Debug'
local Entity = require 'primitives.Entity'
local Player = require 'scenes.Player'
local Particle = require 'scenes.Particle'

---@type Scene
local scene
---@type Debug
local debug

function love.load()
    scene = Scene.new()
    scene:attach(Player.new({ speed = 200 }))
    scene:attach(Entity.new({
        size = 40,
        x = love.graphics.getWidth() / 2 - 20,
        y = love.graphics.getHeight() / 2 - 20
    }))
    debug = Debug.new()
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
    if key == "f3" then
        if debug.parent then
            debug:detach()
        else
            scene:attach(debug)
        end
    end
end

function love.draw()
    scene:draw()
end
