local M = {}

---@generic T
---@param t table<T, any>
---@return T[]
function M.keys(t)
    local l = {}
    for k, _ in pairs(t) do
        table.insert(l, k)
    end
    return l
end

---@generic T
---@param t table<any, T>
---@return T[]
function M.values(t)
    local l = {}
    for _, v in pairs(t) do
        table.insert(l, v)
    end
    return l
end

---@generic T
---@param self T[]
---@param other T[]
function M.append(self, other)
    for _, e in ipairs(other) do
        table.insert(self, e)
    end
end

return M
