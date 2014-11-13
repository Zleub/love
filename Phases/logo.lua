Phase = {}

function Phase:next_phase(currentPhase)
	return 'next_phase', 2
end

function Phase:init()
	self.id = 1
	self.name = 'Phase_1'
	self.images = {
		{
			image = love.graphics.newImage('Images/logo.png'),
			scale = 0.2,
			x = 200,
			y = 100
		}
	}
	self.texts = {
		{
			string = 'Press Start',
			x = 500,
			y = 500
		}
	}
	self.kb_events = {
		space = self.next_phase,
		enter = self.next_phase
	}
end

return Phase
