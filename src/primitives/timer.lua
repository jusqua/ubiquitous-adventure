local Scene = require "src.primitives.scene"

---@class Timer : Scene
---@field super Scene
---@field interval number
---@field fn fun()
---@field count number
local Timer = Scene:inherit("Timer")

---@param args { interval: number, leading?: boolean, fn: fun() }
---@return Timer
function Timer.new(args)
    local self = setmetatable(Timer.super.new(), { __index = Timer })
    args = args or {}

    self.interval = args.interval
    self.fn = args.fn
    self.count = args.leading and self.interval or 0
    return self
end

function Timer:update(dt)
    self.super.update(self, dt)

    self.count = self.count + dt
    if self.count > self.interval then
        self.count = self.count - self.interval
        self.fn()
    end
end

return Timer
