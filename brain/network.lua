local Network = {}
-- handling layers
function Network:make(x, h, o, depth) -- input size, hidden size, output size
  local network = {
    input   = {},
    hiddens = {}, -- [x]
    output  = {},
  }
  -- randomize network
  function network:randomize()
    local Layer = require "brain/layer"
    self.input = Layer:randomize(x)
    for i = 1, depth do -- thus indexing from 1
      self.hiddens[#self.hiddens] = Layer:randomize(h)
    end
    self.output = Layer:randomize(o)
  end
  function network:mutate(p, m) -- percentage
    self.input:mutate(p, m)
    for n = 1, #self.hiddens do
      self.hiddens[n]:mutate()
    end
    -- outputs shouldn't be mutated
  end
  return network
end

function Network:copy(n) -- network to copy
  return table.copy_recursive(n)
end

return Network