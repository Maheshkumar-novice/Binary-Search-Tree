#!/usr/bin/env ruby
# frozen_string_literal: true

# Binary Search Tree
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = prepare_the_array(array)
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
end
