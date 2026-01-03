--- Recursively copies methods and attributes of a table
---@param p table
---@param q table
local function deepcopy(p, q)
    for k, v in pairs(q) do
        if type(v) == "table" then
            p[k] = {}
            deepcopy(p[k], v)
        else
            p[k] = v
        end
    end
end

--- Shallow copies methods and attributes of a table
---@param p table
---@param q table
local function copy(p, q)
    for k, v in pairs(q) do
        p[k] = v
    end
end

return {
    copy = copy,
    deepcopy = deepcopy,
}
