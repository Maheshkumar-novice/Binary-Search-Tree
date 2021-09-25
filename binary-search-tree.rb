#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'tree-node'

# Binary Search Tree
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = prepare_the_array(array)

    start_index = 0
    end_index = array.size - 1
    create_bst(start_index, end_index, array)
  end

  private

  def prepare_the_array(array)
    make_the_array_unique(array)
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
end
