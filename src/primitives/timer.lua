local Scene = require "src.primitives.scene"

---@class Timer : Scene
---@field interval number
---@field fn fun()
---@field count number
local Timer = Scene:inherit()

---@param args { interval: number, leading: boolean, fn: fun() }
function Timer.new(args)
    local self = setmetatable(Timer.super.new(), { __index = Timer })
    self.interval = args.interval or 0
    self.fn = args.fn or (function() end)
    self.count = args.leading and self.interval or 0
    return self
end

function Timer:update(dt)
    self.count = self.count + dt
    if self.count > self.interval then
        self.count = self.count - self.interval
        self.fn()
    end
end

return Timer
