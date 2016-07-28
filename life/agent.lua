local Agent = {}
function Agent:make(x, y)
  local agent = {
    network = {},
    -- movement
    x = x, y = y,
    dx = 0, dy = 0,
    r = 0,
    -- health
    food = 100,
    color = {},
  }
  function agent:randomize()
    local Network = require "intelligence/network"
    self.network = Network:make(2, 3)
    self.network:randomize()

    self.color.r = math.random(0, 255)
    self.color.g = math.random(0, 255)
    self.color.b = math.random(0, 255)
  end
  function agent:update(dt)
    local response = self.network:pass({[1]=os.time(), [2]=1})
    local t1, t2 = response[1], response[2]
    local s = response[3]

    self.r = self.r + (t1 - t2) * dt

    self.x = self.x + math.cos(self.r) * s
    self.y = self.y + math.sin(self.r) * s

    self.x = self.x % love.graphics.getWidth()
    self.y = self.y % love.graphics.getHeight()
  end
  function agent:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.line(self.x, self.y, self.x+math.cos(self.r + 0.5) * 30, self.y + math.sin(self.r + 0.5) * 30)
    love.graphics.line(self.x, self.y, self.x+math.cos(self.r - 0.5) * 30, self.y + math.sin(self.r - 0.5) * 30)

    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.circle("fill", self.x, self.y, 10)

    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", self.x, self.y, 10)
  end
  return agent
end
return Agent
