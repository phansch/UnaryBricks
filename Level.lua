local Game = require 'Game'
local Brick = require 'Brick'
local Level = {}
Bricks = {}
Level.__index = Level

function Level.create()
    local lvl = {}
    setmetatable(lvl, Level)
    return lvl
end

function Level:draw()
    for i,rows in ipairs(Bricks) do
        for j, brick in ipairs(rows) do
            if(brick.visible) then
                love.graphics.setColor(brick.color)
                love.graphics.rectangle("fill", brick.x, brick.y, brick.width, brick.height)
            end
        end
    end
end

function Level:update()

end

function Level:setup()
    for i=1,10 do
        Bricks[i] = {}     -- create a new row
        for j=1,10 do
            x = 10 + i * 45
            y = 10 + j * 20
            Bricks[i][j] = Brick.create(x, y, 40, 15, math.random(255), math.random(255), math.random(255))
        end
    end
end

return Level