function getfield (f)
	local v = _G

	for w in string.gfind(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

function log(field, nbrdepth)
	return inspect(field, {depth = nbrdepth})
end

function pop_console(object)
	local cons = loveframes.Create('frame'):SetState(object:GetState()):SetName('Console')
	cons:SetHeight(love.window.getHeight() - 20)
	cons:SetPos(0, 0)

	local list = loveframes.Create('list', cons)
	list:SetPos(0, 25)
	list:SetHeight(cons:GetHeight() - 45)
	local term = loveframes.Create('text', list)
	-- term:SetPos(2, 30)

	local input = loveframes.Create('textinput', cons)
	input:SetWidth(300)
	input:SetPos(0, cons:GetHeight() - 21)
	input.OnEnter = function (object, text)
		local str = 'NULL'
		local func = string.match(text, "(.+)%(")
		local arg = string.match(text, "%((.+)%)")

		if arg then
			local array = {}
			for i in string.gmatch(arg, "([^,]+)") do
				if string.match(i, "['|\"](.+)['|\"]") == nil then
					print(i, "is field")
					table.insert(array, getfield(i))
				else
					print(i, "is string")
					table.insert(array, string.match(i, "['|\"](.+)['|\"]"))
				end
			end
		end

		if arg == nil then
			local field = string.match(text, "%((.+)%)")
			if field then arg = getfield(field) end
		end

		print(func, arg, field)

		-- FULL REFLEXION NEEDED RIGHT HERE

		-- if array[1] == 'print' and array[2] and array[3] then
		-- 	str = inspect(getfield(array[3]), {depth = tonumber(array[2])})
		-- elseif array[1] == 'print' and array[2] then
		-- 	str = inspect(getfield(array[2]), {depth = 1})
		-- end

		if func and arg then str = _G[func](arg) end
		term:SetText(str)
	end
end

local list = loveframes.Create('list')
list:SetPadding(5)
list:SetSpacing(20)
list:SetHeight(225)
list:Center()
list:SetState('mainmenu')

local buttonnew = loveframes.Create('button', list):SetText('New Game')
buttonnew.OnClick = function () loveframes.SetState('newgame') end

local buttonload = loveframes.Create('button', list):SetText('Load Game')
buttonload.OnClick = function () print('load') end

local buttonoption = loveframes.Create('button', list):SetText('Options')
buttonoption.OnClick = function () print('option') end

local buttontest = loveframes.Create('button', list):SetText('Lobby')
buttontest.OnClick = function () loveframes.SetState('lobby') end

local buttontest = loveframes.Create('button', list):SetText('Editor')
buttontest.OnClick = function () loveframes.SetState('editor') end





local e_frame_win = loveframes.Create('frame'):SetState('editor'):SetName('Map')
local e_list_win = loveframes.Create('list', e_frame_win):SetPos(0, 25)

loveframes.Create('text', e_list_win):SetText('Width (Tile nbr)')
local e_width = loveframes.Create('textinput', e_list_win)
loveframes.Create('text', e_list_win):SetText('Height (Tile nbr)')
local e_height = loveframes.Create('textinput', e_list_win)


local e_frame_layer = loveframes.Create('frame'):SetState('editor'):SetName('Layer'):SetPos(350, 0)
local e_list_layer = loveframes.Create('list', e_frame_layer):SetPos(0, 25)

loveframes.Create('text', e_list_layer):SetText('TileWidth (Pixsize)')
local e_tilewidth = loveframes.Create('textinput', e_list_layer)
loveframes.Create('text', e_list_layer):SetText('TileHeight (Pixsize)')
local e_tileheight = loveframes.Create('textinput', e_list_layer)


local e_plus = loveframes.Create('button', e_list):SetText('add layer')
e_plus.OnClick = function () print(e_width:GetText()) end


local c_button = loveframes.Create('button'):SetState('editor'):SetText('console'):SetPos(love.window.getWidth() - 100, love.window.getHeight()- 50)
c_button.OnClick = pop_console

pop_console(c_button)
