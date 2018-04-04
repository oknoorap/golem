local Utils = require('golem.utils')
local Canvas = {}

-- New canvas
-- @param number width
-- @param number height
function Canvas:new(width, height, color)
  Utils:assertType(width, 'Canvas width', 'number')
  Utils:assertType(height, 'Canvas height', 'number')

  if color then
    Utils:assertType(color, 'Canvas Color', 'table')
    Utils:assertType(color.r, 'Red Color', 'number' )
    Utils:assertType(color.g, 'Green Color', 'number' )
    Utils:assertType(color.b, 'Blue Color', 'number' )
    Utils:assertType(color.a, 'Alpha Color', 'number' )
  end

  -- Default color values.
  color = color or {
    r = 0,
    g = 0,
    b = 0,
    a = 255,
  }

  local canvas = {
    graphic = love.graphics.newCanvas(width, height)
  }

  -- Init canvas
  love.graphics.setCanvas(self.graphic)
  love.graphics.setBlendMode('alpha')

  function canvas:draw()
    love.graphics.clear()
    love.graphics.push()
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.rectangle('fill', 0, 0, width, height)
    love.graphics.setScissor(0, 0, width, height)
    love.graphics.draw(self.graphic)
  end

  -- Reset canvas
  function canvas:reset()
    love.graphics.pop()
    love.graphics.setScissor()
    love.graphics.setCanvas()
  end

  return canvas
end

return Canvas
