require("lib/FSM")

-- Disclaimer: I am reading about design patterns as I'm writing this
-- so maybe that explains why this is so overly complicated. 
-- here's to hoping it pays off

-- Intent of all this: 
--     - Actors have multiple FSMs modeling their state
--     - FSMs can influence the actor directly
--     - 

-- initializes "null actor" 
function newActor(actorName, actorSprite, actorProperties)
    a = {
        name = actorName or "",
        sprite = actorSprite or fw.nullSprite,
        properties = actorProperties or {},

        -- allows actors to have state and react to events/be proactive
        -- uses do-nothing fsm by default
        fsms = { newNullFSM() }
    }

    function a:update(dt, actor)
        for _, v in pairs(self.fsms) do
            v:update(dt, actor)
        end
    end

    function a:process(event, actor)
        for _, v in pairs(self.fsms) do
            v:process(event, actor)
        end
    end

    -- this gives implicit actor id.
    table.insert(actors, a)
    return a
end
