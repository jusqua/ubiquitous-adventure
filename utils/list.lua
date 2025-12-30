local list = {}

---@generic T any
---@param t table
---@return T[]
function list.keys(t)
    local l = {}
    for k, _ in pairs(t) do
        table.insert(l, k)
    end
    return l
end

---@generic T any
---@param t table
---@return T[]
function list.values(t)
    local l = {}
    for _, v in pairs(t) do
        table.insert(l, v)
    end
    return l
end

---@generic T any
---@param l1 T[]
---@param l2 T[]
function list.concat(l1, l2)
    for _, e in ipairs(l2) do
        table.insert(l1, e)
    end
end

return list
