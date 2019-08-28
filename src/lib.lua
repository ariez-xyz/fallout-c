function drawtile(tile, x, y) -- create transform
    if 0 <= x and x <= winGridSize and 0 <= y and y <= winGridSize then
        love.graphics.draw(tile, love.math.newTransform(x * tileSize * winSizeMult, y * tileSize * winSizeMult, 0, winSizeMult, winSizeMult))
    end
end

