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
        controllers = {},

        update = function(self, dt)
            for _, controller in pairs(self.controllers) do
                controller:update(dt, self)
            end
        end,

        process = function(self, eventid)
            for _, controller in pairs(self.controllers) do
                controller:process(eventid, self)
            end
        end,
    }

    -- this gives implicit actor id.
    table.insert(objects, a)
    return a
end
