local Utils = require('golem.utils')
local Entity = {}

function Entity:new(props)
  -- Initial properties.
  local entity = {
    props = {
      speed = 1
    },
    position = {
      x = 0,
      y = 0,
    },
    size = {
      width = 0,
      height = 0,
    },
    transform = {
      rotate = 0,
    },
  }

  -- Assign new props
  if props then
    Utils:assertType(props, 'Entity properties', 'table')
    Utils:extend(entity.props, props)
  end

  -- Abstracts methods.
  function entity:draw() end

  -- Set new position
  -- @param table coords
  function entity:setPosition(coords)
    for k, v in pairs(coords) do
      self.position[k] = v
    end
  end

  -- Set new size
  -- @param table dimensions
  function entity:setSize(dimensions)
    for k, v in pairs(dimensions) do
      self.size[k] = v
    end
  end

  -- Set new transform
  -- @param table transforms
  function entity:setTransform(transforms)
    for k, v in pairs(transforms) do
      self.transform[k] = v
    end
  end

  -- Set new props
  -- @param table transforms
  function entity:setProps(props)
    for k, v in pairs(props) do
      Utils:extend(self.props, props)
    end
  end

  -- Move up
  function entity:moveUp()
    entity:setPosition({
      y = entity.position.y - entity.props.speed
    })
  end

  -- Move down
  function entity:moveDown()
    entity:setPosition({
      y = entity.position.y + entity.props.speed
    })
  end

  -- Move left
  function entity:moveLeft()
    entity:setPosition({
      x = entity.position.x - entity.props.speed
    })
  end

  -- Move right
  function entity:moveRight()
    entity:setPosition({
      x = entity.position.x + entity.props.speed
    })
  end

  return entity
end

return Entity
