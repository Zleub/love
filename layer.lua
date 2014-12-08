local layer = {}

function layer:init(width)
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

