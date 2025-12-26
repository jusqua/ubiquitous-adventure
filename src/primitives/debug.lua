local Scene = require "src.primitives.scene"
local Timer = require "src.primitives.timer"
local FontType = require 'src.constants.fonts'
local LayerType = require "src.constants.layers"

---@class Debug : Scene
---@field super Scene
---@field fps_count number
---@field used_mem number
---@field vsync_state number
local Debug = Scene:inherit("Debug")

---@return Debug
function Debug.new()
    local self = setmetatable(Debug.super.new(), { __index = Debug })
    self.current_layer = LayerType.DEBUG
    self.fps_count = 0
    self.used_mem = 0
    self.vsync_state = 0
    self:attach(Timer.new({
        leading = true,
        interval = 1,
        fn = function()
            self.fps_count = math.floor(love.timer.getFPS())
            self.vsync_state = love.window.getVSync()
        end
    }))
    self:attach(Timer.new({
        leading = true,
        interval = 3,
        fn = function()
            self.used_mem = math.floor(collectgarbage("count"))
        end
    }))
    return self
end

function Debug:draw()
    if not self.parent then
        return
    end

    for _, scenes in pairs(self.parent.layer_list.children) do
        for _, scene in pairs(scenes) do
            scene:debug()
        end
    end
end

function Debug:debug()
    if not self.parent then
        return
    end

    local font = FontType.MEDODICA
    local font_height = font:getHeight()
    love.graphics.setColor(1, 0, 1)
    love.graphics.setFont(font)
    love.graphics.print("Instances: " .. self.parent.layer_list.count + 1)
    love.graphics.print("Used Memory: " .. self.used_mem .. " Kb", 0, font_height)
    love.graphics.print("FPS: " .. self.fps_count .. (self.vsync_state ~= 0 and " (VSync)" or ""), 0, font_height * 2)

    local instances = { self.parent:getUID() }
    for _, scenes in pairs(self.parent.layer_list.children) do
        for _, scene in pairs(scenes) do
            instances[#instances] = instances[#instances] .. ", "
            if font:getWidth(instances[#instances] .. scene:getUID()) > love.graphics.getWidth() then
                table.insert(instances, "")
            end
            instances[#instances] = instances[#instances] .. scene:getUID()
        end
    end
    for i, text in pairs(instances) do
        love.graphics.print(text, 0, love.graphics.getHeight() - font_height * (#instances - i + 1))
    end
end

return Debug
