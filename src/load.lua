function love.load()
    -- inferred constants
    winBaseSize = winGridSize * tileSize -- tiles are 8px

    -- setup
    love.graphics.setDefaultFilter("nearest", "nearest", 16)
    love.window.setMode(winBaseSize * winSizeMult, winBaseSize * winSizeMult, { borderless = winBorderless })

    -- assets
    grid = love.graphics.newImage("assets/gridbase.png")
end
