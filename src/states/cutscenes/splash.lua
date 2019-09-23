return {
    timer = 0,
    fadeoutBegin = 2,
    fadeoutEnd = 2.5,
    timeout = 3,
    fadeAlpha = 1,

    onInit = function(self)
        local fontSize = 128
        local width, height = love.window.getMode()

        self.titleFont = love.graphics.newFont("Air Americana.ttf", fontSize)

        -- upper x, upper y, lower x, lower y of logo text box (not logo!)
        self.ux = 0
        self.uy = (height - fontSize) / 2
        self.lx = width
        self.ly = self.uy + fontSize
    end,

    draw = function(self)
        love.graphics.clear(love.graphics.getBackgroundColor())
        love.graphics.setFont(self.titleFont)
        love.graphics.printf({{255, 255, 255, self.fadeAlpha}, "Fallout-C"}, self.ux, self.uy, self.lx, "center")
    end,

    update = function(self, dt)
        self.timer = self.timer + dt

        self.fadeAlpha = math.max(0, 1 - math.max(0, self.timer - self.fadeoutBegin) / (self.fadeoutEnd - self.fadeoutBegin))
        print(self.fadeAlpha)

        if self.timer > self.timeout then
            transitionGameState(self, mainGameState)
        end
    end,
    
    keypressed = function(self)
        transitionGameState(self, mainGameState)
    end,
}