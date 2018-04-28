require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count < num_buckets
      unless include?(key)
        self[key] << key
        @count += 1
      end
    else
      resize!
      unless include?(key)
        self[key] << key
        @count += 1
      end
    end
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end
  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    resized = Array.new(@store.length * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        resized[el.hash % resized.length] << el
      end
    end
    @store = resized
  end
end
