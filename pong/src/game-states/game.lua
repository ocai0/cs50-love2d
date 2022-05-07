local game = {}

require 'src.classes.Ball'
require 'src.classes.Paddle'

local paddleHeight = 38
player1 = Paddle(paddleHeight, 0)
player2 = Paddle(paddleHeight, WINDOW_SIZE.VIRTUAL_WIDTH - (2))
ball = Ball(WINDOW_SIZE.VIRTUAL_WIDTH / 2, WINDOW_SIZE.VIRTUAL_HEIGHT / 2, 4)
player1Score = 0
player2Score = 0
servingPlayer = math.random(2)
internalState = 'serve' -- 'serve' or 'game'

function game:enter(previous, name)
end

function game:load()
    player1:setUpKey('up')
    player1:setDownKey('down')
    player1:setYToTheMiddleOfScreen()
    player2:setUpKey('w')
    player2:setDownKey('s')
    player2:setYToTheMiddleOfScreen()
end

function game:update(dt)

    if(internalState == 'serve') then
        ball.dx = math.random(140, 240) * servingPlayer
    end

    player1:update(dt)
    player2:update(dt)

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
    
    -- if the ball speeds up too much, it can pass straight through the paddles, so i'm making a collision detection in the places where the paddles are
    if(ball.x < 0) then
        player2Score = player2Score + 1
        ball:reset()
        gamestate = 'serve'
        servingPlayer = 1
    end
    if(ball.x > WINDOW_SIZE.VIRTUAL_WIDTH) then
        player1Score = player1Score + 1
        ball:reset()
        gamestate = 'serve'
        servingPlayer = 2
    end
    if(player1Score == 3 or player2Score == 3) then
        winningPlayer = player1Score == 3 and 1 or 2
        -- Gamestate.switch(victory)
    end
    
    ball:update(dt)
end
function game:draw()
    love.graphics.print(player1Score, WINDOW_SIZE.VIRTUAL_WIDTH * .25, 10)
    love.graphics.print(player2Score, WINDOW_SIZE.VIRTUAL_WIDTH * .75, 10)
    player1:draw()
    player2:draw()
    ball:draw()
end

return game