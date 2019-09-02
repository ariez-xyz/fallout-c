----------------------
-- global variables --
----------------------
map = {}
tiles = {}
objects = {}
drawBuffer = {}

spritesheet = 0

worldSizeX = 0
worldSizeY = 0

cameraX = 0
cameraY = 0

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

