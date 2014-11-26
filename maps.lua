maps = {}

function centerize(offx, offy)
	return love.graphics.getWidth() / 2 + offx, love.graphics.getHeight() / 2 + offy
end

function maps:buildQuadlists(map)
	self[map].Quadlists = {}

	for k,v in pairs(self[map].tiled.tilesets) do
		table.insert(self[map].Quadlists, Quadlist(v))
	end
end

function maps:buildshapes(map)
	local offy = 0
	local offx = 0
	self[map].Shapes = {}

	for key,layer in pairs(self[map].tiled.layers) do
		table.insert(self[map].Shapes, buildshapes(layer, self[map], offx, offy))
		offy = offy - 32
		offx = offx + 10
	end
end

function maps:load(map)
	map = string.sub(map, 1, -5)
	self[map] = {}
	self[map].HC = self.Collider.new(150)
	self[map].tiled = require ('Maps/'..map)
	self:buildQuadlists(map)
	self:buildshapes(map)
end

function maps:init(Collider)
	self.Collider = Collider

	for k,v in pairs(love.filesystem.getDirectoryItems('Maps')) do
		self:load(v)
	end
	return self
end

return maps
