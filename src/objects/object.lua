-- Disclaimer: I am reading about design patterns as I'm writing this
-- so maybe that explains why this is so weird
-- here's to hoping it pays off

function newObject(objectName)
    o = {
        name = objectName or "unnamed",

        -- gives actors life
        controllers = {},

        data = {},

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
    table.insert(objects, o)
    return o
end
