-- don't touch load order or everything explodes (probably)
require "globals"
require "lib/helpers"
require "objects/object"
require "controllers/controller"
require "load"
require "input"

-- state tables. each may hold an update and draw method. we have a pointer
-- to the current state that indicates which update/draw methods to call
splash          = require("states/cutscenes/splash")
mainGameState   = require("states/main/game")

player = require "objects/player"

-- taken from https://love2d.org/wiki/love.run with small changes
function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
    local dt = 0
 
	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
                end

                -- allow states to have handlers. love's handlers are still called
                -- also pass self param to state handlers
                if currentGameState[name] then 
                    currentGameState[name](currentGameState,a,b,c,d,e,f)
                end
                love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
		if love.timer then dt = love.timer.step() end
 

		-- Call current state's update and draw
        if currentGameState.update then
            currentGameState:update(dt) 
        end
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
 
			if currentGameState.draw then currentGameState:draw() end
 
			love.graphics.present()
		end
 
		if love.timer then love.timer.sleep(0.001) end
	end
end

function updateObjects (dt)
    for _, object in pairs(objects) do
        object:update(dt)
    end
end

function emitEvent (eventid)
    -- currently, every object gets notified of every event. 
    -- TODO: use inverse index and have objects subscribe. also, buffer events
    -- and call process() in update so that it can be paused
    for _, object in pairs(objects) do
        object:process(eventid)
    end
end

function transitionGameState(fromState, toState)
    if fromState.onExit then fromState:onExit() end
    if toState.onInit then toState:onInit() end
    currentGameState = toState
end

function exitGame()
    love.event.quit()
end
