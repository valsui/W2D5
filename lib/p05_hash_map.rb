require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      if @count < num_buckets
        bucket(key).append(key, val)
        @count += 1
      else
        resize!
        bucket(key).append(key, val)
        @count += 1
      end
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if bucket(key).include?(key)
      removed_node = bucket(key).remove(key)
      @count -= 1 if removed_node
    end
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@store.length * 2) {LinkedList.new}
    @count = 0
    old_store.each do |list|
      list.each do |node|
        # bucket_key = node.key.hash % resized.length
        # resized[bucket_key].append(node.key, node.val)
        set(node.key,node.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
