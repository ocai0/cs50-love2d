--imports goes here
setSharpGraphics = require 'setSharpGraphics'

function love.load()
    setSharpGraphics()
    local updateFunctionForPlayer1 = function(dt)

    end
    local updateFunctionForPlayer2 = function(dt)

    end
    player1 = square(12, 12, 8, 8, updateFunctionForPlayer1)
    player2 = square(112, 122, 8, 8, updateFunctionForPlayer2, function() end, {1, 0, 0, 1})
end

function love.update(dt)
    player1:update(dt)
    player2:update(dt)
end

function love.draw()
    player1:draw()
    player2:draw()
end

function square(x, y, width, height, updateFunction, initFunction, colorOfTheSquare)
    local newSquare = {
        x = x,
        y = y,
        width = width,
        height = height,
        init = initFunction,
        update = updateFunction,
        draw = function(this)
            if(colorOfTheSquare ~= nil) then
                love.graphics.setColor(colorOfTheSquare)
                love.graphics.rectangle('fill', this.x, this.y, this.width, this.height)
                love.graphics.reset()
                return
            end
            love.graphics.rectangle('fill', this.x, this.y, this.width, this.height)
        end
    }
    return newSquare
end
