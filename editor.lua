local editor = {}

function editor:addMap()
	self.HC = self.Collider.new(150)
	print('add map')
end

function editor:addLayer()
	print('add layer')
end

function editor:init(Collider)
	self.State = 'editor'
	self.Collider = Collider

	return self
end

function editor:update(dt)
end

function editor:draw()
end

function editor:keypressed()
end

return editor
