--local Level = require 'Level'
local Paddle = require 'Paddle'
local Ball = require 'Ball'
--local Game = require 'Game'

local paddle = Paddle.create()
local ball = Ball.create()
local shape

function love.load()
    world = love.physics.newWorld(650, 650)
    world:setGravity(0,700)
    --world:setMeter(64)

    body = love.physics.newBody(world, 650/2, 650/2, 0, 0)
    shape = love.physics.newCircleShape(50, 50, 20)

    love.graphics.setBackgroundColor(255, 255, 255, 255)
    love.graphics.setMode(650, 650, false, true, 0)
end


function love.draw()
    paddle:draw()
    ball:draw()

    X1, Y1, X2, Y2, X3, Y3, X4, Y4 = shape:getBoundingBox()

    love.graphics.setColor(0,0,0,255)

    love.graphics.print("X1, Y1", X1, Y1)
    love.graphics.print("X2, Y2", X2, Y2)
    love.graphics.print("X3, Y3", X3, Y3)
    love.graphics.print("X4, Y4", X4, Y4)
end

function love.update()
    ball:update(paddle)

    if love.keyboard.isDown("a") then
        paddle:update(-1) -- move paddle left
    end
    if love.keyboard.isDown("d") then
        paddle:update(1) -- move paddle right
    end
end
