#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'tree-node'
require_relative 'colors/color'
require 'pry'

# Binary Search Tree
class Tree
  include Color

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = prepare_the_array(array)

    start_index = 0
    end_index = array.size - 1
    create_bst(start_index, end_index, array)
  end

  def insert(value, node = @root, node_to_insert = Node.new(value))
    return if value == node.data

    if value > node.data
      if node.right.nil?
        node.right = node_to_insert
      else
        insert(value, node.right, node_to_insert)
      end
    elsif value < node.data
      if node.left.nil?
        node.left = node_to_insert
      else
        insert(value, node.left, node_to_insert)
      end
    end
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    elsif node.left.nil? && node.right.nil?
      node = nil
    elsif node.left.nil?
      node = node.right
    elsif node.right.nil?
      node = node.left
    elsif node.left && node.right
      node.data = find_right_sub_tree_min_node(node.right).data
      node.right = delete(node.data, node.right)
    end
    node
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    value > node.data ? find(value, node.right) : find(value, node.left)
  end

  def level_order(queue = [@root], values = [])
    return nil if @root.nil?
    return values if queue.empty?

    node = queue.shift
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    values << node.data
    level_order(queue, values)
  end

  def inorder(node = @root, values = [])
    return values if node.nil?

    inorder(node.left, values)
    values << node.data
    inorder(node.right, values)
  end

  def preorder(node = @root, values = [])
    return values if node.nil?

    values << node.data
    preorder(node.left, values)
    preorder(node.right, values)
  end

  def postorder(node = @root, values = [])
    return values if node.nil?

    postorder(node.left, values)
    postorder(node.right, values)
    values << node.data
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node = @root, matcher = @root)
    return nil if node.nil?
    return 0 if node.data == matcher.data

    if node.data < matcher.data
      depth(node, matcher.left) + 1
    elsif node.data > matcher.data
      depth(node, matcher.right) + 1
    end
  end

  def balanced?(node = @root)
    return -1 if node.nil?

    diff(height(node.left), height(node.right)) <= 1
  end

  def rebalance
    @root = build_tree(level_order)
  end

  def to_s
    pretty_print
  end

  private

  def prepare_the_array(array)
    array = make_the_array_unique(array)
    sort_the_array(array)
  end

  def make_the_array_unique(array)
    array.uniq
  end

  def sort_the_array(array)
    array.sort
  end

  def create_bst(start_index, end_index, array)
    return nil if start_index > end_index

    middle_index = (start_index + end_index) / 2
    root = Node.new(array[middle_index])
    root.left = create_bst(start_index, middle_index - 1, array)
    root.right = create_bst(middle_index + 1, end_index, array)
    root
  end

  def find_right_sub_tree_min_node(node)
    return node if node.left.nil?

    find_right_sub_tree_min_node(node.left)
  end

  def diff(number1, number2)
    (number1 - number2).abs
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{color_text(prefix,
                       :green)}#{if is_left
                                   color_text('└── ',
                                              :green)
                                 else
                                   color_text('┌── ',
                                              :green)
                                 end}#{color_text(node.data, :red)}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
