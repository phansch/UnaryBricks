local Ball = {x, y, xdir, ydir}
Ball.__index = Ball

local speed = 15

function Ball.create()
    local ball = {}
    setmetatable(ball, Ball)
    Ball:resetBall()

    math.randomseed(os.time())
    return ball
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, 10, 100)
end

function Ball:update(paddle)
    self.x = self.x + self.xdir * Game.dt * speed
    self.y = self.y + self.ydir * Game.dt * speed

    -- ball collides with top, left or right
    if(self.y <= 0) then
        self.ydir = 1
    end
    if(self.x <= 0) then
        self.xdir = 1
    end
    if(self.x >= love.graphics.getWidth()) then
        self.xdir = -1
    end

    -- if y > height -> round over
    if(self.y >= love.graphics.getHeight()) then
        -- one life less
    end

    -- check if ball collides with paddle
    if(self:checkCollision(paddle)) then
        print('paddle.x: ' .. paddle.x .. '; self.x: ' .. self.x)
        self.ydir = -1
    end
end

function Ball:resetBall()
    --reset position
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2

    --set random direction
    self.xdir = math.random() >= 0.5 and 1 or -1
    self.ydir = 1
end

function Ball:checkCollision(paddle)
    -- Simple bounding box collision check
    -- source: https://love2d.org/wiki/BoundingBox.lua
    local ball_x2 = self.x + 10
    local ball_y2 = self.y + 10
    local paddle_x2 = paddle.x + paddle.width
    local paddle_y2 = paddle.y + paddle.height

    return self.x < paddle_x2 and ball_x2 > paddle.x and
        self.y < paddle_y2 and ball_y2 > paddle.y
end

return Ball