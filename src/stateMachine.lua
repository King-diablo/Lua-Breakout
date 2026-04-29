stateMachine = Class {}

function stateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }
    self.states = states or {} -- [name] -> [function that returns states]
    self.current = self.empty
end

function stateMachine:change(stateName, enterParams)
    assert(self.states[stateName]) -- state must exist!
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

function stateMachine:update(dt)
    self.current:update(dt)
end

function stateMachine:render()
    self.current:render()
end
