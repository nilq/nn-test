function math.sigmoid(n)
  return 1 / (1 + math.exp(-n))
end
function math.dotn(a, b) -- #a <=> #b
  local dot = 0
  for n = 1, #a do
    dot = dot + a[n] * b[n]
  end
  return dot
end
function math.sum(list)
  local sum = 0
  for n = 1, #list do
    sum = sum + list[n]
  end
  return sum
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

  local Agent = require "life/agent"
  agent = Agent:make(100, 100)
  agent:randomize()

  love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
  agent:update(dt)
end

function love.draw()
  agent:draw()
end
