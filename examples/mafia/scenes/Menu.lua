local Object = require('golem.object')
local Scene = require('golem.scene')

-- New scene with black background
local MenuScene = Scene:new({
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
-- @type Object:image
local image = Object:image('assets/mafia.jpg', 200, 150)

-- Rectangle
-- @type Object:rectangle
local rect = Object:rectangle(250, 250)

-- -- BG Sound
-- local bgsound = Object:sound('bgsound', 'assets/bg.mp3')

-- -- Player
-- local player = Object:character('player', {
--   hp: 100
-- })

-- -- Enemy
-- local enemy = Object:character('enemy', {
--   x: 100,
--   y: 100,
--   hp: 50
-- })

function MenuScene:canvas()
  -- Add objects to canvas
  self:add('background', image)
  self:add('rect', rect)
  -- self:add(bgsound)
  -- self:add(player)
  -- self:add(enemy)
end

function MenuScene:enter()
  print('enter scene')
end

function MenuScene:action()
  -- player:input('w', function ()
  --   player:moveUp()
  -- end)

  -- player:collisionWith(enemy, function ()
  --   print('Game over')
  -- end)
end

return MenuScene
