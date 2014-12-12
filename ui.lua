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
-- MAP FRAME

function set_size()
	if game.editor.tilewidth and game.editor.tileheight then
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
	game.editor.tilewidth = tonumber(object:GetText())
end

loveframes.Create('text', e_list_map)
	:SetText('TileHeight (Pixsize)')

local e_tileheight = loveframes.Create('textinput', e_list_map)
e_tileheight.OnTextChanged = function (object, text)
	game.editor.tileheight = tonumber(object:GetText())
end

local e_settilesize = loveframes.Create('button', e_list_map)
	:SetText('Set Tile Size')
e_settilesize.OnClick = set_size

function get_frame_map()
	return e_frame_map
end

-- LAYER FRAME

function new_layer()
	if game.editor.width and game.editor.height then
		game.editor:addLayer()
		-- get_panel_layer():SetVisible(true)
		-- add_panel_layer(loveframes.Create('panel'))
	end
end

local e_frame_layer = loveframes.Create('frame')
						:SetName('Layer')
						:SetState('editor')
						:SetSize(125, 200)
						:SetScreenLocked(true)
						:SetVisible(false)
						:SetPos(love.window.getWidth() - 100)
local e_list_layer = loveframes.Create('list', e_frame_layer)
						:SetSize(e_frame_layer:GetSize())
						:SetPos(0, 25)
						:SetSpacing(5)

loveframes.Create('text', e_list_layer)
	:SetText('Name')
local e_name = loveframes.Create('textinput', e_list_layer)
e_name.OnTextChanged = function (object, text)
	game.editor.name = object:GetText()
end

loveframes.Create('text', e_list_layer)
	:SetText('Width (Tile nbr)')
local e_width = loveframes.Create('textinput', e_list_layer)
e_width.OnTextChanged = function (object, text)
	game.editor.width = tonumber(object:GetText())
end

loveframes.Create('text', e_list_layer)
	:SetText('Height (Tile nbr)')

local e_height = loveframes.Create('textinput', e_list_layer)
e_height.OnTextChanged = function (object, text)
	game.editor.height = tonumber(object:GetText())
end

local e_newlayer = loveframes.Create('button', e_list_layer)
					:SetText('Create Layer')
e_newlayer.OnClick = new_layer

function get_frame_layer()
	return e_frame_layer
end

-- LAYER PANEL

local e_panel_layer = loveframes.Create('panel')
						:SetState('editor')
						:SetSize(250, love.window.getHeight())
						:SetPos(love.window.getWidth() - 250, 0)
						:SetVisible(false)

local e_panel_button1 = loveframes.Create('button')
						:SetText('Hide panel')

local e_panel_list = loveframes.Create('list', e_panel_layer)
						:SetSize(e_panel_layer:GetSize())
						:SetSpacing(10)

function get_panel_layer()
	return e_panel_layer
end

function add_panel_layer(item)
	return e_panel_list:AddItem(item)
end
