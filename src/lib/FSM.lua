if fw == nil then fw = {} end
fw.nullStateTable = { state = {} }

-- this defines the state interface
function fw.nullStateTable.state:enter(prevState, actor) end
function fw.nullStateTable.state:update(dt, actor) end
function fw.nullStateTable.state:process(event, actor) end

function newFSM(stateTable, initialState)
    assert(type(stateTable) == 'table' and len(stateTable) >= 1, 
           "empty state table passed to newFSM()")

    fsm = {
        states = stateTable, -- array of states which are themselves tables
        currentState = initialState
    }

    function fsm:update(dt, actor) 
        self.currentState:update(dt, actor) 
    end

    function fsm:transition(toState, actor) 
        prevState = self.currentState
        self.currentState = toState
        toState:enter(prevState, actor)
    end

    function fsm:process(event, actor) 
        s = self.currentState:process(event, actor) 
        if s then self:transition(s, actor) end
    end

    return fsm
end

function newNullFSM()
    return newFSM(fw.nullStateTable, fw.nullStateTable.state)
end