local Scene = {}

function Scene:new()
  local scene = {}

  function scene:prepare() end
  function scene:action() end

  return scene
end

return Scene
