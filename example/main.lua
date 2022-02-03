require('libraries/cargo').init('assets',true)

local test_map = MapCell.new(assets.test_map)

function love.load()
  love.graphics.setBackgroundColor({0,0,0})
end

function love.update(dt)
end

function love.draw()
  test_map:drawCell(0,0)
end
