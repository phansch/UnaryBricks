local Game = {}
Game.__index = Game

function Game.create()
	local game = {}
	setmetatable(game, Game)
	game.width = love.graphics.getWidth()
	game.height = love.graphics.getHeight()
	game.dt = love.timer.getDelta()
	game.score = 0
	game.lifes = 3
	game.running = false
	game.bricksHit = 0
	return game
end

function Game:update()
	self.dt = love.timer.getDelta()
	if self.lifes == 0 then
		self.running = false
	end

    if self.bricksHit == 100 then
    	self.running = false
    end

end

function Game:draw()
	-- draw lifes
	love.graphics.print("Lifes:"..self.lifes, 10, 10, 0, 1, 1)
end


return Game