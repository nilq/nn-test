local Network = {}

function Network:make(inp, out)
  local network = {
    input   = {},
    hiddens = {},
    output  = {},
  }
  function network:randomize()
    local Layer = require "intelligence/layer"
    self.input = Layer:make(inp)
    for n = 1, 3 do
      self.hiddens[#self.hiddens + 1] = Layer:make(2)
      if n == 1 then
        self.hiddens[n]:randomize(self.input)
      else
        self.hiddens[n]:randomize(self.hiddens[n - 1])
      end
    end
    self.output = Layer:make(out)
    self.output:randomize(self.hiddens[#self.hiddens])
  end
  function network:pass(inputs)
    if #inputs~=inp then
      error("nil inputs or incorect amount stated.")
    end
    self.input:set(inputs)
    for n = 1, #self.hiddens do
      if n == 1 then
        self.hiddens[n]:calculate(self.input)
      else
        self.hiddens[n]:calculate(self.hiddens[n - 1])
      end
    end
    self.output:calculate(self.hiddens[#self.hiddens])
    return self.output.x
  end
  function network:copy(other)
    self = table.copy_recursive(other)
  end
  function network:mutate(min, max)
    self.input:mutate(min, max)
    for n = 1, #self.hiddens do
      self.hiddens[n]:mutate(min, max)
    end
  end
  return network
end
return Network
