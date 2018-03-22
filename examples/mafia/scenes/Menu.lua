local Object = require('golem.object')
local Scene = require('golem.scene')

-- New scene with black background
local MenuScene = Scene:new({
  width = 500,
  height = 500,
  background = {
    color = {
      r = 0,
      g = 0,
      b = 0,
      a = 255
    }
  }
})

-- Image
local image = Object:image('assets/mafia.jpg', 200, 150)
local rect = Object:rectangle(50, 50)

-- Draw on canvas
function MenuScene:canvas()
  self:add('background', image)
  self:add('rect', rect, Scene.PositionTypes.CENTER, Scene.PositionTypes.CENTER)
end

-- Scene on enter
function MenuScene:enter()
  print('Menu scene enter!')
end

function MenuScene:leave()
  print('Menu scene leave!')
end

-- Scene on action
function MenuScene:action()
  self:input('w', function() rect:moveUp() end)
  self:input('s', function() rect:moveDown() end)
  self:input('a', function() rect:moveLeft() end)
  self:input('d', function() rect:moveRight() end)
end

return MenuScene
