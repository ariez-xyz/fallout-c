-- initializes "null actor" 
function newActor()
    a = {
        name = ""
        ai = function() end,
        sprite = love.graphics.newText(textFont)
        state = {}
    }

    -- this gives implicit actor id.
    table.insert(actors, a)
    return a
end
