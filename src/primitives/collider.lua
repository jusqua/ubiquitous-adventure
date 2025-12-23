local Scene = require "src.primitives.scene"
local layers = require "src.constants.layers"

---@class Collider : Scene
---@field super Scene
---@field width number
---@field height number
---@field collisions Collider[]
local Collider = Scene:inherit("Collider")

---@param args? { size?: number, width?: number, height?: number }
---@return Collider
function Collider.new(args)
    local self = setmetatable(Collider.super.new(), { __index = Collider })
    args = args or {}

    self.target_layer = args.target_layer or layers.default
    self.collisions = {}
    self.width = args.width or args.size or 0
    self.height = args.height or args.size or 0
    return self
end

function Collider:update(dt)
    self.super.update(self, dt)
    if not self.parent then
        return
    end

    self.collisions = {}
    local root = self:getFamilyRoot()
    for _, scene in pairs(root.layer_list.children[self.target_layer]) do
        if scene.id ~= self.id and scene:isInstanceOf(Collider) then
            if self:isCollidingWith(scene) then
                table.insert(self.collisions, scene)
            end
        end
    end
end

function Collider:debug()
    if #self.collisions > 0 then
        love.graphics.setColor(1, 0, 0, .5)
    else
        love.graphics.setColor(1, 1, 0, .5)
    end
    local collider = self.parent or self
    love.graphics.rectangle(
        "fill",
        collider.x - self.width / 2,
        collider.y - self.height / 2,
        self.width,
        self.height
    )
end

---@return { x1: number, y1: number, x2: number, y2: number }
function Collider:getBounds()
    local collider = self.parent or self
    return {
        x1 = collider.x - self.width / 2,
        y1 = collider.y - self.height / 2,
        x2 = collider.x + self.width / 2,
        y2 = collider.y + self.height / 2
    }
end

---@param other Collider
function Collider:isCollidingWith(other)
    local self_bounds = self:getBounds()
    local other_bounds = other:getBounds()
    return (
        self_bounds.x1 < other_bounds.x2 and
        self_bounds.y1 < other_bounds.y2 and
        self_bounds.x2 > other_bounds.x1 and
        self_bounds.y2 > other_bounds.y1
    )
end

return Collider
