function love.update(dt)
    if love.keyboard.isDown(keyUp) then
        processEvent(events.UP_BUTTON_PUSHED)
    end
    if love.keyboard.isDown(keyDown) then
        processEvent(events.DOWN_BUTTON_PUSHED)
    end
    if love.keyboard.isDown(keyRight) then
        processEvent(events.RIGHT_BUTTON_PUSHED)
    end
    if love.keyboard.isDown(keyLeft) then
        processEvent(events.LEFT_BUTTON_PUSHED)
    end

    updateObjects(dt)
end

function updateObjects(dt)
    for _, object in pairs(objects) do
        object:update(dt)
    end
end

function processEvent(eventid)
    -- currently, every object gets notified of every event. 
    -- TODO: use inverse index and have objects subscribe
    for _, object in pairs(objects) do
        object:process(eventid)
    end
end