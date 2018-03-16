local Object = require('golem.object')
local Scene = require('golem.scene')
local MenuScene = Scene.new()

-- Objects declaration
-- Background
-- local background = Object:image('background', 'assets/bg.png')

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

function MenuScene:prepare()
  print('prepare')
  -- Add objects to screen
  -- self:add(background)
  -- self:add(bgsound)
  -- self:add(player)
  -- self:add(enemy)
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
