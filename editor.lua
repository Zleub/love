local editor = {}

function editor.callback(dt, shape_one, shape_two, dx, dy)
	if shape_one == editor.mouse then
		editor.toDraw = shape_two
	elseif shape_two == editor.mouse then
		editor.toDraw = shape_one
	end
end

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
	self.mouse = self.map.HC:addCircle(0, 0, 20)
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
		layer.x = 0 + self.x_off
	else
		layer.x = self.x + self.x_off
	end

	if self.y == nil then
		layer.y = 0 + self.y_off
	else
		layer.y = self.y + self.y_off
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
end

function editor:init(Collider)
	self.State = 'editor'
	self.Collider = Collider
	self.step = 0
	self.x = 0
	self.y = 0
	self.z = 0

	self.x_off = 0
	self.y_off = 0
	return self
end

function editor:update(dt)
	if love.mouse.isDown('l') then
		local x_diff = self.x_start - love.mouse.getX()
		local y_diff = self.y_start - love.mouse.getY()

		if x_diff then
			self.x_off = self.x_off + x_diff
			self.x_move = x_diff
			self.x_start = love.mouse.getX()
		end

		if y_diff then
			self.y_off = self.y_off + y_diff
			self.y_move = y_diff
			self.y_start = love.mouse.getY()
		end
	end

	if self.map then
		self.toDraw = {}
		self.mouse:moveTo(love.mouse.getPosition())
		if self.x_move or self.y_move then
			for k, shapedlayer in pairs(self.map.Shapes) do
				for key,shape in pairs(shapedlayer) do
					if self.mouse:collidesWith(shape) then
						table.insert(self.toDraw, shape)
					end
					shape:move(self.x_move, self.y_move)
				end
			end
		end
	end

end

function editor:draw()
	if self.toDraw then
		self.mouse:draw()
		for k,v in pairs(self.toDraw) do
			v:draw()
		end
	end
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
