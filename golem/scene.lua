local Utils = require('golem.utils')
local Canvas = require('golem.canvas')
local Scene = {}

function Scene:new(props)
  -- Initial properties.
  local scene = {
    props = {
      width = game.props.ui.WIDTH,
      height = game.props.ui.HEIGHT,
      background = {
        color = {
          r = 255,
          g = 255,
          b = 255,
          a = 255,
        },
        image = nil
      }
    }
  }
  -- Assign new props.
  if props then
    Utils:assertType(props, 'Scene properties', 'table')
    Utils:extend(scene.props, props)
  end

  -- Objects store.
  local objects = {}

  -- Init canvas
  local canvas = Canvas:new(scene.props.width, scene.props.height, scene.props.background.color)

  -- Abstract methods.
  function scene:canvas() end
  function scene:enter() end
  function scene:leave() end

  -- Set scene properties
  function scene:setProps(props)
    Utils:extend(scene.props, props)
  end

  -- Add object to scene objects.
  -- @param string name
  -- @param Entity object
  function scene:add(name, object)
    objects[name] = object
  end

  -- Remove object from scene objects.
  -- @param string name
  function scene:remove(name)
    if objects[name] then
      objects[name] = nil
    end
  end

  -- Get object name.
  -- @param string name
  function scene:object(name)
    return objects[name]
  end

  -- Get layer list.
  function scene:objects()
    return objects
  end

  -- Draw canvas
  function scene:draw()
    -- Draw canvas.
    canvas:draw()

    -- Draw all objects.
    local objects = scene:objects()
    for _, obj in pairs(objects) do
      obj:draw()
    end

    -- Reset canvas to original canvas.
    canvas:reset()
  end

  return scene
end

return Scene
