require 'globals'

push = require 'src.libs.push'
Class = require 'src.libs.class'
Gamestate = require 'src.libs.gamestate'

-- Game States
menu = require 'src.game-states.menu'
game = require 'src.game-states.game'


function love.load()
    --START: CONFIG
    love.window.setTitle('Pong')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(WINDOW_SIZE.VIRTUAL_WIDTH, WINDOW_SIZE.VIRTUAL_HEIGHT, WINDOW_SIZE.RENDER_WIDTH, WINDOW_SIZE.RENDER_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    math.randomseed(os.time())
    --END: CONFIG
    
    Gamestate.switch(menu)
    Gamestate.load()
end
function love.update(dt)
    Gamestate.update(dt)
end
function love.draw()
    push:apply('start')
        Gamestate.draw()
    push:apply('end')
end

function love.keypressed(key)
    if(key == 'escape') then love.event.quit() end
    Gamestate.keypressed(key)
end
