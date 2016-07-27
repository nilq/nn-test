local Layer = {}
function Layer:make(size)
  local layer = {
    w = {}, -- weights
    x = {}, -- values
    b = {}, -- biases
  }
  --initiate list with correct size (so it can be used for further calculations)
  for n = 1, size do
    layer.x[n] = 0
    layer.w[n] = {}
    layer.b[n] = {}
  end
  -- randomize weights and biases
  function layer:randomize(last)
    for n = 1, #self.x do --for every neuron
      for o = 1, #last.x do --give it a weigth/bias for every input it has
        self.w[n][o] = math.random(-100, 100) / 100
        self.b[n][o] = math.random(-100, 100) / 100
      end
    end
  end
  -- takes layer and calculates
  function layer:calculate(last)
    for n = 1, #self.x do --for every neuron in this layer
      -- sigmoid("weights" dot "inputs" + "bias")
      self.x[n] = math.sigmoid(
        math.dotn(self.w[n], last.x) + math.sum(self.b[n])
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
    for n = 1, #self.w do --for every neuron
      for o = 1, #self.w[1] do --mutate it a weigth/bias for every input it has
        self.w[n][o] = self.w[n][o] + math.random(min * 100, max * 100) / 100
        self.b[n][o] = self.b[n][o] + math.random(min * 100, max * 100) / 100
      end
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
