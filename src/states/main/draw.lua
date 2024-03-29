return {
    draw = function(self)
        love.graphics.clear(love.graphics.getBackgroundColor())

        self:drawMap()

        self:emptyDrawBuffer()
    end,

    -- TODO use transforms?
    emptyDrawBuffer = function(self)
        for _, a in pairs(drawBuffer) do
            love.graphics.draw(a.sprite, a.posX, a.posY, a.rotation, a.sx, a.sy, a.ox, a.oy)
        end

        drawBuffer = {}
    end,

    drawMap = function(self)
        -- (tx, ty) is the top left tile that needs to get drawn
        local tx = math.floor(cameraX / tileRenderSize)
        local ty = math.floor(cameraY / tileRenderSize)

        -- draw offset is required so camera isnt locked to tile grid
        -- and to center image so tiles don't clip in
        local offsetX = cameraX % tileRenderSize - tileRenderSize / 2
        local offsetY = cameraY % tileRenderSize - tileRenderSize / 2

        -- draw origin of tiles is at top left corner by default, this makes rotation difficult
        -- this value is needed to center the origin which allows rotation
        local originOffset = tileSize / 2

        for _, layer in pairs(map) do
            for x = 0, renderGridSize do
                for y = 0, renderGridSize do
                    local tileid, rotation, sx, sy = self:getTileInfo(tx + x, ty + y, layer)

                    transform = love.math.newTransform(
                        x * tileRenderSize - offsetX,   -- x coord
                        y * tileRenderSize - offsetY,   -- y coord
                        rotation,
                        winSizeMult * sx,            -- scale factor * mirroring factor (sx = -1 or 1)
                        winSizeMult * sy,            
                        originOffset,
                        originOffset 
                    )


                    -- draw error sprite for unknown tiles/bullshit values
                    if tileid == UNKNOWN_TILE or tileid >= #sprites then
                        love.graphics.draw(flyweights.missingSprite, transform)

                    -- if tile is in a spritesheet
                    elseif quads[tileid] then
                        love.graphics.draw(sprites[tileid], quads[tileid], transform)

                    -- if its just a single sprite
                    elseif tileid ~= TRANSPARENT_TILE then
                        love.graphics.draw(sprites[tileid], transform)
                    end
                end
            end
        end
    end,

    getTileInfo = function(self, x, y, layer)
        local tileid
        local rotation = 0
        local sx = 1
        local sy = 1

        -- world bounds check
        if 0 < x and x <= worldSizeX and 0 < y and y <= worldSizeY then
            tileid = layer[y][x]

            if checkFlag(DMIRROR_FLAG, tileid) then
                sx = sx * -1
                rotation = math.pi / 2
                tileid = clearFlag(DMIRROR_FLAG, tileid)
            end

            if checkFlag(HMIRROR_FLAG, tileid) then
                sx = sx * -1
                tileid = clearFlag(HMIRROR_FLAG, tileid)
            end

            if checkFlag(VMIRROR_FLAG, tileid) then
                sy = sy * -1
                tileid = clearFlag(VMIRROR_FLAG, tileid)
            end
        else
            tileid = TRANSPARENT_TILE
        end

        return tileid, rotation, sx, sy
    end,
}