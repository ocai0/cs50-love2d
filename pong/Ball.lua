Ball = Class{}

function Ball:init(x, y, size)
    self.size = size
    self.x = x
    self.y = y
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = WINDOW_SIZE.VIRTUAL_WIDTH/2 - self.size/2
    self.y = WINDOW_SIZE.VIRTUAL_HEIGHT/2 - self.size/2
    
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + (self.dx * dt)
    self.y = self.y + (self.dy * dt)
end
function Ball:draw(dt)
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

function Ball:collidesWith(paddle)
    if(self.x > paddle.x + paddle.thickness or paddle.x > self.x + self.size) then return false end
    if(self.y > paddle.y + paddle.height or paddle.y > self.y + self.size) then return false end
    return true
end

return Ball