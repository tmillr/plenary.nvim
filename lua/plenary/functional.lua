local f = {}

function f.map(fun, iter)
  local results = {}
  for _, v in pairs(iter) do
    table.insert(results, fun(v))
  end

  return results
end

function f.partial(fun, ...)
  local args = {...}
  return function(...)
    return fun(unpack(args), ...)
  end
end

function f.any(f, iterable)
  for k, v in pairs(iterable) do
    if f(k, v) then
      return true
    end
  end

  return false
end

function f.all(f, iterable)
  for k, v in pairs(iterable) do
    if not f(k, v) then
      return false
    end
  end

  return true
end

function f.if_nil(val, was_nil, was_not_nil)
  if val == nil then
    return was_nil
  else
    return was_not_nil
  end
end

function f.select_only(n)
  return function(...)
    local x = select(n, ...)
    return x
  end
end

f.first = f.select_only(1)
f.second = f.select_only(2)
f.third = f.select_only(3)

function f.last(...)
  local length = select('#', ...)
  local x = select(length, ...)
  return x
end

return f