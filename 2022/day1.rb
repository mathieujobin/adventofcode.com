#!/usr/bin/env ruby

def open_input(file)
  File.readlines(file).map(&:chomp)
end

data = open_input('day1-input.txt')

elves = {}
elves_count = 0

data.each do |line|
	if line.empty?
		elves_count = elves_count + 1
	else
		elves[elves_count] ||= 0
		elves[elves_count] += line.to_i
	end
end

puts elves_count

def elf_with_largest_presents(elves)
	elves.max_by { |k, v| v }
end

puts elf_with_largest_presents(elves)