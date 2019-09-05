coords = ...

assert(coords ~= nil, "nil coords table passed to controlable!")

return newController({
    dx = 0,
    dy = 0,

    -- without this, moving diagonally is faster than moving
    -- along a single axis. returns: the point where a line 
    -- thru (0,0) and (x,y) and the unit circle intersect.
    -- I have no clue why this works btw. I suck at trig
    normalize = function(x, y) 
        if x == 0 and y == 0 then return x, y end

        local magnitude = math.sqrt(x^2 + y^2)
        local theta = math.asin(x / magnitude)

        return math.sin(theta), math.sgn(y) * math.cos(theta)
    end,

    -- buffer events into local vars, then process at once in 
    -- update()... had obscure bug because events were processed
    -- atomically. Better to stick with this model in general
    process = function(self, eventid)
        if eventid == events.UP_BUTTON_PUSHED then
            self.dy = self.dy - 1
        elseif eventid == events.DOWN_BUTTON_PUSHED then
            self.dy = self.dy + 1
        elseif eventid == events.LEFT_BUTTON_PUSHED then
            self.dx = self.dx - 1
        elseif eventid == events.RIGHT_BUTTON_PUSHED then
            self.dx = self.dx + 1
        end
    end,

    update = function(self, dt)
        self.dx, self.dy = self.normalize(self.dx, self.dy)

        coords.x = coords.x + (self.dx * moveSpeed * dt)
        coords.y = coords.y + (self.dy * moveSpeed * dt)

        self.dx = 0
        self.dy = 0
    end
})