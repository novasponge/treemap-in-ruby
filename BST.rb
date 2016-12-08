require 'byebug'

class BST

  attr_reader :root

  def initialize(key, val)
    @root = Node.new(key, val)
  end

  def put(key, val)
    put_rec(key, val, @root)
  end

  def get(key)
    find(key, @root).val
  end

  def del(key)
    del_rec(key, @root)
  end


  def put_rec(key, val, node)
    return Node.new(key, val) if node.nil?

    if key > node.key
      node.right = put_rec(key, val, node.right)
    elsif key < node.key
      node.left = put_rec(key, val, node.left)
    else
      node.val = val
    end

    return node
  end

  def find(key, node)
    return nil if node.nil?

    if key == node.key
      return node
    elsif key < node.key
      return find(key, node.left)
    else
      return find(key, node.right)
    end
  end

  def del_rec(key, node)
    return nil if node.nil?
    if key == node.key
      if node.right
        left_node = node.left
        node.key = node.right.key
        node.val = node.right.val
        node.left = node.right.left
        node.right = node.right.right
        float(node).left = left_node
        return node
      else
        return node = node.left
      end
    elsif key < node.key
      node.left = del_rec(key, node.left)
      return node
    else
      node.right = del_rec(key, node.right)
      return node
    end
  end

  def float(node)
    return node if node.left.nil?

    if node.left
      float(node.left)
    end
  end

end

class Node

  attr_accessor :val, :left, :right, :key

  def initialize(key, val)
    @key = key
    @val = val
    @left = nil
    @right = nil
  end

end
