function love.load()
    -----------
    -- setup --
    -----------
    love.graphics.setDefaultFilter("nearest", "nearest", 16)
    love.window.setMode(winBaseSize * winSizeMult, winBaseSize * winSizeMult, { borderless = winBorderless })
    love.keyboard.setKeyRepeat(true)

    ------------
    -- assets --
    ------------
    loadMap("src/overworld")

    flyweights = {
        missingSprite = love.graphics.newImage("assets/missingsprite.png"),
    }

    -- start the game
    transitionGameState({}, splash)
end

function loadMap(path, entryX, entryY)
    local tiledMap = require(path) 

    -- parse map data
    for k, layer in pairs(tiledMap.layers) do
        if layer.type == "tilelayer" then
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
        elseif layer.type == "objectgroup" then
            print("object groups not supported! ignoring...")
        end
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
    player.x = (entryX or tiledMap.properties.entryX or 0) * tileRenderSize
    player.y = (entryY or tiledMap.properties.entryY or 0) * tileRenderSize

    emitEvent(MAP_LOADED)
end