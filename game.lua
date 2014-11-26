local game = {}

function game:init()
	require 'mainmenu':init()
	-- require 'persodebug':init()

	self.Collider = require "Lua/hardoncollider"

	self.gamedata = require 'gamedata':init(self.Collider)
	self.lobby = require 'lobby':init(self.gamedata)
	loveframes.SetState('lobby')

	return self
end

function game:collect()
	self.collected = {}

	for k,v in pairs(self) do
		if type(v) == 'table' and v.State == loveframes.GetState() then
			table.insert(self.collected, v)
		end
	end
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

function game:keypressed(key, unicode)
	for k,v in pairs(self.collected) do
		v:keypressed(key, unicode)
	end
end

return game
