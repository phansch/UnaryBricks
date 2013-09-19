io.stdout:setvbuf("no")
local Level = require 'Level'
local Paddle = require 'Paddle'
local Ball = require 'Ball'
local Game = require 'Game'
local Menu = require 'Menu'

local game = {}
local paddle = {}
local ball = {}
local level = {}
local menu = Menu.create(game)

function love.draw()
    if game.running then
        paddle:draw()
        ball:draw()
        level:draw()
        game:draw()
    else
        -- show menu screen
        menu:draw()
    end

end

function love.update(dt)
    if game.running then
        ball:update(paddle, game, dt)
        game:update()

        if love.keyboard.isDown("a") then
            paddle:update(-1, game) -- move paddle left
        end
        if love.keyboard.isDown("d") then
            paddle:update(1, game) -- move paddle right
        end
    else
        -- handle menu screen input
        if love.keyboard.isDown("return") then
            startGame()
        end
        if love.keyboard.isDown("escape") then
            love.event.quit()
        end
    end
end

function startGame()
    game = Game.create()
    level = Level.create()
    game.running = true
    level:setup()
    paddle = Paddle.create(game)
    ball = Ball.create()

end