push = require 'push.push'
WINDOW_SIZE = {
    VIRTUAL_WIDTH = 432,
    VIRTUAL_HEIGHT = 432,
    RENDER_HEIGHT = 600,
    RENDER_WIDTH = 800
}
local padding = 0
love.graphics.setDefaultFilter('nearest', 'nearest')
function love.load()
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
        love.graphics.rectangle('fill', padding, WINDOW_SIZE.VIRTUAL_HEIGHT/2, 12, 38)
        love.graphics.rectangle('fill', WINDOW_SIZE.VIRTUAL_WIDTH - padding - 12, WINDOW_SIZE.VIRTUAL_HEIGHT/2, 12, 38)
    push:apply('end')
end

function love.keypressed(key)
    if(key == 'escape') then
        love.event.quit()
    end
end
