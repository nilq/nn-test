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

function math.magnitude(x0, y0, x1, y1)
  return math.sqrt((x1-x0)*(x1-x0)+(y1-y0)*(y1-y0))
end

function math.clamp(x, min, max)
  if x > max then return max end
  if x < min then return min end
  return x
end

function math.circle_point (x0, y0, r, x1 ,y1)
  return r>math.magnitude(x0, y0, x1 ,y1)
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

local Agent = require "life/agent"

function love.load()
  math.randomseed(os.time())

  agent_time = 10
  agent_timer = 0
  food_target = 12

  agents = {}
  foods = {}

  for n = 1, 25 do
    local x, y = math.random(0, love.graphics.getWidth()), math.random(0, love.graphics.getHeight())
    local agent = Agent:make(x, y)

    agent:randomize()
    table.insert(agents, agent)
  end

  love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
  for i, v in ipairs(agents) do
    v:update(dt, foods)
  end

  agent_timer = agent_timer + dt

  if agent_time < agent_timer then
    agent_timer = agent_timer - agent_time
    local x, y = math.random(0, love.graphics.getWidth()), math.random(0, love.graphics.getHeight())
    local agent = Agent:make(x, y)

    agent:randomize()
    table.insert(agents, agent)
  end

  while #foods<food_target do
    local x, y = math.random(0, love.graphics.getWidth()), math.random(0, love.graphics.getHeight())
    local a = math.random(5, 10)
    local food = {
      x = x, y = y,
      a = a,
    }
    table.insert(foods, food)
  end
end

function love.draw()
  for i, v in ipairs(foods) do
    love.graphics.setColor(235, 201, 49)
    love.graphics.circle("fill", v.x, v.y, v.a)
  end
  for i, v in ipairs(agents) do
    v:draw()
  end
end
