local Utils = require('golem.utils')
local SceneMgr = {}

function SceneMgr:new()
  -- Instance
  local sceneMgr = {}

  -- Scene list
  local list = {}

  -- Scene directory
  local path = 'scenes'

  -- Scene transition manager
  local prevScene = nil
  local currentScene = nil
  local nextScene = nil

  -- Register new scene
  -- @param string sceneName
  function sceneMgr:add(sceneName)
    Utils:assertType(sceneName, 'Scene name', 'string')
    local sceneModule = require(path .. '.' .. sceneName)
    list[sceneName] = sceneModule
  end

  -- Get scene instance
  -- @param string sceneName
  function sceneMgr:get(sceneName)
    Utils:assertType(sceneName, 'Scene name', 'string')
    Utils:assertExists(list[sceneName], 'Scene name', 'scene list')

    return list[sceneName]
  end

  -- Remove scene from list
  -- @param string sceneName
  function sceneMgr:remove(sceneName)
    Utils:assertType(sceneName, 'Scene name', 'string')
    list[sceneName] = nil
  end

  -- Get scene list
  function sceneMgr:list()
    return list
  end

  -- Get current scene name
  function sceneMgr:currentScene()
    return currentScene
  end

  -- Set current scene
  function sceneMgr:setCurrent(sceneName)
    Utils:assertType(sceneName, 'Scene name', 'string')
    Utils:assertExists(sceneName, 'Scene name', 'scene list')
    currentScene = sceneName
  end

  return sceneMgr
end

return SceneMgr
