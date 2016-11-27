class Link
  attr_accessor :key, :val, :next, :prev


  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    selected_node = nil
    self.each do |node|
      if node.key == key
        selected_node = node
        break
      end
    end

    selected_node ? selected_node.val : nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key
        return true
      end
    end

    false
  end

  def insert(key, val)
    link = Link.new(key, val)
    @tail.prev.next, link.prev = link, @tail.prev
    link.next, @tail.prev = @tail, link
  end

  def remove(key)
    selected_node = nil
    self.each do |node|
      if node.key == key
        selected_node = node
        break
      end
    end

    if selected_node
      selected_node.prev.next = selected_node.next
      selected_node.next.prev = selected_node.prev
    end
  end

  def each
    node = @head.next
    until node == @tail
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
