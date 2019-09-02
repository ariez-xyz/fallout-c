-- don't touch load order or everything explodes
require "lib/helpers"
require "objects/object"
require "load"
require "input"
require "update"
require "draw"
require "objects/player"

function exitGame()
    love.event.quit()
end