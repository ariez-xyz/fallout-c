function love.load()
    -- inferred constants
    renderGridSize = winGridSize - 1

    winBaseSize = renderGridSize * tileSize -- tiles are 8px
    winWidth = winBaseSize * winSizeMult
    winHeight = winBaseSize * winSizeMult

    tileRenderSize = tileSize * winSizeMult

    -- setup
    love.graphics.setDefaultFilter("nearest", "nearest", 16)
    love.window.setMode(winBaseSize * winSizeMult, winBaseSize * winSizeMult, { borderless = winBorderless })
    love.keyboard.setKeyRepeat(true)

    map = {}
    tiles = {}

    loadMap(overworldPath)
end

function loadMap(path, entryX, entryY)
    tiledMap = require(overworldPath) 

    -- parse map data
    for k, layer in pairs(tiledMap.layers) do
        data = {}
        pos = 1
        for i = 1, layer.height do
            datarow = {}
            for j = 1, layer.width do
                table.insert(datarow, layer.data[pos])
                pos = pos + 1
            end
            table.insert(data, datarow)
        end
        table.insert(map, data)
    end
    
    -- parse tileset
    for k, tileset in pairs(tiledMap.tilesets) do
        for k, v in pairs(tileset.tiles) do
            table.insert(tiles, love.graphics.newImage(v.image))
        end
    end

    -- used for bounds checking
    worldSizeX = #map[1]
    worldSizeY = #map[1][1]

    -- set entry point of map
    mapX = (entryX or tiledMap.properties.entryX or 0) * tileRenderSize
    mapY = (entryY or tiledMap.properties.entryY or 0) * tileRenderSize
end