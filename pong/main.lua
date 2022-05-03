push = require 'push.push'
WINDOW_SIZE = {
    VIRTUAL_WIDTH = 432,
    VIRTUAL_HEIGHT = 432,
    RENDER_HEIGHT = 600,
    RENDER_WIDTH = 800
}
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
    push:apply('start')
        --code here
        love.graphics.print('just a test')
    push:apply('end')
end

function love.keypressed(key)
    if(key == 'escape') then
        love.event.quit()
    end
end
