function love.keypressed(key, scancode, isrepeat)
        if key == 'q' then 
        love.event.quit() 
    elseif key == 'b' then 
        w, h, flags = love.window.getMode() 
        flags.borderless = not flags.borderless
        love.window.setMode(w, h, flags)
    end
end

