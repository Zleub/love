local editor = {}

local Meshlist = {}

function Meshlist.new(in_table, image, polygon)
	local vertices = {
		{
			polygon.vertices[1].x, polygon.vertices[1].y,
			0, 0,
			255, 255, 255,
		},
		{
			polygon.vertices[2].x, polygon.vertices[2].y,
			1, 0,
			255, 255, 255,
		},
		{
			polygon.vertices[3].x, polygon.vertices[3].y,
			1, 1,
			255, 255, 255,
		},
		{
			polygon.vertices[4].x, polygon.vertices[4].y,
			0, 1,
			255, 255, 255,
		}
	}
	table.insert(in_table, {
		mesh = love.graphics.newMesh( vertices, image, 'fan'),
		move = function (self, x, y)
			local vertices = self.mesh:getVertices()
			vertices[1][1] = vertices[1][1] + x
			vertices[1][2] = vertices[1][2] + y
			vertices[2][1] = vertices[2][1] + x
			vertices[2][2] = vertices[2][2] + y
			vertices[3][1] = vertices[3][1] + x
			vertices[3][2] = vertices[3][2] + y
			vertices[4][1] = vertices[4][1] + x
			vertices[4][2] = vertices[4][2] + y
			self.mesh:setVertices(vertices)
		end,
		draw = function (self) love.graphics.draw(self.mesh) end
	})
end

local Shapelist = {}

function Shapelist.new(in_table, map, layer, offset) -- offset == {x = 'number', y = 'number', z = 'number'}
	local k = 1
	local m = 0
	local shapes = {}

	local x, y = centerize(offset.x, offset.y - offset.z)

	for i = 1, layer.height do
		for j = 1, layer.width do

			table.insert(shapes, {
				shape = map.HC:addPolygon(
					x - map.Data.tilewidth / 2, y,
					x, y + map.Data.tileheight / 2,
					x + map.Data.tilewidth / 2, y,
					x, y - map.Data.tileheight / 2
				),
				move = function (self, x, y)
					local vertices = self.shape._polygon.vertices
					vertices[1].x = vertices[1].x + x
					vertices[1].y = vertices[1].y + y
					vertices[2].x = vertices[2].x + x
					vertices[2].y = vertices[2].y + y
					vertices[3].x = vertices[3].x + x
					vertices[3].y = vertices[3].y + y
					vertices[4].x = vertices[4].x + x
					vertices[4].y = vertices[4].y + y
				end,
				resize = function (self, scale)
					-- local vertices = self.shape._polygon.vertices
					-- vertices[1].x = vertices[1].x + u * 2
					-- vertices[1].y = vertices[1].y + v * 2
					-- vertices[2].x = vertices[2].x + u * 2
					-- vertices[2].y = vertices[2].y + v * 2
					-- vertices[3].x = vertices[3].x + u
					-- vertices[3].y = vertices[3].y + v
					-- vertices[4].x = vertices[4].x + u
					-- vertices[4].y = vertices[4].y + v
				end
			})

			if k % layer.width == 0 then
				m = m + 1
			end
			k = k + 1
			x = x + map.Data.tilewidth / 2
			y = y + map.Data.tileheight / 2
		end
		x, y = centerize(offset.x, offset.y - offset.z)
		y = y + (map.Data.tileheight / 2) * m
		x = x - (map.Data.tilewidth / 2) * m
	end
	table.insert(in_table, shapes)
end

local Map = {}

