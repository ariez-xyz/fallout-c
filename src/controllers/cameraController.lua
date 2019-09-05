coords = ...

assert(coords ~= nil, "nil coords table passed to cameraController!")

return newController({
    lagFactor = 0.25,

    -- centers the camera on the passed coords so they're not top left corner
    center = function(val) return val - (winBaseSize * winSizeMult / 2) end,

    process = function(self, eventid, object)
        if eventid == MAP_LOADED then
            cameraX = self.center(coords.x)
            cameraY = self.center(coords.y)
        end
    end,

    update = function(self, dt, object) 
        cameraX = cameraX - (cameraX - self.center(coords.x)) * self.lagFactor
        cameraY = cameraY - (cameraY - self.center(coords.y)) * self.lagFactor
    end,
})
