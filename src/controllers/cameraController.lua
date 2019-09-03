return newController({
    lagFactor = 0.25,

    center = function(val) return val - (winBaseSize * winSizeMult / 2) end,

    process = function(self, eventid, object)
        if eventid == MAP_LOADED then
            cameraX = self.center(object.x)
            cameraY = self.center(object.y)
        end
    end,

    update = function(self, dt, object) 
        cameraX = cameraX - (cameraX - self.center(object.x)) * self.lagFactor
        cameraY = cameraY - (cameraY - self.center(object.y)) * self.lagFactor
    end,
})
