local mainmenu = {}

function mainmenu:init()

	self.list = loveframes.Create('list')
	self.list:SetPadding(5)
	self.list:SetSpacing(20)
	self.list:SetHeight(125)
	self.list:Center()
	self.list:SetState('mainmenu')

	self.buttonnew = loveframes.Create('button', self.list):SetText('New Game')
	self.buttonnew.OnClick = function () loveframes.SetState('newgame') end

	self.buttonload = loveframes.Create('button', self.list):SetText('Load Game')
	self.buttonload.OnClick = function () print('load') end

	self.buttonoption = loveframes.Create('button', self.list):SetText('Options')
	self.buttonoption.OnClick = function () print('option') end

	self.buttontest = loveframes.Create('button', self.list):SetText('Test')
	self.buttontest.OnClick = function () loveframes.SetState('lobby') end


return self
end

return mainmenu
