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
  stakes.delete(nil)
  stakes
end

def display_crates(crates)
  puts crates.map { |key, value|
    ([key, ': '] + value).join
  }.join("\n")
end

puts `head -n 10 day5-input.txt`

def part1(data)
  crates = read_crates(data)
  display_crates(crates)

  data.each do |line|
    if match = line.match(/move (\d) from (\d) to (\d)/)
      puts "moving #{match[1]} from #{match[2]} to #{match[3]}"
      crates[match[3].to_i] += crates[match[2].to_i].pop(match[1].to_i).reverse
      display_crates(crates)
      # $stdin.gets
    end
  end
  crates
end

answer = part1(data).map { |key, value| value.last }.join
puts "Part 1: #{answer}, correct? #{answer == "TLNGFGMFN"}"