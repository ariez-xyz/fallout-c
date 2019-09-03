-- basically a FSM with memory and an update function called from the game loop
-- that is constructed from a list of states, but can also be stateless

-- state interface (none are required):
    -- state:enter(prevState, object) - called upon entering state
    -- state:update(dt, object) - called if state is currently active
    -- state:process(eventid, object) - called if state is currently active
-- update and process may return another sstate to transition to

-- states can be controllers because the state interface is a subset of the controller
-- interface! implementing generalized transitions in the controller-state's 
-- update/process methods enables hierarchical FSM functionality.

function newController(initialState, stateTable)
    controller = {
        states = stateTable, -- array of states which are themselves tables
        currentState = initialState,

        -- called with each iteration of game loop, delegates to current state
        update = function(self, dt, object) 
            if self.currentState.update ~= nil then
                s = self.currentState:update(dt, object) 
                if s then self:transition(s, object) end
            end
        end,

        -- called by external events. *blocking - buffer events?*
        process = function(self, eventid, object) 
            if self.currentState.process ~= nil then
                s = self.currentState:process(eventid, object) 
                if s then self:transition(s, object) end
            end
        end,

        transition = function(self, toState, object) 
            assert(toState ~= nil and type(toState) == 'table',
                "bad state passed to transition()")
            prevState = self.currentState
            self.currentState = toState

            if self.currentState.enter ~= nil then
                self.currentState:enter(prevState, object)
            end
        end
    }

    return controller
end