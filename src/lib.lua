function drawmap()
    tx0 = math.floor(mapX / tileRenderSize)
    tx1 = math.floor((mapX + winWidth) / tileRenderSize)
    ty0 = math.floor(mapY / tileRenderSize)
    ty1 = math.floor((mapY + winHeight) / tileRenderSize)

    offsetX = mapX % tileRenderSize
    offsetY = mapY % tileRenderSize

    for x = tx0, tx1 do
        for y = ty0, ty1 do
            tile = getTile(x, y)

            x = x % winGridSize - 1
            y = y % winGridSize - 1

            transform = love.math.newTransform(
                x * tileRenderSize + offsetX,
                y * tileRenderSize + offsetY,
                0,
                winSizeMult,
                winSizeMult
            )

            love.graphics.draw(tile, transform)
        end
    end
end

function getTile(x, y)
    return tiles["g"]
end