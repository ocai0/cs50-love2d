Paddle = Class{}
function Paddle:init(height, x, y)
    self.x = x
    self.height = height
    self.thickness = 2
    self.speed = 200
    self.y = y or 0

    self.key = {
        up = 'up',
        down = 'down'
    }
end
function Paddle:update(dt)
    local playerMovementDirection = 0
    if(love.keyboard.isDown(self.key.up)) then playerMovementDirection = -1 end
    if(love.keyboard.isDown(self.key.down)) then playerMovementDirection = 1 end
    self.y = self.y + ((self.speed * dt) * playerMovementDirection)
    if(self.y < 0) then self.y = 0 end
    if(self.y > WINDOW_SIZE.VIRTUAL_HEIGHT - self.height) then self.y = WINDOW_SIZE.VIRTUAL_HEIGHT - self.height end
end
function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.thickness, self.height)
end
function Paddle:setYToTheMiddleOfScreen()
    self.y = (WINDOW_SIZE.VIRTUAL_HEIGHT / 2) - (self.height/2)
end
function Paddle:setSpeed(speed)
    self.speed = speed
end

function Paddle:setDownKey(key)
    self.key.down = key
end
function Paddle:setUpKey(key)
    self.key.up = key
end


return Paddle