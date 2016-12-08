require 'byebug'

class BST

  attr_reader :root

  def initialize(key, val)
    @root = Node.new(key, val, 'black')
  end

  def put(key, val)
    @root = put_rec(key, val, @root)
    @root.color = 'black'
  end

  def get(key)
    find(key, @root).val
  end

  def del(key)
    del_rec(key, @root)
  end


  def put_rec(key, val, node)
    return Node.new(key, val, 'red') if node.nil?

    if key > node.key
      node.right = put_rec(key, val, node.right)
    elsif key < node.key
      node.left = put_rec(key, val, node.left)
    else
      node.val = val
    end

    node = rotate_left(node) if is_red(node.right) && is_red(node.left) == false
    node = rotate_right(node) if is_red(node.left) && is_red(node.left.left)
    flip_color(node) if is_red(node.left) && is_red(node.right)
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

  def is_red(node)
    return false if node.nil?
    return node.color == 'red'
  end

  def rotate_left(node)
    next_node = node.right
    node.right = next_node.left
    next_node.left = node
    next_node.color = node.color
    node.color = 'red'
    return next_node
  end

  def rotate_right(node)
    next_node = node.left
    node.left = next_node.right
    next_node.right = node
    next_node.color = node.color
    node.color = 'red'
    return next_node
  end

  def flip_color(node)
    node.color = 'red'
    node.left.color = 'black'
    node.right.color = 'black'
  end
end

class Node

  attr_accessor :val, :left, :right, :key, :color

  def initialize(key, val, color)
    @key = key
    @val = val
    @left = nil
    @right = nil
    @color = color
  end

end
