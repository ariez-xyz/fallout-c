function love.keypressed(key, scancode, isrepeat)
    if     key == 'escape' then love.event.quit() 
    elseif key == 'f1' then 
        w, h, flags = love.window.getMode() 
        flags.borderless = not flags.borderless
        love.window.setMode(w, h, flags)
    end
end

