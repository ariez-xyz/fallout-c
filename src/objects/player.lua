local p = newObject("player")

p.data.coords = {
    x = cameraX,
    y = cameraY,
}

p.controllers = {
    love.filesystem.load("controllers/controlable.lua")(p.data.coords),
    love.filesystem.load("controllers/cameraController.lua")(p.data.coords),
}

return p