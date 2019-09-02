-- for simplicity
local counter = { val = 0, incAndGet = function(self) self.val = self.val + 1; return self.val end } 

return {
    DOWN_BUTTON_PUSHED = counter:incAndGet(),
    UP_BUTTON_PUSHED = counter:incAndGet(),
    LEFT_BUTTON_PUSHED = counter:incAndGet(),
    RIGHT_BUTTON_PUSHED = counter:incAndGet(),
}