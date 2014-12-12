local editor = {}

function editor:addMap()
	self.map = {}
	self.map.HC = self.Collider.new(150)
	self.map.HC:setCallbacks(editor.callback)
	self.map.Data = {}
	self.map.Data.tilesets = {}
	self.map.Data.layers = {}
	self.map.Data.tilewidth = self.tilewidth
	self.map.Data.tileheight = self.tileheight
	self.map.Shapes = {}

	self.step = self.tileheight / 2
	self.mouse = self.map.HC:addCircle(0, 0, 1)
	self.toDraw = {}
end

function editor:createLayer(layer)
	layer.width = self.width
	layer.height = self.height
	layer.properties = 'Not define YET'

	layer.data = {}
	for i=1,layer.height do
		for j=1,layer.width do
			table.insert(layer.data, 0)
		end
	end

	if self.name == nil then
		layer.name = index
	else
		layer.name = self.name
	end

	if self.x == nil then
		layer.x = 0
	else
		layer.x = self.x
	end

	if self.y == nil then
		layer.y = 0
	else
		layer.y = self.y
	end

	if self.z == nil then
		layer.z = 0
	else
		layer.z = self.z
		self.z = self.z + self.step
	end
end

function editor:addLayer()
	if self.width == nil or self.height == nil then
		return ;
	end

	table.insert(self.map.Data.layers, {})
	local index = #self.map.Data.layers
	local layer = self.map.Data.layers[index]
	self:createLayer(layer)

	table.insert(self.map.Shapes, buildfullshapes_fix(layer, self.map))
	table.insert(self.toDraw, {})
end

function editor:init(Collider)
	self.State = 'editor'
	self.Collider = Collider
	self.step = 0
	self.x = 0
	self.y = 0
	self.z = 0

	return self
end

function editor:update_drag(dt)
	if love.mouse.isDown('l') then
		local x_diff = love.mouse.getX() - self.x_start
		local y_diff = love.mouse.getY() - self.y_start

		if x_diff then
			self.x = self.x + x_diff
			self.x_move = x_diff
			self.x_start = love.mouse.getX()
		end

		if y_diff then
			self.y = self.y + y_diff
			self.y_move = y_diff
			self.y_start = love.mouse.getY()
		end
	end
end

function editor:move(x, y)
	for k, shapedlayer in pairs(self.map.Shapes) do
		for key, shape in pairs(shapedlayer) do
			shape:move(x, y)
		end
	end
end

function editor:collect()
	self.collected = self.map.Shapes[#self.map.Shapes]
end

function editor:collect_draw()
	for k,v in pairs(self.collected) do
		if v:collidesWith(self.mouse) then
			self.toDraw[#self.map.Shapes][k] = v
		else
			self.toDraw[#self.map.Shapes][k] = nil
		end

	end
end

function editor:update(dt)
	if not self.map then return end

	self:update_drag(dt)
	self.mouse:moveTo(love.mouse.getPosition())

	if self.x_move or self.y_move then
		self:move(self.x_move, self.y_move)
	end

	self:collect()
	if self.collected then
		self:collect_draw()
	end
end

function editor:draw()
	if self.toDraw then
		for k,v in pairs(self.toDraw) do
			for key, val in pairs(v) do
				val:draw('fill')
			end
		end
	end

	if self.collected then
		for key, val in pairs(self.collected) do
			val:draw()
		end
	end

	love.graphics.print(inspect(self, {depth = 1}))
end

function editor:keypressed(key, unicode)
end

function editor:mousepressed(x, y, button)
	if button == 'l' then
		self.x_start, self.y_start = love.mouse.getPosition()
	end
end

function editor:mousereleased(x, y, button)
	if button == 'l' then
		self.x_move, self.y_move = 0, 0
	end
end

return editor
