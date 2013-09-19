local Paddle = {}
Paddle.__index = Paddle

function Paddle.create(game)
    local paddle = {}
    setmetatable(paddle, Paddle)
    paddle.x = game.width / 2
    paddle.y = game.height - 30
    paddle.width = 100
    paddle.height = 20
    paddle.speed = 300
    return paddle
end

function Paddle:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Paddle:update(dir, game)
    local moveX = self.x + dir * game.dt * self.speed

    --bounds checking
    if(moveX < love.graphics.getWidth()-self.width-5 and moveX > 5) then
        self.x = moveX
    end
end

return Paddle