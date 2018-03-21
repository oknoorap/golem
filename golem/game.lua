local Utils = require('golem.utils')
local SceneMgr = require('golem.sceneMgr')
local TickerMgr = require('golem.tickerMgr')

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
  Game.ticker = TickerMgr:new(self.config.id)

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
  self.ticker:tick(dt)
end

-- Game renderer
function Game:render()
  local currentScene = self.scene:currentScene()
  local scene = self.scene:get(currentScene)
  
  -- Draw scene
  scene:draw()
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

return Game
