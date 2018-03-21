local Utils = {}

-- Assert type.
-- @param mixed  var
-- @param string varType
function Utils:assertType(var, alias, varType)
  assert(type(var) == varType, '`' .. alias .. '` should be a `' .. varType .. '`')
end

-- Assert exists.
-- @param mixed var
-- @param mixed var2
function Utils:assertExists(var, alias, existsIn)
  assert(var ~= nil, '`' .. alias .. '` must be not nil')
  assert(var, '`' .. alias .. '` not exists in ' .. existsIn)
end

-- Assert equal.
-- @param mixed var
-- @param mixed var2
function Utils:assertEqual(var, var2, alias)
  assert(var == var2, '`' .. alias .. '` should be equal with ' .. var2)
end

-- Extend table.
-- @param table   default
-- @param table   newTable
-- @param boolean isRef
function Utils:extend(default, newTable, isRef)
  local ref = isRef or true
  local _table = {}

  if ref then
    _table = default
  else
    for k, v in pairs(default) do
      _table[k] = v
    end
  end

  for k, v in pairs(newTable) do
    if type(newTable[k]) == 'table' then
      if _table[k] then
        self:extend(_table[k], newTable[k])
      else
        _table[k] = newTable[k]
      end
    else
      _table[k] = v
    end
  end

  if ref == false then
    return _table
  end
end

return Utils
