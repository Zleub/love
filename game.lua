local game = {}

function game:init()
	require 'mainmenu':init()

	self.gamedata = require 'gamedata':init()
	self.lobby = require 'lobby':init(self.gamedata)
	loveframes.SetState("mainmenu")

	-- print(inspect(self, {depth = 4}))
	return self
end

function game:collect()
	self.toDraw = {}

	for k,v in pairs(self) do
		if type(v) == 'table' and v.State == loveframes.GetState() then
			table.insert(self.toDraw, v)
		end
	end
end

function game:update(dt)
	self:collect()
end

function game:draw()
	for k,v in pairs(self.toDraw) do
		v:draw()
	end
end

return game
