mainmenu = loveframes.Create('frame')
mainmenu:SetDraggable(false)
mainmenu:ShowCloseButton(false)
mainmenu:Center()

list = loveframes.Create("list", mainmenu)
list:SetPadding(5)
list:SetSpacing(10)

text = loveframes.Create('text', list):SetFont(fonts[10])
text:SetText('merde')

buttonnew = loveframes.Create('button', list):SetText('New Game')
buttonload = loveframes.Create('button', list):SetText('Load Game')
buttonoption = loveframes.Create('button', list):SetText('Options')
