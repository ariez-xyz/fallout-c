return newController({
    process = function(self, eventid, object)
        if eventid == events.UP_BUTTON_PUSHED then
            object.y = object.y - moveSpeed
        elseif eventid == events.DOWN_BUTTON_PUSHED then
            object.y = object.y + moveSpeed
        elseif eventid == events.LEFT_BUTTON_PUSHED then
            object.x = object.x - moveSpeed
        elseif eventid == events.RIGHT_BUTTON_PUSHED then
            object.x = object.x + moveSpeed
        end
    end
})