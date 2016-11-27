class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.inject(0) do |temp_hash, (val, idx)|
      (val.hash + idx.hash) ^ temp_hash
    end
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  def hash
    self.to_a.sort_by(&:hash).hash
  end
end
