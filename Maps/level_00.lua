return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "isometric",
  width = 10,
  height = 10,
  tilewidth = 128,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "isotest",
      firstgid = 1,
      tilewidth = 128,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "Images/isotest.png",
      imagewidth = 1024,
      imageheight = 512,
      properties = {},
      tiles = {
        {
          id = 1,
          properties = {
            ["ground"] = "1"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Calque de Tile 1",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 0,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 2, 2, 2, 2, 2, 2, 2, 2, 9,
        0, 0, 11, 11, 11, 11, 11, 11, 11, 10
      }
    }
  }
}
