local Ticker = {}

function Ticker:new(id)
  assert(id ~= nil, 'Ticker `id` should be not nil.')

  local ticker = {}
  local tickers = {}

  -- Add ticker to table
  function ticker:add()
    tickers[id] = 0
  end

  -- Remove ticker
  function ticker:remove()
    tickers[id] = nil
  end

  -- Update ticker
  function ticker:tick(dt)
    tickers[id] = tickers[id] + 1 * dt
  end

  -- Add ticker when initialize
  ticker:add(id)

  return ticker
end

return Ticker
