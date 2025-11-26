local Scene = require "src.primitives.scene"
local Timer = require "src.primitives.timer"
local fonts = require "src.utils.fonts"

---@class Debug : Scene
---@field fps_count number
---@field used_mem number
---@field vsync_state number
local Debug = Scene:inherit("Debug")

function Debug.new()
    local self = setmetatable(Debug.super.new(), { __index = Debug })
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
    local font_height = fonts.medodica:getHeight()
    love.graphics.setColor(1, 0, 1)
    love.graphics.setFont(fonts.medodica)
    love.graphics.print("Instances: " .. (self.parent and self.parent.family_list.count or 0))
    love.graphics.print("Used Memory: " .. self.used_mem .. " Kb", 0, font_height)
    love.graphics.print("FPS: " .. self.fps_count .. (self.vsync_state ~= 0 and " (VSync)" or ""), 0, font_height * 2)
end

return Debug
