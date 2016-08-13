# Holds a global random number generator.

module GlobalRandom
  RANDOM = Random.new

  def GlobalRandom.rand(num)
    RANDOM.rand num
  end

  def GlobalRandom.between(min, max)
    RANDOM.rand(max - min) + min
  end
end
