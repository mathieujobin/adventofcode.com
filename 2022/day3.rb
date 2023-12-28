#!/usr/bin/env ruby

require 'debug'
require 'colorize'

def split_equal_length(line)
  line.chars.each_slice(line.length / 2).map(&:to_a)
end

def present_in_both(left, right)
  left & right
end

Score = {
  'a' => 1,
  'b' => 2,
  'c' => 3,
  'd' => 4,
  'e' => 5,
  'f' => 6,
  'g' => 7,
  'h' => 8,
  'i' => 9,
  'j' => 10,
  'k' => 11,
  'l' => 12,
  'm' => 13,
  'n' => 14,
  'o' => 15,
  'p' => 16,
  'q' => 17,
  'r' => 18,
  's' => 19,
  't' => 20,
  'u' => 21,
  'v' => 22,
  'w' => 23,
  'x' => 24,
  'y' => 25,
  'z' => 26,
  'A' => 27,
  'B' => 28,
  'C' => 29,
  'D' => 30,
  'E' => 31,
  'F' => 32,
  'G' => 33,
  'H' => 34,
  'I' => 35,
  'J' => 36,
  'K' => 37,
  'L' => 38,
  'M' => 39,
  'N' => 40,
  'O' => 41,
  'P' => 42,
  'Q' => 43,
  'R' => 44,
  'S' => 45,
  'T' => 46,
  'U' => 47,
  'V' => 48,
  'W' => 49,
  'X' => 50,
  'Y' => 51,
  'Z' => 52,

}
def part1
  data = File.readlines('day3-input.txt').map(&:chomp)
  data.map do |line|
    left, right = split_equal_length(line)
    value = present_in_both(left, right).first
    x = Score[value] || 0
    # puts x
    x
  end.sum
end

def part2
  data = File.readlines('day3-input.txt').map(&:chomp)
  data.each_slice(3).map do |slice|
    common = slice.first.chars & slice.last.chars & slice[1].chars
    badge = common.first

    debugger if common.length != 1
    a = slice.join.gsub(/[^#{badge}]/, '').length
    b = slice.join.count(badge)
    debugger if a != b
    colored = slice.join.gsub(/#{badge}/, badge.red)
    puts "There is #{a} #{badge} in #{colored}"
    a
  end.sum
end

puts part2
