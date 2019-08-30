function love.draw()
    drawmap()
end

function drawmap()
    tx = math.floor(mapX / tileRenderSize)
    ty = math.floor(mapY / tileRenderSize)

    offsetX = mapX % tileRenderSize
    offsetY = mapY % tileRenderSize

    for x = 0, renderGridSize do
        for y = 0, renderGridSize do
            for _, layer in pairs(map) do
                tileid = getTileId(tx + x, ty + y, layer)

                if tileid > FLAG_180_DEGREE then
                    ox = tileSize
                    oy = tileSize
                    rotation = math.pi
                    tileid = tileid - FLAG_180_DEGREE

                elseif tileid > FLAG_90_DEGREE then
                    ox = 0
                    oy = tileSize
                    rotation = math.pi / 2
                    tileid = tileid - FLAG_90_DEGREE

                elseif tileid > FLAG_270_DEGREE then
                    ox = tileSize
                    oy = 0
                    rotation = 3 * math.pi / 2
                    tileid = tileid - FLAG_270_DEGREE 

                elseif tileid > FLAG_0_DEGREE then 
                    rotation = 0
                    ox = 0
                    oy = 0
                end

                if tileid ~= UNKNOWN_TILE then
                    transform = love.math.newTransform(
                        x * tileRenderSize - offsetX,
                        y * tileRenderSize - offsetY,
                        rotation,
                        winSizeMult,
                        winSizeMult,
                        ox,
                        oy
                    )

                    love.graphics.draw(spritesheet, tiles[tileid], transform)
                end
            end
        end
    end
end

function getTileId(x, y, layer)
    if 0 < x and x <= worldSizeX and 0 < y and y <= worldSizeY then
        return layer[y][x]
    else
        return UNKNOWN_TILE
    end
end
