
list = loveframes.Create('list')
list:SetPadding(5)
list:SetSpacing(20)
list:SetHeight(225)
list:Center()
list:SetState('mainmenu')

buttonnew = loveframes.Create('button', list):SetText('New Game')
buttonnew.OnClick = function () loveframes.SetState('newgame') end

buttonload = loveframes.Create('button', list):SetText('Load Game')
buttonload.OnClick = function () print('load') end

buttonoption = loveframes.Create('button', list):SetText('Options')
buttonoption.OnClick = function () print('option') end

buttontest = loveframes.Create('button', list):SetText('Lobby')
buttontest.OnClick = function () loveframes.SetState('lobby') end

buttontest = loveframes.Create('button', list):SetText('Editor')
buttontest.OnClick = function () loveframes.SetState('editor') end






e_list = loveframes.Create('list'):SetState('editor'):SetHeight(250)
loveframes.Create('text', e_list):SetText('Map Editor\n')


loveframes.Create('text', e_list):SetText('Width (Tile nbr)')
e_width = loveframes.Create('textinput', e_list)
loveframes.Create('text', e_list):SetText('Height (Tile nbr)')
e_height = loveframes.Create('textinput', e_list)


loveframes.Create('text', e_list):SetText('TileWidth (Pixsize)')
e_tilewidth = loveframes.Create('textinput', e_list)
loveframes.Create('text', e_list):SetText('TileHeight (Pixsize)')
e_tileheight = loveframes.Create('textinput', e_list)


e_plus = loveframes.Create('button', e_list):SetText('add layer')
e_plus.OnClick = function () print(e_width:GetText()) end
