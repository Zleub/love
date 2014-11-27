
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






local e_list = loveframes.Create('list'):SetState('editor'):SetHeight(250)
loveframes.Create('text', e_list):SetText('Map Editor\n')


loveframes.Create('text', e_list):SetText('Width (Tile nbr)')
local e_width = loveframes.Create('textinput', e_list)
loveframes.Create('text', e_list):SetText('Height (Tile nbr)')
local e_height = loveframes.Create('textinput', e_list)


loveframes.Create('text', e_list):SetText('TileWidth (Pixsize)')
local e_tilewidth = loveframes.Create('textinput', e_list)
loveframes.Create('text', e_list):SetText('TileHeight (Pixsize)')
local e_tileheight = loveframes.Create('textinput', e_list)


local e_plus = loveframes.Create('button', e_list):SetText('add layer')
e_plus.OnClick = function () print(e_width:GetText()) end





local cons = loveframes.Create('frame')
cons:SetHeight(love.window.getHeight())
cons:SetPos(0, 0)
cons:SetState('none')

local list = loveframes.Create('list', cons)
list:SetPos(0, 25)
list:SetHeight(cons:GetHeight() - 45)
local term = loveframes.Create('text', list)
-- term:SetPos(2, 30)

function getfield (f)
	local v = _G

	for w in string.gfind(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

function parse(object, text)
	local str = 'NULL'
	local array = {}

	for i in string.gmatch(text, "%S+") do
		table.insert(array, i)
	end
	if array[1] == 'print' and array[2] and array[3] then
		str = inspect(getfield(array[3]), {depth = tonumber(array[2])})
	elseif array[1] == 'print' and array[2] then
		str = inspect(getfield(array[2]), {depth = 1})
	end
	term:SetText(str)
end

local input = loveframes.Create('textinput', cons)
input:SetWidth(300)
input:SetPos(0, cons:GetHeight() - 21)
input.OnEnter = parse
