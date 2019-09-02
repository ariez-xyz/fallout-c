-- Disclaimer: I am reading about design patterns as I'm writing this
-- so maybe that explains why this is so overly complicated. 
-- here's to hoping it pays off

-- Intent of all this: 
--     - Actors may have multiple FSMs modeling their state
--     - each FSM can influence its actor directly
--     - the FSMs arent' tightly coupled to actors. They are the actor

function newActor(actorName)
    a = {
        name = actorName or "",

        -- allows actors to have state/ai
        controllers = {}
    }

    function a:update(dt)
        for _, controller in pairs(self.controllers) do
            controller:update(dt, self)
        end
    end

    function a:process(event)
        for _, controller in pairs(self.controllers) do
            controller:process(event, self)
        end
    end

    -- this gives implicit actor id.
    table.insert(objects, a)
    return a
end
