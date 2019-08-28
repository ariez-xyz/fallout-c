function love.draw()
    for x=0,winGridSize do
        for y=0,winGridSize do
            drawtile(grid, x ,y)
        end
    end
end

