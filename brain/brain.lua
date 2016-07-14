local Brain = {}
-- handle neural network
function Brain:make()
  local Network = require "brain/network"
  local brain = {
    network = {} -- two layers deep
  }
  -- temporary input, output
  function brain:randomize()
    self.network = Network:make(3, 6, 3, 2)
    self.network:randomize()
  end
  function brain:copy(n)
    self.network = Network:copy(n)
  end
  function brain:mutate(p, m)
    self.network:mutate(p, m)
  end
  -- passes vector containing outputs
  function brain:get_output()
    return self.network:get_output()
  end
  return brain
end

return Brain
