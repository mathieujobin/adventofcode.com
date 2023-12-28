#!/usr/bin/env ruby

data = File.read('day5-input.txt').split("\n") # .map(&:to_i)

def read_crates(data)
  crates = []
  keys = []
  data.each do |line|
    if line.to_i == 1
      keys = line.split(' ').map(&:to_i)
      break
    end
    crates << line.chars
  end
  stakes = Hash.new { |h, k| h[k] = [] }
  positions = [1, 5, 9, 13, 17, 21, 25, 29, 33, 37]
  crates.reverse.map do |line|
    positions.each_with_index do |position, index|
      unless line[position] == " "
        stakes[keys[index]] << line[position]
      end
    end
  end
  stakes
end

puts read_crates(data)

def part1(data)
end