local Agent = {}
function Agent:make(x, y)
  local agent = {
    network = {},
    -- movement
    x = x, y = y,
    dx = 0, dy = 0,
    r = 0,
  }
  function agent:randomize()
    local Network = require "intelligence/network"
    self.network = Network:make(2, 3)
    self.network:randomize()
  end
  function agent:update(dt)
    local response = self.network:pass({[1]=os.time(), [2]=1})
    local t1, t2 = response[1], response[2]
    local s = response[3]

    self.r = self.r + (t1 - t2) * dt

    self.x = self.x + math.cos(self.r) * s
    self.y = self.y + math.sin(self.r) * s
  end
  function agent:draw()
    love.graphics.setColor(255, 255, 0)
    love.graphics.circle("fill", self.x, self.y, 12)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", self.x, self.y, 12)
  end
  return agent
end
return Agent
