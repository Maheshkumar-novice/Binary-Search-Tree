#!/usr/bin/env ruby
# frozen_string_literal: true

# Tree Node
class Node
  attr_accessor :left, :right, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end
