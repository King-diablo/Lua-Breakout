health = Class {}

local fallSpeed = 100
function health:init(brick)
    self.x = brick.x
    self.y = brick.y
    self.isActive = true
    self.paddle = paddle
    self.brick = brick
    self.width = 10
    self.height = 10
end

function health:update(dt)
    local dy = fallSpeed * dt
    self.y = self.y + dy
end

function health:render()
    if self.isActive then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height);
    end
end

function health:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function health:destroy()
    self.isActive = false
end
