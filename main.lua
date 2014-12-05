inspect = require('inspect')
require('lib')

function love.load()
	loveframes = require("lua.loveframes")
	game = require('game'):init()
end

function love.update(dt)
	game:update(dt)
	-- print(loveframes.GetState())
	loveframes.update(dt)
end

function love.draw()
	love.graphics.print(love.timer.getFPS(), 0, love.window.getHeight() - 20)
	game:draw()
	loveframes.draw()
end

function love.mousepressed(x, y, button)
	game:mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	game:mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	game:keypressed(key, unicode)
	loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end


