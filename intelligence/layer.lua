local Layer = {}
function Layer:make(size)
  local layer = {
    w = {}, -- weights
    x = {}, -- values
    b = {}, -- biases
  }
  -- randomize weights and biases
  function layer:randomize()
    for n = 1, size do
      self.w[#self.w + 1] = math.random(-100, 100)/100
      self.b[#self.b + 1] = math.random(-100, 100)/100
    end
  end
  -- takes layer and calculates
  function layer:calculate(last)
    for n = 1, #last.x do
      -- sigmoid("weights" dot "inputs" + "bias")
      self.x[n] = math.sigmoid(
        math.dotn(last.w, last.x) + last.b[n]
      )
    end
  end
  -- takes and sets values
  function layer:set(values)
    for n = 1, #values do
      self.x[n] = values[n]
    end
  end
  function layer:mutate(min, max)
    for n = 1, #self.w do
      self.w[n] = self.w[n] + math.random(min * 100, max * 100) / 100
      self.b[n] = self.b[n] + math.random(min * 100, max * 100) / 100
    end
  end
  function layer:concat()
    local text = "["
    for n = 1, #self.x do
      text = text .. self.x[n]
      if n ~= #self.x then
        text = text .. ", "
      end
    end
    return text.."]"
  end
  return layer
end
return Layer
