local Ball = {x, y, size}
Ball.__index = Ball

function Ball.create()
    local ball = {}
    setmetatable(ball, Ball)
    ball.size = 12
    ball.speed = 200
    Ball:resetBall()

    return ball
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

function Ball:update(paddle, game, dt)
    self.x = self.x + self.xdir * dt * self.speed
    self.y = self.y + self.ydir * dt * self.speed

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

    -- if self.y > winheight then substract life and reset ball
    if(self.y >= love.graphics.getHeight()) then
        game.lifes = game.lifes - 1
        self:resetBall()
    end

    -- check if ball collides with paddle
    if(self:checkCollision(paddle)) then

        self.ydir = self.ydir * -1

        if(self.x + (self.size / 2 ) > paddle.x + paddle.width / 2) then
            self.xdir = math.abs(self.xdir);
        else
            self.xdir = math.abs(self.xdir) * -1;
        end
    end


    for i,rows in ipairs(Bricks) do
        for j, brick in ipairs(rows) do

            -- check if ball collides with brick
            if(self:checkCollision(brick) and brick.visible) then

                -- Detect the side that was hit and reflect the ball appropriately
                if(self.y >= (brick.y + brick.height)) then
                    self.ydir = 1 -- from below
                elseif((self.y+self.size) <= brick.y+5) then
                    self.ydir = -1 -- from above
                elseif((self.x + self.size) <= brick.x + 5) then
                    self.xdir = -1 -- from left (something not perfect here)
                elseif(self.x > brick.x) then
                    self.xdir = 1 -- from right
                end
                brick.visible = false
                game.bricksHit = game.bricksHit + 1
            end
        end
    end
end

function Ball:resetBall()
    --reset position
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2

    --set random direction for x
    math.randomseed(os.time())
    self.xdir = math.random() >= 0.5 and 1 or -1
    self.ydir = 1 --move down always
end

-- Ball <-> Paddle collision check
function Ball:checkCollision(paddle)
    -- Simple bounding box collision check
    -- source: https://love2d.org/wiki/BoundingBox.lua
    local ball_x2 = self.x + self.size
    local ball_y2 = self.y + self.size
    local paddle_x2 = paddle.x + paddle.width
    local paddle_y2 = paddle.y + paddle.height

    return self.x < paddle_x2 and ball_x2 > paddle.x and
        self.y < paddle_y2 and ball_y2 > paddle.y
end

-- Ball <-> Brick collision check
function Ball:checkCollision(brick)
    local ball_x2 = self.x + self.size
    local ball_y2 = self.y + self.size
    local brick_x2 = brick.x + brick.width
    local brick_y2 = brick.y + brick.height

    return self.x < brick_x2 and ball_x2 > brick.x and
        self.y < brick_y2 and ball_y2 > brick.y
end

return Ball