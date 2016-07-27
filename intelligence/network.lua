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
    self.input:randomize()
    for n = 1, 3 do
      self.hiddens[#self.hiddens + 1] = Layer:make(15)
      self.hiddens[n]:randomize()
    end
    self.output = Layer:make(out)
    self.output:randomize()
  end
  function network:pass(inputs)
    self.input:set(inputs)
    for n = 1, #self.hiddens do
      if n == 1 then
        self.hiddens[n]:calculate(self.input)
      else
        self.hiddens[n]:calculate(self.hiddens[n - 1])
      end
    end
    self.output:calculate(self.hiddens[#self.hiddens])
    return self.output
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