local Scene = require "src.primitives.scene"
local Debug = require "src.primitives.debug"
local Player = require "src.scenes.player"
local Particle = require "src.scenes.particle"

local scene
local debug

function love.load()
    scene = Scene.new()
    scene:attach(Player.new())
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
