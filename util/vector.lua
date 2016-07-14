local Vector = {}
-- vals procedure vals[#vals + 1] = x
function Vector:make()
  local vector = {}
  -- indexing thus from 1
  function vector:put(n)
    self[#self + 1] = n
  end
  return vector
end

function Vector:dot(a, b)
  assert(#a == #b, "invalid dimensions")
  local dot = 0
  for n = 1, #a do
    total = total + a[n] * b[n]
  end
  return total
end

return Vector
