function love.update(dt)
    if love.keyboard.isDown(keyUp) then
        emitEvent(events.UP_BUTTON_PUSHED)
    end
    if love.keyboard.isDown(keyDown) then
        emitEvent(events.DOWN_BUTTON_PUSHED)
    end
    if love.keyboard.isDown(keyRight) then
        emitEvent(events.RIGHT_BUTTON_PUSHED)
    end
    if love.keyboard.isDown(keyLeft) then
        emitEvent(events.LEFT_BUTTON_PUSHED)
    end

    updateObjects(dt)
end

function updateObjects(dt)
    for _, object in pairs(objects) do
        object:update(dt)
    end
end

function emitEvent(eventid)
    -- currently, every object gets notified of every event. 
    -- TODO: use inverse index and have objects subscribe. also, buffer events
    for _, object in pairs(objects) do
        object:process(eventid)
    end
end