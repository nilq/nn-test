function love.load()
  -- make randomness
  math.randomseed(os.time())
  -- put sigmoid function to math
  math.sigmoid = function(z)
    return 1 / (1 + math.exp(-z))
  end
  -- add table copying by value
  table.copy_recursive = function(obj, seen)
    -- Handle non-tables and previously-seen tables.
    if type(obj) ~= "table" then
      return obj
    end
    if seen and seen[obj] then
      return seen[obj]
    end

    -- New table; mark it as seen an copy recursively.
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do
      res[table.copy_recursive(k, s)] = table.copy_recursive(v, s)
    end
    return res
  end
  debug()
end

function debug()
  local Network      = require "brain/network"
  local test_network = Network:make(3, 5, 2, 2)
  test_network:randomize()
  local other_net    = Network:copy(test_network)
end

function love.update(dt)

end

function love.draw()

end
