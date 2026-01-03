--- Extract table keys to a list
---@generic T any
---@param t table
---@return T[]
local function keys(t)
    local l = {}
    for k, _ in pairs(t) do
        table.insert(l, k)
    end
    return l
end

--- Extract table values to a list
---@generic T any
---@param t table
---@return T[]
local function values(t)
    local l = {}
    for _, v in pairs(t) do
        table.insert(l, v)
    end
    return l
end

--- Merge two or more lists into one
---@generic T
---@param p T[]
---@param q T[]
---@param ... T[]
local function merge(p, q, ...)
    for _, l in ipairs({ q, ... }) do
        for _, e in ipairs(l) do
            table.insert(p, e)
        end
    end
end

return {
    keys = keys,
    values = values,
    concat = merge,
    merge = merge,
}
