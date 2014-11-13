Phase = {}

function Phase:back()
	return 'next_phase', 2
end

function Phase:keydown()
	self.bt_position = self.bt_position + 1
	if self.bt_position > self.bt_position_max then
		self.bt_position = 1
	end
end

function Phase:keyup()
	self.bt_position = self.bt_position - 1
	if self.bt_position < 1 then
		self.bt_position = self.bt_position_max
	end
end

function Phase:validate()
	if self.bt_position == 1 then
		love.filesystem.remove( 'save1' )
		love.filesystem.createDirectory( 'save1' )
	elseif self.bt_position == 2 then
		love.filesystem.remove( 'save2' )
		love.filesystem.createDirectory( 'save2' )
	else
		love.filesystem.remove( 'save3' )
		love.filesystem.createDirectory( 'save3' )
	end

	return 'next_phase', 5
end

function Phase:getsaves()
	self.state1 = love.filesystem.exists('save1')
	self.state2 = love.filesystem.exists('save2')
	self.state3 = love.filesystem.exists('save3')
end

function Phase:init()
	local message1
	local message2
	local message3

	self:getsaves()
	print(self.state1, self.state2, self.state3)

	if self.state1 == true then
		message1 = 'A game is saved here'
	else
		message1 = 'Free slot'
	end

	if self.state2 == true then
		message2 = 'A game is saved here'
	else
		message2 = 'Free slot'
	end

	if self.state3 == true then
		message3 = 'A game is saved here'
	else
		message3 = 'Free slot'
	end


	self.id = 3
	self.name = 'New_save'
	self.texts = {
		{
			string = message1,
			x = 100,
			y = 100
		},
		{
			string = message2,
			x = 100,
			y = 200
		},
		{
			string = message3,
			x = 100,
			y = 300
		}
	}
	self.bt_position = 1
	self.bt_position_max = 3
	self.shapes = {
		{
			shape = 'rectangle',
			x = 100,
			y = 100,
			width = 50,
			height = 50
		},
		{
			shape = 'rectangle',
			x = 100,
			y = 200,
			width = 50,
			height = 50
		},
		{
			shape = 'rectangle',
			x = 100,
			y = 300,
			width = 50,
			height = 50
		}
	}
	self.kb_events = {
		up = self.keyup,
		down = self.keydown,
		enter = self.validate,
		backspace = self.back
	}

end

return Phase
