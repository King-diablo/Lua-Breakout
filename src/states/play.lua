Play = Class { __includes = base }

function Play:init()
    self.paused = false
    self.paddle = paddle()
    -- initialize ball with skin #1; different skins = different sprites
    self.ball = Ball(1)

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    -- give ball position in the center
    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42
    self.bricks = levelMaker.createMap()
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
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        -- reverse Y velocity if collision detected between paddle and ball
        self.ball.dy = -self.ball.dy
        gSound['paddle-hit']:play()
    end
    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collides(brick) then
            brick:hit()
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function Play:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
    end
    self.paddle:render()
    self.ball:render()

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFont['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
