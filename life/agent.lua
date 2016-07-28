local Agent = {}
function Agent:make(x, y)
  local agent = {
    network = {},
    -- movement
    x = x, y = y,
    dx = 0, dy = 0,
    r = 0, radius = 10,
    -- kinda unique
    food = 100,
    color = {},
  }
  function agent:health()
    -- plz fix stupid hard coded values
    return math.abs(100 - self.food)
  end
  function agent:randomize()
    local Network = require "intelligence/network"
    self.network = Network:make(3, 3) --(input, output)
    self.network:randomize()

    self.color.r = math.random(0, 255)
    self.color.g = math.random(0, 255)
    self.color.b = math.random(0, 255)

    self.r = math.random(0, 360)
  end
  function agent:mutate(min, max)
    self.network = Network:mutate(min, max)

    self.color.r = math.clamp(self.color.r + math.random(-10, 10), 0, 255)
    self.color.g = math.clamp(self.color.g + math.random(-10, 10), 0, 255)
    self.color.b = math.clamp(self.color.b + math.random(-10, 10), 0, 255)
  end
  function agent:update(dt, foods)
    self.feelerR = {x = self.x+math.cos(self.r + 0.5) * 30, y = self.y + math.sin(self.r + 0.5) * 30}
    self.feelerL = {x = self.x+math.cos(self.r - 0.5) * 30, y = self.y + math.sin(self.r - 0.5) * 30}

    self.foodSmellR = 0
    self.foodSmellL = 0
    for i,v in ipairs(foods) do
      self.foodSmellR = self.foodSmellR + 1/math.magnitude(self.feelerR.x, self.feelerR.y, v.x, v.y)
      self.foodSmellL = self.foodSmellL + 1/math.magnitude(self.feelerL.x, self.feelerL.y, v.x, v.y)

      if math.circlePoint(self.x, self.y, self.radius, v.x, v.y) then
        self.food = self.food + v.a * 2
        table.remove(foods, i)
      end
    end

    local response = self.network:pass({[1]=self.foodSmellR, [2]=self.foodSmellL, [3]=self:health()})
    local t1, t2 = response[1], response[2]
    local s = response[3]

    self.r = self.r + (t1 - t2) * dt

    self.x = self.x + math.cos(self.r) * s
    self.y = self.y + math.sin(self.r) * s

    self.x = self.x % love.graphics.getWidth()
    self.y = self.y % love.graphics.getHeight()

    self.food = self.food - 2 * dt * s

    if self:health() >= 100 then
      for i, v in ipairs(agents) do
        if v == self then
          table.remove(agents, i)
        end
      end
    end
  end
  function agent:draw()
    self.feelerR = {x = self.x+math.cos(self.r + 0.5) * 30, y = self.y + math.sin(self.r + 0.5) * 30}
    self.feelerL = {x = self.x+math.cos(self.r - 0.5) * 30, y = self.y + math.sin(self.r - 0.5) * 30}

    love.graphics.setColor(0, 0, 0)
    love.graphics.line(self.x, self.y, self.feelerR.x, self.feelerR.y)
    love.graphics.line(self.x, self.y, self.feelerL.x, self.feelerL.y)

    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.circle("fill", self.x, self.y, self.radius)

    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", self.x, self.y, self.radius)

    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", self.x - 2*self.radius, self.y - 15, self.food/25*self.radius, 4)
  end
  return agent
end
return Agent
