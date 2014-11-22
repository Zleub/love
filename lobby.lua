local lobby = {}

function lobby:init(gamedata)
	self.gamedata = gamedata
	self.State = 'lobby'
	return self
end

function lobby:draw()
	love.graphics.print(inspect(self.gamedata.maps.__lobby))
end

return lobby
