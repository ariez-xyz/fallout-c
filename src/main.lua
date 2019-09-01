-- don't touch load order or everything explodes
require "lib/helpers"
require "actors/baseActor"
require "load"
require "input"
require "update"
require "draw"
require "actors/player"

function exitGame()
    love.event.quit()
end