local gamedata = {}

function gamedata:checkslots()
	if love.filesystem.exists('slot1') then
		print('slot 1 exist')
	elseif love.filesystem.exists('slot2') then
		print('slot 2 exist')
	elseif love.filesystem.exists('slot3') then
		print('slot 3 exist')
	end
end

-- build self.maps.MAP_NAME.tiled
function gamedata:requiremaps(Collider)
	self.maps = require 'maps':init(Collider)
end

-- build self.player
function gamedata:requireplayer()
	self.player = {}
	self.player.lobby = 'level_00'
end

function gamedata:getmap(map_name)
	return self.maps[map_name]
end

function gamedata:init(Collider)
	self:checkslots()
	self:requiremaps(Collider)
	self:requireplayer()
	return self
end

return gamedata
