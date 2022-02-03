local lunajson = require('libraries/lunajson')

-- Tilesetter map loading and drawing library
-- REQUIRES lunajson AND cargo
-- Made by Bardificer
MapCell = {
    src = nil,
    json = nil,
    tile_size = 0,
    map_width = 0,
    map_height = 0,
    funct = nil,
    bkg = nil,
    pos = nil,
    sources = nil,
    bkgGrid = nil
}
MapCell.__index = MapCell

-- @brief creates a new MapCell object
-- @param cargo object with path to the folder that the png and json fall in
-- @return MapCell object
function MapCell.new(path)
    local new_map = {}
    setmetatable(new_map, MapCell)
    new_map:init(path)
    return new_map
end

function MapCell:init(path)
    tmp = lunajson.decode(path.json)
    self.src = path.src
    self.json = tmp
    self.tile_size = tmp.tile_size
    self.map_width = tmp.map_width
    self.map_height = tmp.map_height
    self.funct = tmp.layers[2]
    self.bkg = tmp.layers[1]
    self.pos = {}
    self.pos.x = 0
    self.pos.y = 0
    self.chunks = chunk_source(self.src,self.tile_size)
    self.grid = self:initCell(self.bkg)

end

-- @brief separates the tileset quads
-- @param src tileset png
-- @param tile_size size of square tiles side length
-- @result a list of quads relating the tile index to the texture
function chunk_source(src,tile_size)
    sendback = {}
    parent = {
        height = src:getHeight(),
        width = src:getWidth()
    }
    x=0
    for x=0,parent.width, tile_size
    do
        temp_quad = love.graphics.newQuad(x,0,tile_size,tile_size,src)
        sendback[tostring(x/32)] = temp_quad
    end

    return sendback
end

-- @brief creates a grid inside love to manage drawing
-- @param the layer to create the grid for
-- @result a 2D array of tile indecies
function MapCell:initCell( layer)
    grid = {}
    x = 0
    y = 0
    for x=0, self.map_width, 1
    do
        grid[x] = {}
        for y=0, self.map_height, 1
        do
            grid[x][y]= nil
        end
    end
    count = 1
    for count=1, #(layer['positions']), 1
    do
        local index_set = layer['positions'][count]
        tmpx = index_set['x']
        tmpy = index_set['y']
        grid[tmpx][tmpy] = index_set['id']
    end

    return grid
end

-- @brief draws a single tile (chunk)
-- @param index ID for the tile to grab texture
-- @param x location to draw at
-- @param y location to draw at
function MapCell:drawChunk(index,x,y)

    love.graphics.draw(self.src,self.chunks[tostring(index)],x,y)
end
-- @brief draws an entire cell
-- @param x location to draw at
-- @param y location to draw at
function MapCell:drawCell(x,y)
    tmpx = 0
    tmpy = 0
    chunkSize=self.tile_size
    for tmpx=0,self.map_width,1
    do
        for tmpy=0,self.map_height,1
        do
            if self.grid[tmpx][tmpy] ~= nil
            then
                self:drawChunk(self.grid[tmpx][tmpy],chunkSize*tmpx+x,chunkSize*tmpy+y)
            end
        end
    end
end
