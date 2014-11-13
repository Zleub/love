Phase = {}

function Phase:quit()
	love.event.quit()
end

function Phase:getsave()
	local t1 = love.filesystem.getLastModified('save1')
	local t2 = love.filesystem.getLastModified('save2')
	local t3 = love.filesystem.getLastModified('save3')

	if t1 == nil then
		t1 = 0
	elseif t2 == nil then
		t2 = 0
	elseif t3 == nil then
		t3 = 0
	end

	if t1 > t2 and t1 > t3 then
		self.savefile = 'save1'
	elseif t2 > t1 and t2 > t3 then
		self.savefile = 'save2'
	elseif t3 > t1 and t3 > t2 then
		self.savefile = 'save3'
	end

	if self.savefile == nil then
		print('no save filie ?')
	end
end

function Phase:validate()
	self:getsave()
	love.filesystem.write(self.savefile..'/Heros', self.images[1].effect_name)
end

function Phase:ft_left()
	if self.images[1].effect_name == 'center' then
		self.images[1].x = self.images[1].x + 128
		self.images[1].effect_name = 'left'
		self.images[1].effect:send(
			"img",
			self.shaders[self.images[1].effect_name]
		)
	elseif self.images[1].effect_name == 'left' then
		self.images[1].x = self.images[1].x - 256
		self.images[1].effect_name = 'right'
		self.images[1].effect:send(
			"img",
			self.shaders[self.images[1].effect_name]
		)
	elseif self.images[1].effect_name == 'right' then
		self.images[1].x = self.images[1].x + 128
		self.images[1].effect_name = 'center'
		self.images[1].effect:send(
			"img",
			self.shaders[self.images[1].effect_name]
		)
	end
end

function Phase:ft_right()
	if self.images[1].effect_name == 'center' then
		self.images[1].x = self.images[1].x - 128
		self.images[1].effect_name = 'right'
		self.images[1].effect:send(
			"img",
			self.shaders[self.images[1].effect_name]
		)
	elseif self.images[1].effect_name == 'right' then
		self.images[1].x = self.images[1].x + 256
		self.images[1].effect_name = 'left'
		self.images[1].effect:send(
			"img",
			self.shaders[self.images[1].effect_name]
		)
	elseif self.images[1].effect_name == 'left' then
		self.images[1].x = self.images[1].x - 128
		self.images[1].effect_name = 'center'
		self.images[1].effect:send(
			"img",
			self.shaders[self.images[1].effect_name]
		)
	end
end

function Phase:init()
	self.id = 5
	self.name = 'New_Game'
	self.images = {
		{
			image = love.graphics.newImage('Images/HeroSelection.png'),
			effect_name = 'center',
			effect = love.graphics.newShader [[
				extern Image img;
				vec4 effect(vec4 color,Image tex,vec2 tc,vec2 pc)
				{
					vec4 img_color = Texel(tex,tc);
					vec4 trans_color = Texel(img,tc);

					number white_level   = (
						trans_color.r + trans_color.g + trans_color.b
						) / 3;
					number max_white   = 1;

					if (white_level >= max_white)
						return img_color;
					else
						{
							img_color.a = 0;
							return img_color;
						}
				}
			]],
			scale = 1,
			x = 128,
			y = 128
		}
	}
	self.kb_events = {
		escape = self.quit,
		left = self.ft_left,
		right = self.ft_right,
		enter = self.validate
	}
	self.shaders = {
		left = love.graphics.newImage('Images/HeroSelectionLeft.png'),
		center = love.graphics.newImage('Images/HeroSelectionCenter.png'),
		right = love.graphics.newImage('Images/HeroSelectionRight.png')
	}

	-- Shader linking
	self.images[1].effect:send("img", self.shaders[self.images[1].effect_name])
end

return Phase
