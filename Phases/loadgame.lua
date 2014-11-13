Phase = {}

function Phase:back()
	return 'next_phase', 2
end

function Phase:init()
	self.id = 4
	self.name = 'Load_Game'
	self.kb_events = {
		backspace = self.back
	}
end

return Phase
