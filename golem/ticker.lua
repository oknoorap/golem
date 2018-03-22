local Utils = require('golem.utils')
local Ticker = {}

function Ticker:new()
  local ticker = {}
  local elapsed = 0

  -- Update ticker
  -- @param float dt
  function ticker:tick(dt)
    elapsed = elapsed + 1 * dt
  end

  -- Get current elapsed time
  function ticker:elapsed()
    return elapsed
  end

  -- Reset ticker to zero
  function ticker:reset()
    elapsed = 0
  end

  return ticker
end

return Ticker