function Map:new()
end

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
	self.map.Meshes = {}

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

	Shapelist.new(self.map.Shapes, self.map, layer, {x = self.x, y = self.y, z = self.z})
	self.z = self.z + self.step

	local img = love.graphics.newImage('Images/bricks.jpg')
	img:setFilter('nearest', 'nearest')

	for k,v in pairs(self.map.Shapes) do
		table.insert(self.map.Meshes, {})
		for key, val in pairs(v) do
			Meshlist.new(self.map.Meshes[#self.map.Meshes], img, val.shape._polygon)
		end
	end
end

function editor:move(x, y)
	if not self.map.Shapes or not self.map.Meshes then return end

	for k, shapedlayer in pairs(self.map.Shapes) do
		for key, shape in pairs(shapedlayer) do
			shape:move(x, y)
		end
	end
	for k,v in pairs(self.map.Meshes) do
		for key, val in pairs(v) do
			val:move(self.x_move, self.y_move)
		end
	end
end

-- UPDATE & COLLECT

function editor:reset_key(key, dt)
	if key == 'up' then
		-- self.map.Data.tileheight = self.map.Data.tileheight - 1 * dt * 10
		return 0, -100
	-- elseif key == 'pageup' then
	-- 	self.map.Data.tileheight = self.map.Data.tileheight - 1 * dt * 10
	-- 	self.step = self.map.Data.tileheight / 2
	-- elseif key == 'down' then
	-- 	self.map.Data.tileheight = self.map.Data.tileheight + 1 * dt * 10
	-- elseif key == 'pagedown' then
	-- 	self.map.Data.tileheight = self.map.Data.tileheight + 1 * dt * 10
	-- 	self.step = self.map.Data.tileheight / 2
	elseif key == 'wu' then
		return 0.1
	elseif key == 'wd' then
		return -0.1
	end
end

function editor:reset(key, dt)
	-- self.map.HC:clear()
	-- self.z = 0
	-- self.map.Shapes = {}

	local u = self:reset_key(key, dt)

	for k, layer in pairs(self.map.Shapes) do
		for key, val in pairs(layer) do
			val:resize(self.scale)
		end
	end

	-- RE-CREATION

	-- for k,layer in pairs(self.map.Data.layers) do
	-- 	Shapelist.new(self.map.Shapes, self.map, layer, {x = self.x, y = self.y, z = self.z})
	-- 	self.z = self.z + self.step
	-- end

	-- local img = love.graphics.newImage('Images/bricks.jpg')
	-- img:setFilter('nearest', 'nearest')
	-- self.map.Meshes = {}

	-- for k,v in pairs(self.map.Shapes) do
	-- 	table.insert(self.map.Meshes, {})
	-- 	for key, val in pairs(v) do
	-- 		Meshlist.new(self.map.Meshes[#self.map.Meshes], img, val.shape._polygon)
	-- 	end
	-- end
end

function editor:update_input(dt)
	if love.mouse.isDown('r') then print(inspect(self, {depth = 4})) end

	if love.mouse.isDown('wu') then print('ALERT') end

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
		for key, val in pairs(self.collected[#self.collected]) do
			if val.shape:collidesWith(self.mouse) then
				self.toDraw = val
				return
			end
		end
	end
end

-- LOVE CORE RESPECT-FULL

function editor:init(Collider)
	self.State = 'editor'
	self.Collider = Collider
	self.scale = 1
	self.x = 0
	self.y = 0
	self.z = 0

	return self
end

function editor:update(dt)
	if not self.map then return end

	self:update_input(dt)
	self.mouse:moveTo(love.mouse.getPosition())

	if self.x_move ~= 0 or self.y_move ~= 0 then
		self:move(self.x_move, self.y_move)
	end

	self:collect()
	self:collect_draw()
end

function editor:draw()
	if self.collected then
		for key, val in pairs(self.collected) do
			for k, v in pairs(val) do
				self.map.Meshes[key][k]:draw()
				v.shape:draw()
			end
		end
	end

	if self.toDraw then
		self.toDraw.shape:draw('fill')
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
		self.scale = self.scale - 0.2
		self:reset('wu')
	end

	if button == 'wd' then
		self.scale = self.scale + 0.2
		self:reset('wd')
	end
end

function editor:mousereleased(x, y, button)
	if button == 'l' then
		self.x_move, self.y_move = 0, 0
	end
end

return editor
