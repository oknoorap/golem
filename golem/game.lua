local Utils = require('golem.utils')
local Ticker = require('golem.ticker')
local SceneMgr = require('golem.sceneMgr')

local Game = {
  config = nil,
  scene = nil,
  ticker = nil,
}

-- Create new instance
function Game:new(config)
  -- Set config
  Utils:assertType(config, 'Config', 'table')
  Utils:assertExists(config.id, 'ID', 'Game Config')
  Game.config = config

  -- Init Ticker Manager
  Game.ticker = Ticker:new()

  -- Init Scenes Manager
  Game.scene = SceneMgr:new()

  -- Local instance
  local game = {
    props = {
      ui = {
        WIDTH = love.graphics.getWidth(),
        HEIGHT = love.graphics.getHeight(),
      },
    },
  }

  -- Start game engine.
  -- @param sceneName Scene Name in scene folder.
  function game:start(sceneName)
    -- Add game to scene list and set it as current scene
    Game.scene:add(sceneName)
    Game.scene:setCurrent(sceneName)
    
    -- Call start scene immediately
    local initialScene = Game.scene:get(sceneName)
    initialScene:canvas()
  end

  return game
end

-- Game init
function Game:init()
  -- Set window title
  if self.config.title then
    love.window.setTitle(self.config.title)
  end
end

-- Game ticker updater
function Game:tick(dt)
  local scene = self.scene:get(self.scene:currentScene())
  -- Detect input keys

  -- Update ticker
  if dt then
    self.ticker:tick(dt)
    scene:action()
  end
end

-- Game renderer
function Game:render()
  local scene = self.scene:get(self.scene:currentScene())

  -- Draw scene
  scene:draw()
end

-- Key pressed input
function Game:keypressed(key)
  local scene = self.scene:get(self.scene:currentScene())
  scene:addInput(key)
end

-- Key released input
function Game:keyreleased(key)
  local scene = self.scene:get(self.scene:currentScene())
  scene:removeInput(key)
end

-- Game events
function Game:exit()
  local scene = self.scene:get(self.scene:currentScene())
  scene:leave()
  return false
end

-- Game initialization
function love.load()
  Game:init()
end

-- Update Game
function love.update(dt)
  Game:tick(dt)
end

-- Render game
function love.draw()
  Game:render()
end

-- Detect input
function love.keypressed(key)
  Game:keypressed(key)
end

function love.keyreleased(key)
  Game:keyreleased(key)
end

-- Events
function love.quit()
  return Game:exit()
end

return Game
