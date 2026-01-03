---@alias UID integer

--- Seed?
local _counter = -1

--- Generate a new UID
---@return UID
local function generate()
    _counter = _counter + 1
    return _counter
end

return {
    generate = generate,
}
