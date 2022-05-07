local menu = {}
local titleFont = ""
function menu:load()
    titleFont = love.graphics.newFont('Scoreboard9x13.ttf', 12)
    printr(titleFont)
end
function menu:update()
end
function menu:draw()
    -- love.graphics.setFont(titleFont)
    local title = 'PONG'
    love.graphics.print(title, WINDOW_SIZE.VIRTUAL_WIDTH / 2)
end
function menu:keypressed(key)
    if(key == 'space') then Gamestate.switch(game, 'player1') end
end
return menu