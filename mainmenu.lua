function sendnewgame()
	loveframes.SetState('newgame')
end

function sendloadgame()
	print('load')
	-- loveframes.SetState('loadgame')
end

function sendoptions()
	print('option')
	-- loveframes.SetState('options')
end

mainmenu = loveframes.Create('list')
mainmenu:SetPadding(5)
mainmenu:SetSpacing(20)
mainmenu:Center()
mainmenu:SetState('mainmenu')

buttonnew = loveframes.Create('button', mainmenu):SetText('New Game')
buttonnew.OnClick = sendnewgame

buttonload = loveframes.Create('button', mainmenu):SetText('Load Game')
buttonload.OnClick = sendloadgame

buttonoption = loveframes.Create('button', mainmenu):SetText('Options')
buttonoption.OnClick = sendoptions




newgame = loveframes.Create('panel')
newgame:SetSize(love.window.getDimensions())
newgame:SetState('newgame')

loveframes.Create('text', newgame):SetText('New game')
-- loveframes.Create('image', newgame):SetPos(10, 10):SetImage('')
