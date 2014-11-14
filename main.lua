inspect = require 'inspect'

function love.load()
	loveframes = require("lua.loveframes")

	mainmenu = loveframes.Create('frame')
	mainmenu:SetDraggable(false)
	mainmenu:ShowCloseButton(false)
	mainmenu:Center()

	list = loveframes.Create("list", mainmenu)

	text = loveframes.Create('text', list)
	text:SetSize(5, 5)
	text:SetText('Delemerdes')
	text:Center()

	buttonnew = loveframes.Create('button', list)
	buttonload = loveframes.Create('button', list)
	buttonoption = loveframes.Create('button', list)

	print(inspect(text))

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
