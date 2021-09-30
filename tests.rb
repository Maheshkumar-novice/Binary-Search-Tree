#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'binary-search-tree'

binary_search_tree = Tree.new(Array.new(15) { rand(1..100) })
puts binary_search_tree

puts "Is Balanced? #{binary_search_tree.balanced?}"

puts "Level-Order: #{binary_search_tree.level_order}"
puts "Pre-Order: #{binary_search_tree.preorder}"
puts "In-Order: #{binary_search_tree.inorder}"
puts "Post-Order: #{binary_search_tree.postorder}"

puts
puts 'Adding Random Numbers(5-10) between 101..200'
Array.new(rand(5..10)) { rand(101..2000) }.each { |value| binary_search_tree.insert(value) }
puts 'Adding Random Numbers(5-10) between -101..0'
Array.new(rand(5..10)) { rand(-101..0) }.each { |value| binary_search_tree.insert(value) }
puts binary_search_tree

puts "Is Balanced? #{binary_search_tree.balanced?}"

puts "Level-Order: #{binary_search_tree.level_order}"
puts "Pre-Order: #{binary_search_tree.preorder}"
puts "In-Order: #{binary_search_tree.inorder}"
puts "Post-Order: #{binary_search_tree.postorder}"

puts
puts "Rebalancing... #{binary_search_tree.rebalance}"
puts binary_search_tree

puts "Is Balanced? #{binary_search_tree.balanced?}"

puts "Level-Order: #{binary_search_tree.level_order}"
puts "Pre-Order: #{binary_search_tree.preorder}"
puts "In-Order: #{binary_search_tree.inorder}"
puts "Post-Order: #{binary_search_tree.postorder}"

