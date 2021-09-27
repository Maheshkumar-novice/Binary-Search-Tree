#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'tree-node'
require_relative 'colors/color'

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
    if @root.data == value && node == @root
      # binding.pry
      successor, parent_of_successor = find_succ(@root.right, @root.right)
      node.data = successor.data
      delete(successor.data, parent_of_successor)
      return
    end
    # binding.pry
    if value < node.data
      if node.left.data == value
        if node.left.right.nil? && node.left.left.nil?
          node.left = nil
        elsif node.left.right.nil? || node.left.left.nil?
          remove = [node.left.right, node.left.left].find { |x| !x.nil? }
          node.left.data = remove.data
          node.left.left = remove.left
          node.left.right = remove.right
        else
          successor, parent_of_successor = find_succ(node.left.right, node.left)
          node.left.data = successor.data
          delete(successor.data, parent_of_successor)
        end
      else
        delete(value, node.left)
      end
    elsif value >= node.data
      # binding.pry

      if node.right.data == value
        if node.right.right.nil? && node.right.left.nil?
          node.right = nil
        elsif node.right.right.nil? || node.right.left.nil?
          remove = [node.right.right, node.right.left].find { |x| !x.nil? }
          node.right.data = remove.data
          node.right.left = remove.left
          node.right.right = remove.right
        else
          # binding.pry
          successor, parent_of_successor = find_succ(node.right.right, node.right)
          node.right.data = successor.data
          delete(successor.data, parent_of_successor)
        end
      else
        delete(value, node.right)
      end
    end
  end

  def find_succ(node, parent)
    # binding.pry
    return [node, parent] if node.right.nil? && node.left.nil?
    return [node, parent] if node.left.nil?

    # return [node, parent] if node.right.nil?

    find_succ(node.left, node)
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    value > node.data ? find(value, node.right) : find(value, node.left)
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
