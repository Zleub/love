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
function gamedata:requiremaps()
	self.maps = {}

	for k,v in pairs(love.filesystem.getDirectoryItems('Maps')) do
		v = string.sub(v, 1, -5)
		self.maps[v] = {}
		self.maps[v].tiled = require ('Maps/'..v)
	end
end

function gamedata:getmap(map_name)
	return self.maps[map_name]
end

function gamedata:init()
	self:checkslots()
	self:requiremaps()
	return self
end

return gamedata
