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

        -- bounding box of logo text (height given by font size)
        self.x = 0
        self.y = (height - fontSize) / 2
        self.length = width
    end,

    draw = function(self)
        love.graphics.clear(love.graphics.getBackgroundColor())
        love.graphics.setFont(self.titleFont)
        love.graphics.printf({{255, 255, 255, self.fadeAlpha}, "Fallout-C"}, self.x, self.y, self.length, "center")
    end,

    update = function(self, dt)
        self.timer = self.timer + dt

        self.fadeAlpha = math.max(0, 1 - math.max(0, self.timer - self.fadeoutBegin) / (self.fadeoutEnd - self.fadeoutBegin))

        if self.timer > self.timeout then
            transitionGameState(self, mainGameState)
        end
    end,
    
    keypressed = function(self)
        transitionGameState(self, mainGameState)
    end,
}