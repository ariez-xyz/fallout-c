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
    loadMap("overworld")

    flyweights = {
        missingSprite = love.graphics.newImage("assets/missingsprite.png"),
    }

    -- start the game
    transitionGameState({}, splash)
end

-- loads map data and tiles into map and tiles tables
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
    
    -- parse tilesets
    for _, tileset in pairs(tiledMap.tilesets) do

        -- tileset based on spritesheet
        if tileset.image then
            local spritesheet = love.graphics.newImage(tileset.image)

            for j = 0, tileset.imageheight - 1, tileset.tileheight + tileset.spacing do -- -1 because indices are inclusive...
                for i = 0, tileset.imagewidth - 1, tileset.tilewidth + tileset.spacing do -- so this might break 1-pixel tiles :)
                    table.insert(sprites, spritesheet)
                    quads[#sprites] = love.graphics.newQuad(i, j, tileset.tilewidth, tileset.tileheight, tileset.imagewidth, tileset.imageheight)
                end
            end

        -- tileset based on collection of sprites
        else
            for _, tile in pairs(tileset.tiles) do
                table.insert(sprites, love.graphics.newImage(tile.image))
            end
        end

        for _, tile in pairs(tileset.tiles) do
            if tile.id and tile.type then
                terrain[tile.id] = tile.type
            end
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