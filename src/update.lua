function love.update()
    if love.keyboard.isDown(keyUp) then
        mapY = mapY + moveSpeed
    end
    if love.keyboard.isDown(keyDown)then
        mapY = mapY - moveSpeed
    end
    if love.keyboard.isDown(keyLeft)then
        mapX = mapX + moveSpeed
    end
    if love.keyboard.isDown(keyRight)then
        mapX = mapX - moveSpeed
    end
end

