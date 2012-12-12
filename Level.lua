local Game = require 'Game'
local Level = {}
Level.__index = Level

function Level.create()
    local lvl = {}
    setmetatable(lvl, Level)
    return lvl
end

function Level:draw()

end

function Level:update()

end

return Level