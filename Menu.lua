require 'Game'
local Menu = {}
Menu.__index = Menu

function Menu.create()
	local menu = {}
	menu.width = love.graphics.getWidth()
	menu.height = love.graphics.getHeight()
    setmetatable(menu, Menu)
    return menu
end

function Menu:draw()
	love.graphics.print("Press 'Enter' to start the game", self.width/2-100, self.height/2-30)
	love.graphics.print("Press 'Esc' to exit the game", self.width/2-100, self.height/2)
end

return Menu