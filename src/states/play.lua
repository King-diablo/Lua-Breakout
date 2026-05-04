Play = Class { __includes = base }

function Play:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.level = params.level
    self.highScores = params.highScores

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
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
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy
        local isPaddleMovingLeft = self.paddle.dx < 0
        local isPaddleMovingRight = self.paddle.dx > 0
        local paddleCenter = self.paddle.x + self.paddle.width / 2

        local startingBounceDX = 50
        local bouncingMultiplier = 8

        if self.ball.x < paddleCenter and isPaddleMovingLeft then
            local ballOffset = paddleCenter - self.ball.x
            self.ball.dx = -startingBounceDX - bouncingMultiplier * ballOffset
        elseif self.ball.x > paddleCenter and isPaddleMovingRight then
            local ballOffset = self.ball.x - paddleCenter
            self.ball.dx = startingBounceDX + bouncingMultiplier * ballOffset
        end
        gSound['paddle-hit']:play()
    end

    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collides(brick) then
            self.score = self.score + (brick.tier * 200 + brick.color * 25)
            brick:hit()

            if self:checkVictory() then
                gSound["victory"]:play()

                gStateMachine:change("victory", {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    ball = self.ball,
                    highScores = self.highScores
                })
            end
            local BALL_RADIUS = 4
            local BRICK_W, BRICK_H = brick.width, brick.height

            local cxB, cyB = brick.x + BRICK_W / 2, brick.y + BRICK_H / 2
            local cxb, cyb = self.ball.x + BALL_RADIUS, self.ball.y + BALL_RADIUS

            local ox = cxB - cxb
            local oy = cyB - cyb

            local px = BRICK_W / 2 + BALL_RADIUS - math.abs(ox)
            local py = BRICK_H / 2 + BALL_RADIUS - math.abs(oy)

            if px < py then
                self.ball.dx = -self.ball.dx
                self.ball.x = self.ball.x + (ox > 0 and -px or px)
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = self.ball.y + (oy > 0 and -py or py)
            end

            self.ball.dy = self.ball.dy * 1.02
            break
        end
    end

    if self.ball.y >= VIRTUAL_HEIGHT then
        self.health = self.health - 1
        gSound["hurt"]:play()

        if self.health <= 0 then
            gStateMachine:change("game-over", {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change("serve", {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                level = self.level,
                highScores = self.highScores
            })
        end
    end
    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end


function Play:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
    end
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end
    self.paddle:render()
    self.ball:render()

    renderScore(self.score)
    renderHealth(self.health)
    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFont['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function Play:checkVictory()
    for key, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end
    end
    return true
end
