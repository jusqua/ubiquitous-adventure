local M = {}

---@param path string
function M.normalize(path)
    return jit.os == "Windows" and path:gsub("/", "\\") or path
end

---@param cmd1 string
---@param cmd2 string
function M.chain(cmd1, cmd2)
    return table.concat({ cmd1, cmd2 }, " && ")
end

---@param file string
function M.exec(file)
    return table.concat({ "luajit", file }, " ")
end

---@param path string
function M.cd(path)
    return table.concat({ [[cd]], M.normalize(path) }, " ")
end

---@param path string
function M.rmdir(path)
    return table.concat({ (jit.os == "Windows" and [[rd /s /q]] or [[rm -rf]]), M.normalize(path) }, " ")
end

---@param path string
function M.mkdir(path)
    return table.concat({ (jit.os == "Windows" and [[mkdir]] or [[mkdir -p]]), M.normalize(path) }, " ")
end

---@param from string
---@param to string
function M.move(from, to)
    return table.concat({ (jit.os == "Windows" and [[move]] or [[mv]]), M.normalize(from), M.normalize(to) }, " ")
end

---@param url string
function M.clone(url)
    return table.concat({ [[git clone --depth 1]], url }, " ")
end

return M
