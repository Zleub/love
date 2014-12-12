inspect = require('inspect')
require('lib')

FPS = {}

function FPS:new(delay)
	self.width = love.window.getWidth()
	self.height = love.window.getHeight()
	self.delay = delay
	self.list = {}

	self.update = function (self, dt)
		self.delay = self.delay - dt
		if self.delay < 0 then
			table.insert(self.list, love.timer.getFPS())
			if #self.list - 1 > self.width / 3 then
				table.remove(self.list, 1)
			end
			self.delay = delay
		end
	end
	self.draw = function (self)
		love.graphics.setColor(255, 255, 255, 100)
		for k,v in pairs(self.list) do
			if v < 30 then love.graphics.setColor(255, 0, 0, 100) end
			love.graphics.rectangle('fill',
				self.width - (k * 3),
				self.height - v,
				3, v)
			if v < 30 then love.graphics.setColor(255, 255, 255, 100) end
		end
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function love.load()
	loveframes = require("lua.loveframes")
	game = require('game'):init()

	FPS:new(1)
end

function love.update(dt)
	FPS:update(dt)
	game:update(dt)
	loveframes.update(dt)
end

function love.draw()
	FPS:draw()
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


