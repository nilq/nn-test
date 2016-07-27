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

  agents = {}

  for n = 1, 25 do
    local x, y = math.random(0, love.graphics.getWidth()), math.random(0, love.graphics.getHeight())
    local agent = Agent:make(x, y)
    agent:randomize()
    table.insert(agents, agent)
  end

  love.graphics.setBackgroundColor(220, 220, 220)
end

function love.update(dt)
  for i, v in ipairs(agents) do
    v:update(dt)
  end
end

function love.draw()
  for i, v in ipairs(agents) do
    v:draw()
  end
end
