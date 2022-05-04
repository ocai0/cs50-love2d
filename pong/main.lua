
push = require 'push.push'
WINDOW_SIZE = {
    VIRTUAL_WIDTH = 432,
    VIRTUAL_HEIGHT = 432,
    RENDER_HEIGHT = 600,
    RENDER_WIDTH = 800
}
local WINDOW_MARGIN = 0
player1 = {
    x = 0,
    y = (WINDOW_SIZE.VIRTUAL_WIDTH / 2) - (38 / 2),
    thickness = 2,
    height = 38,
    speed = 200
}
player2 = {
    x = WINDOW_SIZE.VIRTUAL_WIDTH - (2),
    y = (WINDOW_SIZE.VIRTUAL_HEIGHT / 2) - (38 / 2),
    thickness = 2,
    height = 38,
    speed = 200
}

ball = {
    size = 4,
    x = WINDOW_SIZE.VIRTUAL_WIDTH / 2,
    y = WINDOW_SIZE.VIRTUAL_HEIGHT / 2,
    dx = math.random(2) == 1 and 100 or -100,
    dy = math.random(-50, 50)
}
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(WINDOW_SIZE.VIRTUAL_WIDTH, WINDOW_SIZE.VIRTUAL_HEIGHT, WINDOW_SIZE.RENDER_WIDTH, WINDOW_SIZE.RENDER_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    math.randomseed(os.time())
    gamestate = 'idle'
end
function love.update(dt)
    -- player 1 movement
    local player1MovementDirection = 0
    if(love.keyboard.isDown('w')) then player1MovementDirection = -1 end
    if(love.keyboard.isDown('s')) then player1MovementDirection = 1 end
    player1.y = player1.y + ((player1.speed * dt) * player1MovementDirection)
    if(player1.y < 0) then player1.y = 0 end
    if(player1.y > WINDOW_SIZE.VIRTUAL_HEIGHT - player1.height) then player1.y = WINDOW_SIZE.VIRTUAL_HEIGHT - player1.height end
    -- player 2 movement
    local player2MovementDirection = 0
    if(love.keyboard.isDown('up')) then player2MovementDirection = -1 end
    if(love.keyboard.isDown('down')) then player2MovementDirection = 1 end
    player2.y = player2.y + ((player2.speed * dt) * player2MovementDirection)
    if(player2.y < 0) then player2.y = 0 end
    if(player2.y > WINDOW_SIZE.VIRTUAL_HEIGHT - player2.height) then player2.y = WINDOW_SIZE.VIRTUAL_HEIGHT - player2.height end

    -- ball movment
    if(gamestate == 'play') then
        ball.x = ball.x + (ball.dx * dt)
        ball.y = ball.y + (ball.dy * dt)
    end


end
function love.draw()
    love.graphics.setBackgroundColor(40, 40, 40, 255)
    push:apply('start')
        love.graphics.rectangle('fill', player1.x, player1.y, player1.thickness, player1.height)
        love.graphics.rectangle('fill', player2.x, player2.y, player2.thickness, player2.height)
        love.graphics.rectangle('fill', ball.x, ball.y, ball.size, ball.size)
    push:apply('end')
end

function love.keypressed(key)
    if(key == 'escape') then
        love.event.quit()
    elseif (key == 'enter' or key == 'return') then
        if(gamestate == 'idle') then
            gamestate = 'play'
        else
            gamestate = 'idle'
            ball.x = WINDOW_SIZE.VIRTUAL_WIDTH/2 - ball.size/2
            ball.y = WINDOW_SIZE.VIRTUAL_HEIGHT/2 - ball.size/2
            
            ball.dx = math.random(2) == 1 and 100 or -100
            ball.dy = math.random(-50, 50)
        end
    end
end
