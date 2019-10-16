----------------------
-- global variables --
----------------------
map = {} -- list of 2d arrays representing each layer of the map
quads = {} -- for spritesheets: quads[i] = section of sprites[i] that cotains sprite i
sprites = {} -- sprites[i] = sprite or spritesheet that contains sprite i
terrain = {} -- terrain[i] = terrain type of sprite i

objects = {}
drawBuffer = {}

worldSizeX = nil
worldSizeY = nil

cameraX = nil
cameraY = nil

moveSpeed = 500

tileSize = 16                       -- size of assets - better don't change this without changing assets

-------------------
-- magic numbers --
-------------------

--general

TRANSPARENT_TILE = 0
UNKNOWN_TILE = -1               -- red question mark tile

DMIRROR_FLAG = 29               -- indexes of the bitflags used by tiled to mark
VMIRROR_FLAG = 30               -- diagonally, vertically or horizontally mirrored 
HMIRROR_FLAG = 31               -- tiles via their tile id

-- event ids
events = require("controllers/events")

------------------------
-- inferred constants --
------------------------
renderGridSize = winGridSize - 1

winBaseSize = renderGridSize * tileSize -- tiles are 8px
winWidth = winBaseSize * winSizeMult
winHeight = winBaseSize * winSizeMult

tileRenderSize = tileSize * winSizeMult
