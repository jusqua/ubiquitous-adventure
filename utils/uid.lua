local counter = -1
local uid = {}

function uid.generate()
    counter = counter + 1
    return counter
end

return uid
