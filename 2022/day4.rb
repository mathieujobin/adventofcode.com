#!/usr/bin/env ruby

data = File.read('day4-input.txt').split("\n") # .map(&:to_i)

def part1(data)
  left_count, right_count, no_overlap = 0, 0, 0
  data.each do |line|
    ranges = line.split(',').map { |rg|
      left, right = rg.split('-').map(&:to_i)
      (left..right).to_a
    }
    if (ranges.first - ranges.last).empty?
      left_count += 1
      puts "2nd fully contains 1st: #{line}"
    elsif (ranges.last - ranges.first).empty?
      right_count += 1
      puts "1st fully contains 2nd: #{line}"
    else
      no_overlap += 1
      puts "No overlap: #{line}"
    end
  end
  puts "Left count: #{left_count}"
  puts "Right count: #{right_count}"
  puts "Sum: #{left_count + right_count}"
  puts "No overlap count: #{no_overlap}"
end

def part2(data)
  right_count, no_overlap = 0, 0
  data.each do |line|
    ranges = line.split(',').map { |rg|
      left, right = rg.split('-').map(&:to_i)
      (left..right).to_a
    }
    if (ranges.first - ranges.last) == ranges.first
      no_overlap += 1
      puts "No overlap: #{line}"
    else
      right_count += 1
      puts "some overlap: #{line}"
    end
  end
  puts "Overlap count: #{right_count}"
  puts "No overlap count: #{no_overlap}"
end

part2(data)