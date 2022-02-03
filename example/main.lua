asset = require('libraries/cargo').init('test_map',true)
require('libraries/mapcell')

local test_map = MapCell.new(asset)

function love.load()
  love.graphics.setBackgroundColor({0,0,0})
end

function love.update(dt)
end

function love.draw()
  test_map:drawCell(0,0)
end
