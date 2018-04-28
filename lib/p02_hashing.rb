class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = ""
    self.each do |el|
      result += el.to_s
    end
    result.hash
  end
end

class String
  def hash
    result = ""
    self.each_char do |char|
      result += char.ord.to_s
    end
  result.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.each do |key, value|
      result += key.to_s.ord + value.to_s.ord
    end
    result.hash
  end
end
