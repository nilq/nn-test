function math.sigmoid(n)
  return 1 / (1 + math.exp(-n))
end
function math.dotn(a, b) -- #a <=> #b
  local dot = 0
  for n = 1, #a do
    print(a[n], b[n])
    dot = dot + a[n] * b[n]
  end
  print("\n")
  return dot
end
function table.copy_recursive(obj, seen)
  if type(obj) ~= "table" then
    return obj
  end
  if seen and seen[obj] then
    return seen[obj]
  end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do
    res[table.copy_recursive(k, s)] = table.copy_recursive(v, s)
  end
  return res
end
function love.load()
  math.randomseed(os.time())

  local Network = require "intelligence/network"
  local net = Network:make(3, 5)

  net:randomize()

  local inputs = {
    [1] = 0.5,
    [2] = 128,
    [3] = 15.95,
  }

  local out = net:pass(inputs)
  print(out:concat())
end

function love.update(dt)

end

function love.draw()

end
