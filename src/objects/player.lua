local p = newActor("player")

-- TODO this is tightly coupled - add data table to each actor maybe?
p.x = cameraX
p.y = cameraY

p.controllers = {
    love.filesystem.load("controllers/controlable.lua")(),
    love.filesystem.load("controllers/cameraController.lua")(),
}

return p