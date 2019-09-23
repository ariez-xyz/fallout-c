return {
    update = function(self, dt)
        updateObjects(dt)

        -- TODO handle input better
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
    end,
}