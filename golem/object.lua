local Utils = require('golem.utils')
local Entity = require('golem.entity')
local Object = {
  RectTypes = {
    FILL = 'fill',
    LINE = 'line'
  }
}

-- Image object
-- @param string source
-- @param table  props
function Object:image(source, width, height, props)
  Utils:assertType(source, 'Image source', 'string')

  if props then
    Utils:assertType(props, 'Image Properties', 'table')
  end

  -- New entity instance for image.
  local entity = Entity:new(props)
  local image = love.graphics.newImage(source)

  if width then
    Utils:assertType(width, 'Image width', 'number')
    entity:setSize({
      width = width,
    })
  end

  if height then
    Utils:assertType(height, 'Image height', 'number')
    entity:setSize({
      height = height,
    })
  end

  -- Draw image.
  function entity:draw()
    local oldWidth, oldHeight = image:getDimensions()
    local newWidth = oldWidth
    local newHeight = oldHeight

    if entity.size.width > 0 then
      newWidth = entity.size.width
    end

    if entity.size.height > 0 then
      newHeight = entity.size.height
    end

    local scaleX = newWidth / oldWidth
    local scaleY = newHeight / oldHeight

    -- Draw image based on rotate, and scale
    love.graphics.draw(
      image,
      entity.position.x,
      entity.position.y,
      math.rad(entity.transform.rotate),
      scaleX,
      scaleY
    )
  end

  -- Get image object.
  function entity:get()
    return image
  end

  return entity
end

-- Rectangle object
-- @param number width
-- @param number height
-- @param string type
-- @param table  props
function Object:rectangle(width, height, type, props)
  Utils:assertType(width, 'Rectangle width', 'number')
  Utils:assertType(height, 'Rectangle height', 'number')

  -- Initial props.
  local initialProps = {
    color = {255, 255, 255}
  }

  if props then
    Utils:assertType(props, 'Rectangle properties', 'table')
    Utils:extend(initialProps, props)
  end

  if type == nil then
    type = self.RectTypes.FILL
  end

  -- New entity instance for rectangle.
  local entity = Entity:new(initialProps)

  -- Draw rectangle.
  function entity:draw()
    love.graphics.setColor(entity.props.color)
    love.graphics.rectangle(type, entity.position.x, entity.position.y, width, height)
  end

  return entity
end

return Object
