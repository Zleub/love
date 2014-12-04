function getfield (f)
	local v = _G

	for w in string.gfind(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

function dlog(field, nbrdepth)
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
	local input = loveframes.Create('textinput', cons)
	input:SetWidth(300)
	input:SetPos(0, cons:GetHeight() - 21)
	input.OnEnter = function (object, text)
	local str = 'NULL'
	local func = string.match(text, "(.+)%(")
		-- if(string.match(func, "%.")
			func = getfield(func)
			local arg = string.match(text, "%((.+)%)")

			local array = {}
			if arg then
				for i in string.gmatch(arg, "([^,]+)") do
					if string.match(i, "['|\"](.+)['|\"]") == nil then
						if getfield(i) then
							table.insert(array, getfield(i))
						else
							table.insert(array, tonumber(i))
						end
					else
						table.insert(array, string.match(i, "['|\"](.+)['|\"]"))
					end
				end
			end

			for k,v in pairs(array) do
				print(v)
			end

			print(func, arg)

			if func and arg then
				dlog('exec')
				str = func(unpack(array))
			end
			if str and #str > 5000 then
				term:SetText(string.sub(str, 0, 5000))
			else
				term:SetText(str)
			end
		end
	end

-- MAIN MENU

local list = loveframes.Create('list')
			:SetPadding(5)
			:SetSpacing(20)
			:SetHeight(225)
			:Center()
			:SetState('mainmenu')

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


-- EDITOR
-- INFO FRAME

local editor = {}

function editor:inspect()
	return inspect(self)
end

local e_frame_info = loveframes.Create('frame'):SetState('editor'):SetName('Infos')
local e_frame_text1 = loveframes.Create('text', e_frame_info):SetText('No data yet'):SetPos(0, 30)


-- MAP FRAME

function set_size()
	if editor.tilewidth and editor.tileheight then
		e_frame_text1:SetText(editor:inspect())
		game.editor:addMap()
		get_frame_layer():SetVisible(true)
		get_frame_map():SetVisible(false)
	end
end

local e_frame_map = loveframes.Create('frame')
						:SetName('Map')
						:SetState('editor')
						:SetSize(125, 125)
						:Center()
						:SetScreenLocked(true)
local e_list_map = loveframes.Create('list', e_frame_map)
						:SetSize(e_frame_map:GetSize())
						:SetPos(0, 25)
						:SetSpacing(5)

loveframes.Create('text', e_list_map)
	:SetText('TileWidth (Pixsize)')

local e_tilewidth = loveframes.Create('textinput', e_list_map)
e_tilewidth.OnTextChanged = function (object, text)
	editor.tilewidth = tonumber(object:GetText())
end

loveframes.Create('text', e_list_map)
	:SetText('TileHeight (Pixsize)')

local e_tileheight = loveframes.Create('textinput', e_list_map)
e_tileheight.OnTextChanged = function (object, text)
	editor.tileheight = tonumber(object:GetText())
end

local e_settilesize = loveframes.Create('button', e_list_map)
	:SetText('Set Tile Size')
e_settilesize.OnClick = set_size

function get_frame_map()
	return e_frame_map
end

-- LAYER FRAME

function new_layer()
	if editor.width and editor.height then
		e_frame_text1:SetText(editor:inspect())
	end
end

local e_frame_layer = loveframes.Create('frame')
						:SetName('Layer')
						:SetState('editor')
						:SetSize(125, 125)
						:SetPos(350, 0)
						:SetScreenLocked(true)
						:SetVisible(false)
local e_list_layer = loveframes.Create('list', e_frame_layer)
						:SetSize(e_frame_layer:GetSize())
						:SetPos(0, 25)
						:SetSpacing(5)

loveframes.Create('text', e_list_layer)
	:SetText('Width (Tile nbr)')

local e_width = loveframes.Create('textinput', e_list_layer)
e_width.OnTextChanged = function (object, text)
	editor.width = tonumber(object:GetText())
end

loveframes.Create('text', e_list_layer)
	:SetText('Height (Tile nbr)')

local e_height = loveframes.Create('textinput', e_list_layer)
e_height.OnTextChanged = function (object, text)
	editor.height = tonumber(object:GetText())
end

local e_newlayer = loveframes.Create('button', e_list_layer)
					:SetText('Create Layer')
e_newlayer.OnClick = new_layer

function get_frame_layer()
	return e_frame_layer
end

-- DEBUG CONSOLE

c_button = loveframes.Create('button')
			:SetState('editor')
			:SetText('console')
			:SetPos(love.window.getWidth() - 100, love.window.getHeight()- 50)
c_button.OnClick = pop_console

-- pop_console(loveframes)
