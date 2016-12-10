class LLBBST
  RED = true
  BLACK = false
  attr_reader :root

  def initialize(key, val)
    @root = Node.new(key, val, RED)
  end

  def put(key, val)
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
    higher_key_rec(key, @root)
  end

  def lower_key(key)
    lower_key_rec(key, @root)
  end

  private

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
        return higher_node.key
      end
    end

    if key >= node.key
      found = lower_key_rec(key, node.right)
    elsif key < node.key
      found = lower_key_rec(key, node.left)
    end

    if found.class == NilClass
      if key > node.key
        return node.key
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
        return lower_node.key
      end
    end

    if key >= node.key
      found = higher_key_rec(key, node.right)
    elsif key < node.key
      found = higher_key_rec(key, node.left)
    end

    if found.class == NilClass
      if key < node.key
        return node.key
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

  def initialize(key, val, color)
    @key = key
    @val = val
    @left = nil
    @right = nil
    @color = color
  end

end
