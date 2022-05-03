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
    height = 38
}
player2 = {
    x = WINDOW_SIZE.VIRTUAL_WIDTH - (2),
    y = (WINDOW_SIZE.VIRTUAL_HEIGHT / 2) - (38 / 2),
    thickness = 2,
    height = 38
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(WINDOW_SIZE.VIRTUAL_WIDTH, WINDOW_SIZE.VIRTUAL_HEIGHT, WINDOW_SIZE.RENDER_WIDTH, WINDOW_SIZE.RENDER_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end
function love.update(dt)
end
function love.draw()
    love.graphics.setBackgroundColor(40, 40, 40, 255)
    push:apply('start')
        love.graphics.rectangle('fill', player1.x, player1.y, player1.thickness, player1.height)
        love.graphics.rectangle('fill', player2.x, player2.y, player2.thickness, player2.height)
    push:apply('end')
end

function love.keypressed(key)
    if(key == 'escape') then
        love.event.quit()
    end
end
