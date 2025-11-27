local counter = -1
local M = {}

function M.generate()
    counter = counter + 1
    return counter
end

return M
