-- don't touch load order or everything explodes (probably)
require "globals"
require "lib/helpers"
require "objects/object"
require "controllers/controller"
require "load"
require "input"
require "update"
require "draw"

player = require "objects/player"

function exitGame()
    love.event.quit()
end