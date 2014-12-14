local game = {}

function game:require_all()
end

-- UPDATE & COLLECT

function game:collect()
	self.collected = {}

	for k,v in pairs(self) do
		if type(v) == 'table' and v.State == loveframes.GetState() then
			table.insert(self.collected, v)
		end
	end
end


-- LOVE CORE RESPECT-FULL

function game:init()
	require 'ui'

	self.Collider = require "Lua/hardoncollider"

	self.gamedata = require 'gamedata':init(self.Collider)
	self.editor = require 'editor':init(self.Collider)
	self.lobby = require 'lobby':init(self.gamedata)

	loveframes.SetState('editor')

	return self
end

function game:update(dt)
	self:collect()
	for k,v in pairs(self.collected) do
		v:update(dt)
	end
end

function game:draw()
	for k,v in pairs(self.collected) do
		v:draw()
	end
end

-- CALLBACKS

function game:keypressed(key, unicode)
	for k,v in pairs(self.collected) do
		v:keypressed(key, unicode)
	end
end

function game:mousepressed(x, y, button)
	for k,v in pairs(self.collected) do
		v:mousepressed(x, y, button)
	end
end

function game:mousereleased(x, y, button)
	for k,v in pairs(self.collected) do
		v:mousereleased(x, y, button)
	end
end

return game
