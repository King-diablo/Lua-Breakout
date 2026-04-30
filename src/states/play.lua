Play = Class { __includes = base }

function Play:init()
    self.paused = false
    self.paddle = paddle()
end

function Play:update(dt)
    if self.paused then
        if love.keyboard.wasPressed("space") then
            self.paused = false
            gSound['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed("space") then
        self.paused = true
        gSound["pause"]:play()
        return
    end

    self.paddle:update(dt)
end

function Play:render()
    self.paddle:render()

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFont['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
