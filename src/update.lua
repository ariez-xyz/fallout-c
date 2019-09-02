function love.update(dt)
    if love.keyboard.isDown(keyUp) then
        cameraY = cameraY - moveSpeed
    end
    if love.keyboard.isDown(keyDown)then
        cameraY = cameraY + moveSpeed
    end
    if love.keyboard.isDown(keyRight)then
        cameraX = cameraX + moveSpeed
    end
    if love.keyboard.isDown(keyLeft)then
        cameraX = cameraX - moveSpeed
    end

    updateObjects(dt)
end

function updateObjects(dt)
    for _, object in pairs(objects) do
        object:update(dt)
    end
end