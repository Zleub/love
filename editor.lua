local editor = {}

-- OBJECTS MANIPULATION

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
end

function editor:addLayer()
	if self.width == nil or self.height == nil then
		return ;
	end

	table.insert(self.map.Data.layers, {})
	local index = #self.map.Data.layers
	local layer = self.map.Data.layers[index]
	self:createLayer(layer)

	table.insert(self.map.Shapes, buildfullshapes_fix(layer, self.map, self.x, self.y, self.z))
	self.z = self.z + self.step
end

function editor:move(x, y)
	for k, shapedlayer in pairs(self.map.Shapes) do
		for key, shape in pairs(shapedlayer) do
			shape:move(x, y)
		end
	end
end

-- UPDATE & COLLECT

function editor:reset_key(key, dt)
	if key == 'up' then
		self.map.Data.tileheight = self.map.Data.tileheight - 1 * dt * 10
	elseif key == 'pageup' then
		self.map.Data.tileheight = self.map.Data.tileheight - 1 * dt * 10
		self.step = self.map.Data.tileheight / 2
	elseif key == 'down' then
		self.map.Data.tileheight = self.map.Data.tileheight + 1 * dt * 10
	elseif key == 'pagedown' then
		self.map.Data.tileheight = self.map.Data.tileheight + 1 * dt * 10
		self.step = self.map.Data.tileheight / 2
	elseif key == 'wu' then
		self.map.Data.tilewidth = self.map.Data.tilewidth + 2
		self.map.Data.tileheight = self.map.Data.tileheight + 1
	elseif key == 'wd' then
		self.map.Data.tilewidth = self.map.Data.tilewidth - 2
		self.map.Data.tileheight = self.map.Data.tileheight - 1
	end
end

function editor:reset(key, dt)
	self.map.HC:clear()
	self.z = 0
	self.map.Shapes = {}

	self:reset_key(key, dt)
	for k,layer in pairs(self.map.Data.layers) do
		table.insert(self.map.Shapes, buildfullshapes_fix(layer, self.map, self.x, self.y, self.z))
		self.z = self.z + self.step
	end
end

function editor:update_input(dt)
	if love.mouse.isDown('r') then print(inspect(self, {depth = 1})) end

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

	if love.keyboard.isDown('up') then
		self:reset('up', dt)
	elseif love.keyboard.isDown('pageup') then
		self:reset('pageup', dt)
	elseif love.keyboard.isDown('down') then
		self:reset('down', dt)
	elseif love.keyboard.isDown('pagedown') then
		self:reset('pagedown', dt)
	end
end

function editor:collect()
	self.collected = {}
	if #self.map.Shapes == 1 then
		table.insert(self.collected, self.map.Shapes[1])
	else
		for i=1,#self.map.Shapes - 1 do
			table.insert(self.collected, {})
			local sqrt = math.sqrt(#self.map.Shapes[i])
			local nbr = sqrt
			while nbr < #self.map.Shapes[i] do
				self.collected[i][nbr] = self.map.Shapes[i][nbr]
				nbr = nbr + sqrt
			end

			nbr = #self.map.Shapes[i] - sqrt + 1
			while nbr <= #self.map.Shapes[i] do
				self.collected[i][nbr] = self.map.Shapes[i][nbr]
				nbr = nbr + 1
			end
		end
		table.insert(self.collected, self.map.Shapes[#self.map.Shapes])
	end
end

function editor:collect_draw()
	if #self.collected > 0 then
		for key, shape in pairs(self.collected[#self.collected]) do
			if shape:collidesWith(self.mouse) then
				self.toDraw = shape
				return
			end
		end
	end
end

-- LOVE CORE RESPECT-FULL

function editor:init(Collider)
	self.State = 'editor'
	self.Collider = Collider
	self.mode = 'collect'
	self.x = 0
	self.y = 0
	self.z = 0

	return self
end

function editor:update(dt)
	if not self.map then return end

	self:update_input(dt)
	self.mouse:moveTo(love.mouse.getPosition())

	if self.x_move or self.y_move then
		self:move(self.x_move, self.y_move)
	end

	self:collect()
	self:collect_draw()
end

function editor:draw()
	if self.mode == 'collect' then
		if self.collected then
			for key, val in pairs(self.collected) do
				for k, v in pairs(val) do
					v:draw()
				end
			end
		end
	end

	if self.mode == 'global' then
		if self.map then
			for key, val in pairs(self.map.Shapes) do
				for k, v in pairs(val) do
					v:draw()
				end
			end
		end
	end

	if self.toDraw then
		self.toDraw:draw('fill')
	end
end

-- CALLBACKS

function editor:keypressed(key, unicode)
end

function editor:mousepressed(x, y, button)
	if button == 'l' then
		self.x_start, self.y_start = love.mouse.getPosition()
	end

	if button == 'wu' then
		self:reset('wu')
	end

	if button == 'wd' then
		self:reset('wd')
	end
end

function editor:mousereleased(x, y, button)
	if button == 'l' then
		self.x_move, self.y_move = 0, 0
	end
end

return editor
