-- Brick data structure

local Brick = { x, y, width, height, {r, g, b, a} }
Brick.__index = Brick

function Brick.create(x, y, width, height, r, g, b)
    local brick = {}
    setmetatable(brick, Brick)
    brick.x = x
    brick.y = y
    brick.width = width
    brick.height = height
    brick.color = {r, g, b}
    brick.visible = true
    return brick
end

return Brick

