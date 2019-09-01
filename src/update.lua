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

    updateActors(dt)
end

function updateActors(dt)
    for _, v in pairs(actors) do
        v:update(dt)
    end
end