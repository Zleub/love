function love.load()
	loveframes = require("lua.loveframes")

	require('mainmenu')

end

function love.update(dt)
	loveframes.update(dt)
end

function love.draw()
	loveframes.draw()

end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end
