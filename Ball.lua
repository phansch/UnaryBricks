local Ball = {x, y, size}
Ball.__index = Ball

local speed = 15

function Ball.create()
    local ball = {}
    setmetatable(ball, Ball)
    ball.size = 12
    Ball:resetBall()

    math.randomseed(os.time())
    return ball
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

function Ball:update(paddle, level)
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

        self.ydir = self.ydir * -1

        if(self.x + (self.size / 2 ) > paddle.x + paddle.width / 2) then
            self.xdir = math.abs(self.xdir);
        else
            self.xdir = math.abs(self.xdir) * -1;
        end
    end

    -- check if ball collides with brick
    for i,rows in ipairs(Bricks) do
        for j, brick in ipairs(rows) do
            if(self:checkCollision(brick) and brick.visible) then


                -- Detect the side that was hit and reflect the ball appropriately
                if(self.y >= (brick.y + brick.height)) then
                    self.ydir = 1 -- from below
                    print("from below")
                elseif((self.y+self.size) <= brick.y+5) then
                    self.ydir = -1 -- from above
                    print("from above")
                elseif((self.x + self.size) <= brick.x + 5) then
                    self.xdir = -1 -- from left (something not perfect here)
                    print("from left" .. self.x .. " " .. brick.x)
                elseif(self.x > brick.x) then
                    self.xdir = 1 -- from right
                    print("from right")
                end
                brick.visible = false
            end
        end
    end
end

function Ball:resetBall()
    --reset position
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2

    --set random direction for x
    self.xdir = math.random() >= 0.5 and 1 or -1
    self.ydir = 1 --move down always
end

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

function Ball:checkCollision(brick)
    local ball_x2 = self.x + self.size
    local ball_y2 = self.y + self.size
    local brick_x2 = brick.x + brick.width
    local brick_y2 = brick.y + brick.height

    return self.x < brick_x2 and ball_x2 > brick.x and
        self.y < brick_y2 and ball_y2 > brick.y
end

return Ball