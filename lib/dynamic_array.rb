require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop

    raise 'index out of bounds' if @length == 0

    val, @store[@length - 1] = @store[@length - 1], nil
    @length -= 1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0

    num = @store[0]
    1.upto(@length - 1) do |i|
      @store[i - 1] = @store[i]
    end

    @length -= 1
    num
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length > @capacity

    (@length - 1).downto(0) do |i|
      @store[i + 1] = @store[i]
    end

    @store[0] = val

    @length += 1
    nil
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if @length <= index
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    p 'resizing'
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    0.upto(@length - 1) do |i|
      new_store[i] = @store[i]
    end

    @store = new_store
  end
end
