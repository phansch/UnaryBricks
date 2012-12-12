local Game = require 'Game'
local Paddle = { x, y, width }
Paddle.__index = Paddle

local height
local speed = 20


function Paddle.create()
    local paddle = {}
    setmetatable(paddle, Paddle)
    paddle.x = Game.width / 2
    paddle.y = Game.height - 30
    paddle.width = 100
    paddle.height = 20
    return paddle
end

function Paddle:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Paddle:update(dir)
    local moveX = self.x + dir * Game.dt * speed

    --bounds checking
    if(moveX < love.graphics.getWidth()-self.width-5 and moveX > 5) then
        self.x = moveX
    end
end

return Paddle