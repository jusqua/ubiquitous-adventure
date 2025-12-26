local list = {}

---@generic T
---@param t table<T, any>
---@return T[]
function list.keys(t)
    local l = {}
    for k, _ in pairs(t) do
        table.insert(l, k)
    end
    return l
end

---@generic T
---@param t table<any, T>
---@return T[]
function list.values(t)
    local l = {}
    for _, v in pairs(t) do
        table.insert(l, v)
    end
    return l
end

---@generic T
---@param self T[]
---@param other T[]
function list.append(self, other)
    for _, e in ipairs(other) do
        table.insert(self, e)
    end
end

return list
