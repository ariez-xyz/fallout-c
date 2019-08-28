function love.load()
    -- inferred constants
    renderGridSize = winGridSize - 1

    winBaseSize = renderGridSize * tileSize -- tiles are 8px
    winWidth = winBaseSize * winSizeMult
    winHeight = winBaseSize * winSizeMult

    tileRenderSize = tileSize * winSizeMult

    -- global constants
    mapX = 0
    mapY = 0

    -- setup
    love.graphics.setDefaultFilter("nearest", "nearest", 16)
    love.window.setMode(winBaseSize * winSizeMult, winBaseSize * winSizeMult, { borderless = winBorderless })
    love.keyboard.setKeyRepeat(true)

    maprow = {}
    for i=1,winGridSize do
        table.insert(maprow, "g")
    end
    map = {}
    for i=1,winGridSize do
        table.insert(map, maprow)
    end

    -- assets
    tiles = {
        g = love.graphics.newImage("/assets/gridbase.png")
    }
end
