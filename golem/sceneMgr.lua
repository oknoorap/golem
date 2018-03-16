local SceneMgr = {}

function SceneMgr:new()
  -- Instance
  local sceneMgr = {}

  -- Scene List
  local list = {}

  -- Scene directory
  local path = 'scenes'

  -- Register new scene
  function sceneMgr:add(sceneName)
    assert(type(sceneName) == 'string', 'Scene name should be a `string`.')
    local sceneModule = require(path .. '.' .. sceneName)
    list[sceneName] = sceneModule
  end

  -- Get scene instance
  function sceneMgr:get(sceneName)
    assert(type(sceneName) == 'string', 'Scene name should be a `string`.')
    assert(list[sceneName], 'Scene name not exists in scene list.')

    return list[sceneName]
  end

  -- Remove scene from list
  function sceneMgr:remove(sceneName)
    assert(type(sceneName) == 'string', 'Scene name should be a `string`.')
    list[sceneName] = nil
  end

  return sceneMgr
end

return SceneMgr
