#!/usr/bin/env ruby

def split_equal_length(line)
  line.chars.each_slice(line.length / 2).map(&:to_a)
end

def present_in_both(left, right)
  left & right
end

def part1
  data = File.readlines('day3-input.txt').map(&:chomp)
  data.map do |line|
    left, right = split_equal_length(line)
    #puts (Array(left) && right).size
    puts present_in_both(left, right)
   end
end

part1