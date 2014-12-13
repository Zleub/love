function Quadlist(tileset)
	local i = 0
	local j = 0
	local Quadlist = {}

	Quadlist[0] = love.graphics.newImage(tileset.image)
	while j < tileset.imageheight do
		i = 0
		while i < tileset.imagewidth do
			table.insert(Quadlist,
				love.graphics.newQuad(i, j, tileset.tilewidth, tileset.tileheight,
					tileset.imagewidth, tileset.imageheight))
			i = i + tileset.tilewidth
		end
		j = j + tileset.tileheight
	end

	return Quadlist
end

function drawlayer(map, layer, offx, offy)
	local k = 1
	local m = 0
	local x, y = centerize(offx, offy)

	for i = 1, layer.height do
		for j = 1, layer.width do

			if layer.data[k] ~= 0 then

			love.graphics.draw(
				map.Quadlists[1][0],
				map.Quadlists[1][ layer.data[k] ],
				x - map.tiled.tilewidth / 2 ,
				y - map.tiled.tileheight / 2
			)

			end
			if k % 10 == 0 then
				m = m + 1
			end
			k = k + 1
			x = x + map.tiled.tilesets[1].tilewidth / 2
			y = y + map.tiled.tilesets[1].tileheight / 2
		end
	x, y = centerize(offx, offy)
	y = y + (map.tiled.tilesets[1].tileheight / 2) * m
	x = x - (map.tiled.tilesets[1].tilewidth / 2) * m
	end
end

function buildshapes(layer, map, offx, offy)
	local k = 1
	local m = 0
	local shapes = {}

	local x, y = centerize(offx, offy)

	for i = 1, layer.height do
		for j = 1, layer.width do

			if layer.data[k] ~= 0
				-- and
				-- layer.data[k] ~= 34 and
				--  layer.data[k] ~= 9 and
				--  layer.data[k] ~= 10 and
				--  layer.data[k] ~= 11

				 then

			table.insert(shapes, map.HC:addPolygon(
				x - map.tiled.tilesets[1].tilewidth / 2, y,
				x, y + map.tiled.tilesets[1].tileheight / 2,
				x + map.tiled.tilesets[1].tilewidth / 2, y,
				x, y - map.tiled.tilesets[1].tileheight / 2
			))

			end

			if k % 10 == 0 then
				m = m + 1
			end
			k = k + 1
			x = x + map.tiled.tilesets[1].tilewidth / 2
			y = y + map.tiled.tilesets[1].tileheight / 2
		end
		x, y = centerize(offx, offy)
		y = y + (map.tiled.tilesets[1].tileheight / 2) * m
		x = x - (map.tiled.tilesets[1].tilewidth / 2) * m
	end
	return shapes
end


function buildfullshapes(layer, map, offx, offy)
	local k = 1
	local m = 0
	local shapes = {}

	local x, y = centerize(offx, offy)

	for i = 1, layer.height do
		for j = 1, layer.width do

			table.insert(shapes, map.HC:addPolygon(
				x - map.tiled.tilesets[1].tilewidth / 2, y,
				x, y + map.tiled.tilesets[1].tileheight / 2,
				x + map.tiled.tilesets[1].tilewidth / 2, y,
				x, y - map.tiled.tilesets[1].tileheight / 2
			))

			if k % 10 == 0 then
				m = m + 1
			end
			k = k + 1
			x = x + map.tiled.tilesets[1].tilewidth / 2
			y = y + map.tiled.tilesets[1].tileheight / 2
		end
		x, y = centerize(offx, offy)
		y = y + (map.tiled.tilesets[1].tileheight / 2) * m
		x = x - (map.tiled.tilesets[1].tilewidth / 2) * m
	end
	return shapes
end

function buildfullshapes_fix(layer, map, off_x, off_y, off_z)
	local k = 1
	local m = 0
	local shapes = {}

	local x, y = centerize(off_x, off_y - off_z)

	for i = 1, layer.height do
		for j = 1, layer.width do

			table.insert(shapes, map.HC:addPolygon(
				x - map.Data.tilewidth / 2, y,
				x, y + map.Data.tileheight / 2,
				x + map.Data.tilewidth / 2, y,
				x, y - map.Data.tileheight / 2
			))

			if k % layer.width == 0 then
				m = m + 1
			end
			k = k + 1
			x = x + map.Data.tilewidth / 2
			y = y + map.Data.tileheight / 2
		end
		x, y = centerize(off_x, off_y - off_z)
		y = y + (map.Data.tileheight / 2) * m
		x = x - (map.Data.tilewidth / 2) * m
	end
	return shapes
end
