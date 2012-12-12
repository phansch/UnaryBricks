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

function Level:create()
    for i = 0, 10, 1 do
        table.insert(Level, Brick.create(10*(i+10), 10+i*10, 40, 10, "red")
    end

    for _,component in ipairs(Level) do
        holds = component:getvolume()
        print (_,holds)
    end
end

return Level