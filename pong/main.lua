push = require 'push.push'
Class = require 'class'
require 'Ball'
require 'Paddle'
WINDOW_SIZE = {
    VIRTUAL_WIDTH = 432,
    VIRTUAL_HEIGHT = 432,
    RENDER_HEIGHT = 600,
    RENDER_WIDTH = 800
}
local WINDOW_MARGIN = 0
local paddleHeight = 38
player1 = Paddle(paddleHeight, 0)
player1:setUpKey('up')
player1:setDownKey('down')
player1:setYToTheMiddleOfScreen()
player2 = Paddle(paddleHeight, WINDOW_SIZE.VIRTUAL_WIDTH - (2))
player2:setUpKey('w')
player2:setDownKey('s')
player2:setYToTheMiddleOfScreen()
ball = Ball(WINDOW_SIZE.VIRTUAL_WIDTH / 2, WINDOW_SIZE.VIRTUAL_HEIGHT / 2, 4)
player1Score = 0
player2Score = 0
function love.load()
    love.window.setTitle('Pong')
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
    player1:update(dt)
    -- player 2 movement
    player2:update(dt)
    -- ball movment
    if(gamestate == 'play') then
        ball:update(dt)

        if(ball:collidesWith(player1)) then
            ball.dx = -ball.dx * 1.5
            ball.x = player1.x + 5 -- remove it from inside the paddle
            if(ball.dy < 0) then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if(ball:collidesWith(player2)) then
            ball.dx = -ball.dx * 1.5
            ball.x = player2.x - ball.size -- remove it from inside the paddle
            if(ball.dy < 0) then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if(ball.y <= 0) then
            ball.y = 0
            ball.dy = -ball.dy
        end
        if(ball.y >= WINDOW_SIZE.VIRTUAL_HEIGHT - ball.size) then
            ball.y = WINDOW_SIZE.VIRTUAL_HEIGHT - ball.size
            ball.dy = -ball.dy
        end

        if(ball.x < 0) then
            player2Score = player2Score + 1
            ball:reset()
            gamestate = 'idle'
            servingPlayer = 1
        end
        if(ball.x > WINDOW_SIZE.VIRTUAL_WIDTH) then
            player1Score = player1Score + 1
            ball:reset()
            gamestate = 'idle'
            servingPlayer = 2
        end
        if(player1Score == 3 or player2Score == 3) then
            gamestate = 'done'
            winningPlayer = player1Score == 3 and 1 or 2
        end
    end
    if(gamestate == 'serve') then
        if(servingPlayer == 1) then ball.dx = -math.random(140, 200)
        else ball.dx = math.random(140, 200) end
    end
end
function love.draw()
    love.graphics.setBackgroundColor(40, 40, 40, 255)
    love.graphics.print(gamestate, 0, 0)
    push:apply('start')
        love.graphics.print(player1Score, WINDOW_SIZE.VIRTUAL_WIDTH * .25, 10)
        love.graphics.print(player2Score, WINDOW_SIZE.VIRTUAL_WIDTH * .75, 10)
        if(gamestate == 'done') then
            love.graphics.print("Player " .. winningPlayer .. " wins", WINDOW_SIZE.VIRTUAL_WIDTH / 2, 15)
        end
        player1:draw()
        player2:draw()
        ball:draw()
    push:apply('end')
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function love.keypressed(key)

    if(key == 'escape') then
        love.event.quit()
    end

    if (key == 'enter' or key == 'return') then
        if(gamestate == 'idle') then
            gamestate = 'play'
        elseif(gamestate == 'done') then
            gamestate = 'idle'
            ball:reset()
            player1Score = 0
            player2Score = 0
            servingPlayer = winningPlayer == 1 and 2 or 1
        else
            gamestate = 'idle'
            ball:reset()
        end
    end
end
