require 'byebug'
class MaxIntSet

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    !(num < 0 || num >= @store.length)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end

end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    #byebug
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end



  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end


  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count < @store.length
      unless include?(num)
        self[num] << num
        @count += 1
      end
    else
      resize!
      unless include?(num)
        self[num] << num
        @count += 1
      end
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    resized = Array.new(@store.length * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        resized[num % resized.length] << num
      end
    end
    @store = resized
  end
end
