Collider = require 'Lua/hardoncollider'
-- pretty = require 'pl.pretty'

Phases = {}

function Phases:HCrefresh(new_phase)
	self.HC:clear()

	if new_phase.shapes then
		for k,v in pairs(new_phase.shapes) do
			if v.shape == 'rectangle' then
				new_phase.shapes[k] = self.HC:addRectangle(v.x, v.y, v.width, v.height)
			end
		end
	end
end

function Phases:Musicrefresh(new_phase)
	if new_phase.music and self.current.music then
		self.current.music:stop()
	end
end

function Phases:refresh(new_phase)
	self:HCrefresh(new_phase)
	self:Musicrefresh(new_phase)
end

function Phases:getPhase(id)
	for key, phase in pairs(self.list) do
		if phase.id == id then
			if self.current then
				self:refresh(phase)
			end
			self.current = phase
		end
	end
end

function Phases:require(files)
	local tmp

	for k,v in pairs(files) do
		tmp = string.sub(v, 1, -5)
		self.list[tmp] = require ('Phases/'..tmp)
		self.list[tmp]:init()
	end
end

function Phases:init()
	local files = love.filesystem.getDirectoryItems("Phases")

	if files == nil then
		print('no phases')
		love.event.quit()
	else
		self.list = {}
		self.HC = Collider.new(150)

		self:require(files)
		self:getPhase(1)
		return self
	end
end

function Phases:update(dt)
	if self.current.music then
		self.current.music:play()
		-- print(self.current.music:isLooping())
	end
end

function Phases:draw()
	love.graphics.print(self.current.name)

	if self.current.shapes then
		self.current.shapes[self.current.bt_position]:draw('line')
	end

	if self.current.images then
		for k,v in pairs(Phases.current.images) do
			if v.effect then
				-- print('Set shader')
				love.graphics.setShader(v.effect)
			end
			love.graphics.draw(v.image, v.x, v.y, 0, v.scale, v.scale)
			if v.effect then
				-- print('Unset shader')
				love.graphics.setShader()
			end
		end
	end

	if self.current.texts then
		for k,v in pairs(Phases.current.texts) do
			love.graphics.print(v.string, v.x, v.y, 0, v.scale, v.scale)
		end
	end
end

return Phases
