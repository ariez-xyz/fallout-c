-- basically a FSM with memory and an update function called from the game loop
-- that is constructed from a list of states, but can also be stateless

-- state interface (none are required):
    -- state:enter(prevState, actor) - called upon entering state
    -- state:update(dt, actor) - called if state is currently active
    -- state:process(event, actor) - called if state is currently active

-- states can be controllers because the state interface is a subset of the controller
-- interface! implementing generalized transitions in the controller-state's 
-- update/process methods enables hierarchical FSM functionality.

function newController(initialState, stateTable)
    assert(type(stateTable) == 'table' and len(stateTable) >= 1, 
           "empty state table passed to newController()")

    controller = {
        states = stateTable, -- array of states which are themselves tables
        currentState = initialState,
    }

    -- called with each iteration of game loop, delegates to current state
    function controller:update(dt, actor) 
        if self.currentState.update ~= nil then
            self.currentState:update(dt, actor) 
        end
    end

    -- called by external events. *blocking - buffer events?*
    function controller:process(event, actor) 
        if self.currentState.process ~= nil then
            s = self.currentState:process(event, actor) 
            if s then self:transition(s, actor) end
        end
    end

    function controller:transition(toState, actor) 
        assert(toState ~= nil and type(toState) == 'table',
               "bad state passed to transition()")
        prevState = self.currentState
        self.currentState = toState

        if self.currentState.enter ~= nil then
            self.currentState:enter(prevState, actor)
        end
    end

    return controller
end