--local Level = require 'Level'
local Paddle = require 'Paddle'
local Ball = require 'Ball'
--local Game = require 'Game'

local paddle = Paddle.create()
local ball = Ball.create()

function love.draw()
    paddle:draw()
    ball:draw()
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
