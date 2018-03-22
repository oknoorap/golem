local Utils = require('golem.utils')
local Entity = require('golem.entity')
local Object = {}

-- Image object
-- @param string source
-- @param table  props
function Object:image(source, width, height, props)
  Utils:assertType(source, 'Image source', 'string')
  
  -- Initial props.
  local initialProps = {}
  
  if props then
    Utils:assertType(props, 'Image Properties', 'table')
    Utils:extend(initialProps, props)
  end
  
  -- New entity instance for image.
  local image = love.graphics.newImage(source)
  local entity = Entity:new(props)

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

  -- Global function to clear screen before draw an object.
  local function clearScreen()
    love.graphics.setColor(255, 255, 255, 255)
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
    clearScreen()
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
-- @param table  props
function Object:rectangle(width, height, props)
  Utils:assertType(width, 'Rectangle width', 'number')
  Utils:assertType(height, 'Rectangle height', 'number')

  -- Initial props.
  local initialProps = {
    color = {
      r = 255, 
      g = 255,
      b = 255,
      a = 255,
    },
    radius = {
      x = 0,
      y = 0
    },
    stroke = {
      color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
      },
      width = 1,
      style = 'inset'
    }
  }

  if props then
    Utils:assertType(props, 'Rectangle properties', 'table')
    Utils:extend(initialProps, props)
  end

  -- New entity instance for rectangle.
  local entity = Entity:new(initialProps)

  -- Set rectangle size.
  entity:setSize({
    width = width,
    height = height
  })

  -- Draw rectangle.
  function entity:draw()
    -- Draw rectangle body
    love.graphics.setColor(entity.props.color.r, entity.props.color.g, entity.props.color.b, entity.props.color.a)
    love.graphics.rectangle('fill', entity.position.x, entity.position.y, width, height, entity.props.radius.x, entity.props.radius.y)

    -- Draw rectangle border
    love.graphics.setColor(entity.props.stroke.color.r, entity.props.stroke.color.g, entity.props.stroke.color.b, entity.props.stroke.color.a)
    love.graphics.setLineWidth(entity.props.stroke.width)
    love.graphics.line(
      entity.position.x, entity.position.y,
      entity.position.x + width, entity.position.y,
      entity.position.x + width, entity.position.y + height,
      entity.position.x, entity.position.y + height,
      entity.position.x, entity.position.y
    )
  end

  return entity
end

return Object
