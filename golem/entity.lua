local Utils = require('golem.utils')
local Entity = {}

function Entity:new(props)
  -- Initial properties.
  local entity = {
    props = {},
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
      entity.position[k] = v
    end
  end

  -- Set new size
  -- @param table dimensions
  function entity:setSize(dimensions)
    for k, v in pairs(dimensions) do
      entity.size[k] = v
    end
  end

  -- Set new transform
  -- @param table transforms
  function entity:setTransform(transforms)
    for k, v in pairs(transforms) do
      entity.transform[k] = v
    end
  end

  return entity
end

return Entity
