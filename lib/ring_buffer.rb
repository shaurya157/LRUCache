require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store, @capacity = StaticArray.new(8), 8
    @start_idx, @length = 0, 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    store[(start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if (length == 0)

    val, self[length - 1] = self[length - 1], nil
    @length -= 1

    val
  end

  # O(1) ammortized
  def push(val)
    resize! if (length == capacity)

    @length += 1
    self[length - 1] = val

    nil
  end

  # O(1)
  def shift
    raise "index out of bounds" if (length == 0)

    val, self[0] = self[0], nil
    @start_idx = (start_idx + 1) % capacity
    @length -= 1

    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if (length == capacity)

    @start_idx = (start_idx - 1) % capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    end
  end

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    @capacity = new_capacity
    @store = new_store
    @start_idx = 0
  end
end
