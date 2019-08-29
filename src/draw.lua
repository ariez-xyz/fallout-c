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
                tile = getTile(tx + x, ty + y, layer)

                if tile ~= nil then
                    transform = love.math.newTransform(
                        x * tileRenderSize - offsetX,
                        y * tileRenderSize - offsetY,
                        0,
                        winSizeMult,
                        winSizeMult
                    )

                    love.graphics.draw(tile, transform)
                end
            end
        end
    end
end

function getTile(x, y, layer)
    if 0 < x and x <= worldSizeX and 0 < y and y <= worldSizeY then
        return tiles[tonumber(layer[y][x])]
    else
        return nil
    end
end
