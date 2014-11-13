function love.load()
	-- require 'Lua/Pl'
	Phases = require 'Lua/Phases':init()

	-- print(pretty.write(Phases))
end

function convert(key)
	if key == 'space' then
		return ' '
	elseif key == 'enter' then
		return 'return'
	else
		return key
	end
end

function love.keypressed(key)
	local msg = nil
	local data = nil

	if Phases.current.kb_events then
		for k, ft in pairs(Phases.current.kb_events) do
			k = convert(k)
			if key == k then
				msg, data = ft(Phases.current)
			end
		end
	end

	if msg == 'next_phase' then
		print('next_phase', data)
		Phases:getPhase(data)
	end
end

function love.update(dt)
	Phases:update(dt)
end

function love.draw()
	Phases:draw()
end
