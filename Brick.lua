

local Brick = { x, y, width, height, color }
Brick.__index = Brick

function Brick.create(x, y, width, height, color)
    brick = {}
    setmetatable(brick, Brick)
    brick.x = x
    brick.y = y
    brick.width = width
    brick.height = height
    brick.color = color
    return brick
end
return Brick

