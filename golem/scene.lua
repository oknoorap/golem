local Utils = require('golem.utils')
local Canvas = require('golem.canvas')
local Ticker = require('golem.ticker')
local Scene = {
  PositionTypes = {
    LEFT = 'left',
    RIGHT = 'right',
    CENTER = 'center',
    TOP = 'top',
    BOTTOM = 'bottom',
  }
}

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
    },
    inputs = {
      hold = nil,
      history = {},
    },
    ticker = Ticker.new(),
    is = {
      enter = false,
      leave = false,
      idle = true,
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
  function scene:action() end
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
  -- @param mixed  x
  -- @param mixed  y
  function scene:add(name, object, x, y, index)
    if object then
      if x == Scene.PositionTypes.LEFT then
        x = 0
      elseif x == Scene.PositionTypes.RIGHT then
        x = self.props.width - object.size.width
      elseif x == Scene.PositionTypes.CENTER then
        x = (self.props.width / 2) - (object.size.width / 2)
      end

      if y == Scene.PositionTypes.TOP then
        y = 0
      elseif y == Scene.PositionTypes.BOTTOM then
        y = self.props.height - object.size.height
      elseif y == Scene.PositionTypes.CENTER then
        y = (self.props.height / 2) - (object.size.height / 2)
      end

      object:setPosition({
        x = x or object.position.x,
        y = y or object.position.y,
      })

      -- Set object layer z-index.
      if index == nil then
        local length = 0
        for k, v in pairs(objects) do
          length = length + 1
        end

        object:setProps({
          index = length + 1
        })
      else
        object:setProps({
          index = index
        })
      end

      -- Set object name.
      object:setProps({
        name = name
      })

      objects[name] = object
    end
  end

  -- Remove object from scene objects.
  -- @param string name
  function scene:remove(name)
    if objects[name] then
      objects[name] = nil
    end
  end

  -- Update scene ticker
  -- @param float dt
  function scene:tick(dt)
    self.ticker:tick(dt)
  end

  -- Get object name.
  -- @param string name
  function scene:object(name)
    if objects[name] then
      return objects[name]
    end
  end

  -- Get layer list.
  function scene:objects()
    local list = {}

    for _, obj in pairs(objects) do
      table.insert(list, obj)
    end

    return list
  end

  -- Draw canvas
  function scene:draw()
    -- Draw canvas.
    canvas:draw()

    -- Draw all objects based on layer index.
    local objects = scene:objects()

    -- Sort layers by index.
    table.sort(objects, function (a, b) return a.props.index < b.props.index end)

    -- Draw objects.
    for i = 1, #objects do
      objects[i]:draw()
    end

    -- Enter scene.
    if scene.is.enter == false then
      scene:enter()
      scene.is.enter = true
    end

    -- Reset canvas to original canvas.
    canvas:reset()
  end

  -- Input event adder
  -- @param string  key
  -- @param boolean hold
  function scene:addInput(key, hold)
    Utils:assertType(key, 'Input key', 'string')

    self.is.idle = false

    if hold then
      Utils:assertType(hold, 'Hold key', 'boolean')
      self.inputs.hold = key
    else
      local inputLength = #self.inputs.history
      if inputLength > 10 then
        for i = inputLength - 9, inputLength do
          table.insert(self.inputs.history, self.inputs.history[i])
        end
      end

      table.insert(self.inputs.history, key)
    end
  end

  -- Input event remove
  function scene:removeInput(key)
    Utils:assertType(key, 'Input key', 'string')

    self.inputs.hold = nil
    self.is.idle = true
  end

  -- Input event listener
  -- @param string   key
  -- @param function fn
  function scene:input(key, fn)
    Utils:assertType(key, 'Input Key', 'string')
    Utils:assertType(fn, 'Input Callback', 'function')

    if self.inputs.hold == key then
      fn(key)
    end
  end

  return scene
end

return Scene
