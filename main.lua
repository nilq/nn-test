function love.load()
  -- make randomness
  math.randomseed(os.time())
  -- put sigmoid function to math
  math.sigmoid = function(z)
    return 1 / (1 + math.exp(-z))
  end
end

function love.update(dt)

end

function love.draw()

end
