Phase = {}

function Phase:new_game()
	return 'next_phase', 3
end

function Phase:load_game()
	return 'next_phase', 4
end

function Phase:option()
	print('option')
end

function Phase:quit()
	love.event.quit()
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
	return self.bt_events[self.bt_position]()
end

function Phase:init()
	self.id = 2
	self.name = 'Phase_2'
	self.music = love.audio.newSource("Musics/Delivering-the-Goods.mp3")
	self.texts = {
		{
			string = 'New Game',
			x = 500,
			y = 300
		},
		{
			string = 'Load Game',
			x = 500,
			y = 400
		},
		{
			string = 'Option',
			x = 500,
			y = 500
		}
	}
	self.bt_position = 1
	self.bt_position_max = 3
	self.shapes = { -- require position
		{
			shape = 'rectangle',
			x = 500,
			y = 300,
			width = 100,
			height = 75
		},
		{
			shape = 'rectangle',
			x = 500,
			y = 400,
			width = 100,
			height = 75
		},
		{
			shape = 'rectangle',
			x = 500,
			y = 500,
			width = 100,
			height = 75
		}
	}
	self.bt_events = {
		self.new_game,
		self.load_game,
		self.option
	}
	self.kb_events = {
		escape = self.quit,
		up = self.keyup,
		down = self.keydown,
		enter = self.validate
	}
end

return Phase
