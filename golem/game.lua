local SceneMgr = require('golem.sceneMgr')
local TickerMgr = require('golem.tickerMgr')

local Game = {
  props = {
    WIDTH = love.graphics.getWidth(),
    HEIGHT = love.graphics.getHeight(),
  },
  config = nil,
  scene = nil,
  ticker = nil,
}

-- Create new instance
function Game:new(config)
  -- Set config
  assert(type(config) == 'table', 'Game should has config.')
  assert(config.id, 'Game ID should be exists in config.')
  Game.config = config

  -- Init Ticker Manager
  Game.ticker = TickerMgr:new(self.config.id)

  -- Init Scenes Manager
  Game.scene = SceneMgr:new()

  -- Local instance
  local game = {}

  -- Start game engine.
  -- @param sceneName Scene Name in scene folder.
  function game:start(sceneName)
    Game.scene:add(sceneName)
    
    -- Call start scene immediately
    local startScene = Game.scene:get(sceneName)
    startScene:prepare()
  end

  -- Game state management

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
