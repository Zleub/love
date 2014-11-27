local lobby = {}

function collide_callback(dt, shape_one, shape_two, dx, dy)
	if shape_one == lobby.mouse then
		lobby.toFill = shape_two
	elseif shape_two == lobby.mouse then
		lobby.toFill = shape_one
	end
end

function lobby:init(gamedata)
	self.State = 'lobby'
	self.gamedata = gamedata
	self.cursor = {}
	self.cursor.image = love.graphics.newImage('Images/cursor.png')
	self.offx = 0
	self.offy = 0

	self.map = self.gamedata.maps[self.gamedata.player.lobby]
	self.map.HC:setCallbacks(collide_callback)
	self.mouse = self.map.HC:addCircle(0, 0, 2)
	return self
end

function lobby:update(dt)
	-- if self.map ~= self.gamedata.maps[self.gamedata.player.lobby] then
	-- 	self.map = self.gamedata.maps[self.gamedata.player.lobby]
	-- 	-- print(inspect(self.map))
	-- end
	self.mouse:moveTo(love.mouse.getPosition())
	self.map.HC:update(dt)
end

function lobby:draw()
	for key, layer in ipairs(self.map.tiled.layers) do
		drawlayer(self.map, layer, self.offx, self.offy)
	end

	for k, shapedlayer in ipairs(self.map.Shapes) do
		-- if k == 1 then
		-- 	love.graphics.setColor( 255, 0, 0)
		-- elseif k == 2 then
		-- 	love.graphics.setColor( 0, 255, 0)
		-- elseif k == 3 then
		-- 	love.graphics.setColor( 0, 0, 255)
		-- else
		-- 	love.graphics.setColor( 255, 255, 255)
		-- end

		for key,shape in pairs(shapedlayer) do
			-- if shape:collidesWith(self.mouse) then
			-- 	shape:draw('fill')
			--  end
				shape:draw()
		end
	end

	if self.toFill then
		self.toFill:draw('fill')
	end
	-- love.graphics.draw(self.cursor.image, self.cursor.x, self.cursor.y)
end

function lobby:keypressed(key, unicode)
	if key == 'up' then
		self.offx = self.offx + 64
		self.offy = self.offy - 32
		for k, v in ipairs(self.map.Shapes) do
			for key,shape in pairs(v) do
				shape:move(64, -32)
			end
		end
	elseif key == 'down' then
		self.offx = self.offx - 64
		self.offy = self.offy + 32
		for k, v in ipairs(self.map.Shapes) do
			for key,shape in pairs(v) do
				shape:move(-64, 32)
			end
		end
	elseif key == 'right' then
		self.offx = self.offx + 64
		self.offy = self.offy + 32
		for k, v in ipairs(self.map.Shapes) do
			for key,shape in pairs(v) do
				shape:move(64, 32)
			end
		end
	elseif key == 'left' then
		self.offx = self.offx - 64
		self.offy = self.offy - 32
		for k, v in ipairs(self.map.Shapes) do
			for key,shape in pairs(v) do
				shape:move(-64, -32)
			end
		end
	end
end

return lobby
