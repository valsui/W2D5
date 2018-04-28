require 'byebug'
class Node
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

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail
  def initialize
    @head = Node.new(nil,nil)
    @tail = Node.new(nil,nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return find_node(key).val
  end

  def include?(key)
    return true if get(key)
    false
  end

  def append(key, val)
    node = Node.new(key,val)

    node.prev = last
    @tail.prev.next = node

    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    target_node = find_node(key)
    target_node ? target_node.val = val : nil
  end

  def remove(key)
    node = find_node(key)
    if node == @tail
      return nil
    else
      node.remove
    end
  end

  def find_node(key)
    node = @head.next
    until node == @tail
      return node if node.key == key
      node = node.next
    end
    node
  end


  def each(&prc)
    node = first
    until node == @tail
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
