class Vector
  def initialize(value)
    @store = value
  end

  def [](pos)
    @store[pos]
  end

  def +(other_value)
    other_value = Vector.new(other_value.to_a) if other_value.respond_to?(:to_a)

    [@store[0] + other_value[0], @store[1] + other_value[1]]
  end
end
