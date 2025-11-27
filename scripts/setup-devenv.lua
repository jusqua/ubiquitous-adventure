local utils = require 'scripts.utils'

local batch = {
    utils.rmdir("api"),
    utils.rmdir("EmmyLuaLOVEGenerator"),
    utils.rmdir("love-api"),

    utils.clone("https://github.com/love2d-community/love-api"),
    utils.clone("https://github.com/anaissls/EmmyLuaLOVEGenerator"),

    utils.move("EmmyLuaLOVEGenerator/genEmmyAPI.lua", "love-api"),
    utils.mkdir("love-api/api"),

    utils.chain(utils.cd("love-api"), utils.exec("genEmmyAPI.lua")),

    utils.move("love-api/api", "."),

    utils.rmdir("EmmyLuaLOVEGenerator"),
    utils.rmdir("love-api")
}

for _, command in ipairs(batch) do
    os.execute(command)
end
