function love.load()
    ----------------------
    -- global variables --
    ----------------------
    map = {}
    tiles = {}
    actors = {}

    spritesheet = 0

    worldSizeX = 0
    worldSizeY = 0

    cameraX = 0
    cameraY = 0

    -------------------
    -- magic numbers --
    -------------------
    TRANSPARENT_TILE = 0 -- probably better not to change as this is used by Tiled
    UNKNOWN_TILE = -1 -- used when screen scrolls out of bounds etc., drawn as transparent

    DMIRROR_FLAG = 29
    VMIRROR_FLAG = 30
    HMIRROR_FLAG = 31

    ------------------------
    -- inferred constants --
    ------------------------
    renderGridSize = winGridSize - 1

    winBaseSize = renderGridSize * tileSize -- tiles are 8px
    winWidth = winBaseSize * winSizeMult
    winHeight = winBaseSize * winSizeMult

    tileRenderSize = tileSize * winSizeMult

    -----------
    -- setup --
    -----------
    love.graphics.setDefaultFilter("nearest", "nearest", 16)
    love.window.setMode(winBaseSize * winSizeMult, winBaseSize * winSizeMult, { borderless = winBorderless })
    love.keyboard.setKeyRepeat(true)

    ------------
    -- assets --
    ------------
    loadMap(overworldPath)

    textFont = love.graphics.newFont(textFont, 48)

    if fw == nil then fw = {} end
    fw.missingSprite = love.graphics.newImage("assets/missingsprite.png")
    fw.nullSprite = love.graphics.newText(textFont)

    testActor = newActor("brah")
end

function loadMap(path, entryX, entryY)
    local tiledMap = require(overworldPath) 

    -- parse map data
    for k, layer in pairs(tiledMap.layers) do
        local data = {}
        local pos = 1
        for i = 1, layer.height do
            local datarow = {}
            for j = 1, layer.width do
                table.insert(datarow, layer.data[pos])
                pos = pos + 1
            end
            table.insert(data, datarow)
        end
        table.insert(map, data)
    end
    
    -- parse tileset
    if #tiledMap.tilesets > 1 then print("WARNING: ignoring all but first tileset - only one tileset per map supported") end
    local tileset = tiledMap.tilesets[1]

    spritesheet = love.graphics.newImage(tileset.image)
    for j = 0, tileset.imageheight, tileset.tileheight + tileset.spacing do
        for i = 0, tileset.imagewidth, tileset.tilewidth + tileset.spacing do
            table.insert(tiles, love.graphics.newQuad(i, j, tileset.tilewidth, tileset.tileheight, tileset.imagewidth, tileset.imageheight))
        end
    end

    -- used for bounds checking
    worldSizeX = #map[1]
    worldSizeY = #map[1][1]

    -- set entry point of map
    cameraX = (entryX or tiledMap.properties.entryX or 0) * tileRenderSize
    cameraY = (entryY or tiledMap.properties.entryY or 0) * tileRenderSize
end