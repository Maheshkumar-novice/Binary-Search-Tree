#!/usr/bin/env ruby
# frozen_string_literal: true

# Tree Node
class Node
  include Comparable

  attr_accessor :left, :right, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def to_s
    @data.to_s
  end

  def <=>(other)
    other_value = other.instance_of?(Node) ? other.data : other

    @data <=> other_value
  end
end
