local Layer = {}
-- sigmoid hidden layer
function Layer:randomize(s) -- size
  local Vector = require "util/vector"
  local layer = {
    w = {}, -- weights
    b = {}, -- biases
    x = {}, -- sigmoid neurons
  }
  layer.w = Vector:make()
  layer.b = Vector:make()
  layer.x = Vector:make()
  for n = 1, s do
    -- weights and bias -100 to 100
    -- doesn't matter however, during to sigmoid
    layer.w:put(math.random(-100, 100))
    -- how likely a neuron is to fire
    layer.b:put(math.random(-100, 100))
  end
  -- set outputs, inputs for next layer
  function layer:output(w, x, b) -- input from layer before
    -- "x"s not yet put
    for n = 1, s do
      self.x.put(math.sigmoid(Vector:dot(w, x) + b))
    end
  end
  -- meant for i.e. input layer
  function layer:set_output(x)
    for n = 1, s do
      self.x[n].put(x[n])
    end
  end
  function layer:mutate(p, m) -- chance, mutate range
    for n = 1, self.w do
      if math.random(0, 100) < p then
        self.w[n] = self.w[n] + math.random(-m, m) -- mutate weight
        self.b[n] = self.b[n] + math.random(-m, m) -- mutate bias
      end
    end
  end
  return layer
end
return Layer
