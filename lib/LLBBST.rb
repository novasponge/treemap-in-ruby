require 'set'

class LLBBST
  RED = true
  BLACK = false
  attr_reader :root, :size

  def initialize(key = nil, val = nil)
    @root = Node.new(key, val, RED)
    @size = 0
  end

  def ceiling_entry(key)
    node = find(key, @root)
    if node.nil?
      node = higher_key_rec(key, @root)
      if node.nil?
        return nil
      else
        return {node.key => node.val}
      end
    else
      return {node.key => node.val}
    end
  end

  def ceiling_key(key)
    hash = ceiling_entry(key)
    if hash.nil?
      return nil
    else
      return hash.keys.first
    end
  end

  def floor_entry(key)
    node = find(key, @root)
    if node.nil?
      node = lower_key_rec(key, @root)
      if node.nil?
        return nil
      else
        return {node.key => node.val}
      end
    else
      return {node.key => node.val}
    end
  end

  def entry_set()
    set = Set.new
    iterator(set, @root)
    return set
  end

  def floor_key(key)
    hash = floor_entry(key)
    if hash.nil?
      return nil
    else
      return hash.keys.first
    end
  end

  def put(key, val)
    if @root.key.nil?
      @root.key = key
      @root.val = val
      return @root
    end
    @root = put_rec(key, val, @root)
    @root.color = BLACK
  end

  def get_key(key)
    node = find(key, @root)
    if node
      node.key
    else
      nil
    end
  end

  def get_val(key)
    node = find(key, @root)
    if node
      node.val
    else
      nil
    end
  end

  def del(key)
    if !is_red(@root.left) && !is_red(@root.right)
      @root.color = RED
    end

    @root = del_rec(key, @root)

    unless @root.nil?
      @root.color = BLACK
    end
  end

  def del_max()
    if !is_red(@root.left) && !is_red(@root.right)
      @root.color = RED
    end

    @root = del_max_rec(@root)

    unless @root.nil?
      @root.color = BLACK
    end
  end

  def del_min()
    if !is_red(@root.left) && !is_red(@root.right)
      @root.color = RED
    end

    @root = del_min_rec(@root)

    unless @root.nil?
      @root.color = BLACK
    end
  end

  def min()
    min_rec(@root)
  end

  def max()
    max_rec(@root)
  end

  def higher_key(key)
    node = higher_key_rec(key, @root)
    if node.nil?
      return nil
    else
      return node.key
    end
  end

  def lower_key(key)
    node = lower_key_rec(key, @root)
    if node.nil?
      return nil
    else
      return node.key
    end
  end

  private

  def del_max_rec(node)
    if is_red(node.left)
      node = rotate_right(node)
    end

    return nil if node.right.nil?

    if !is_red(node.right) && !is_red(node.right.left)
      node = move_red_right(node)
    end

    node.right = del_max_rec(node.right)
    return fix_up(node)
  end

  def del_min_rec(node)
    return nil if node.left.nil?

    if !is_red(node.left) && !is_red(node.left.left)
      node = move_red_left(node)
    end

    node.left = del_min_rec(node.left)
    return fix_up(node)
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

  def iterator(set, node)
    if node.left.nil? && node.right.nil?
      set << node
      return
    end

    if node.left
      iterator(set, node.left)
    end

    set << node

    if node.right
      iterator(set, node.right)
    end

  end

  def min_rec(node)
    return nil if node.nil?
    if node.left
      min_rec(node.left)
    else
      return node
    end
  end

  def max_rec(node)
    return nil if node.nil?
    if node.right
      max_rec(node.right)
    else
      return node
    end
  end

  def del_rec(key, node)
    if key < node.key
      if !is_red(node.left) && !is_red(node.left.left)
        node = move_red_left(node)
      end
      node.left = del_rec(key, node.left)
    else
      if is_red(node.left)
        rotate_right(node)
      end

      return nil if key == node.key && node.right.nil?

      if !is_red(node.right) && !is_red(node.right.left)
        node = move_red_right(node)
      end

      if key == node.key
        temp = min_rec(node.right)
        node.key = temp.key
        node.val = temp.val
        node.right = del_min_rec(node.right)
      else
        node.right = del_rec(key, node.right)
      end
    end
    return fix_up(node)
  end

  def fix_up(node)
    node = rotate_left(node) if is_red(node.right)
    node = rotate_right(node) if is_red(node.left) && is_red(node.left.left)
    flip_color(node) if is_red(node.left) && is_red(node.right)
    return node
  end

  def move_red_left(node)
    flip_color(node)
    if is_red(node.right.left)
      node.right = rotate_right(node.right)
      node = rotate_left(node)
      flip_color(node)
    end
    return node
  end

  def move_red_right(node)
    flip_color(node)
    if is_red(node.left.left)
      node = rotate_right(node)
      flip_color(node)
    end
    return node
  end

  def put_rec(key, val, node)
    return Node.new(key, val, RED) if node.nil?

    if key > node.key
      node.right = put_rec(key, val, node.right)
    elsif key < node.key
      node.left = put_rec(key, val, node.left)
    else
      node.val = val
    end

    node = rotate_left(node) if is_red(node.right) && is_red(node.left) == BLACK
    node = rotate_right(node) if is_red(node.left) && is_red(node.left.left)
    flip_color(node) if is_red(node.left) && is_red(node.right)
    return node
  end

  def rotate_left(node)
    next_node = node.right
    node.right = next_node.left
    next_node.left = node
    next_node.color = node.color
    node.color = RED
    return next_node
  end

  def rotate_right(node)
    next_node = node.left
    node.left = next_node.right
    next_node.right = node
    next_node.color = node.color
    node.color = RED
    return next_node
  end

  def flip_color(node)
    node.color = !node.color
    node.left.color = !node.left.color
    node.right.color = !node.right.color
  end

  def is_red(node)
    return false if node.nil?
    return node.color == RED
  end

  def lower_key_rec(key, node)
    return nil if node.nil?

    if key == node.key
      higher_node = max_rec(node.left)
      if higher_node.nil?
        return nil
      else
        return higher_node
      end
    end

    if key >= node.key
      found = lower_key_rec(key, node.right)
    elsif key < node.key
      found = lower_key_rec(key, node.left)
    end

    if found.class == NilClass
      if key > node.key
        return node
      else
        return found
      end
    else
      return found
    end
  end

  def higher_key_rec(key, node)
    return nil if node.nil?

    if key == node.key
      lower_node = min_rec(node.right)
      if lower_node.nil?
        return nil
      else
        return lower_node
      end
    end

    if key >= node.key
      found = higher_key_rec(key, node.right)
    elsif key < node.key
      found = higher_key_rec(key, node.left)
    end

    if found.class == NilClass
      if key < node.key
        return node
      else
        return found
      end
    else
      return found
    end
  end
end

class Node

  attr_accessor :val, :left, :right, :key, :color

  def initialize(key = nil, val = nil, color = nil)
    @key = key
    @val = val
    @left = nil
    @right = nil
    @color = color
  end

end
