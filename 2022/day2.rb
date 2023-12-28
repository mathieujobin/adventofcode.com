#!/usr/bin/env ruby

# rock paper scissors game

rock = %w[A X]
paper = %w[B Y]
scissors = %w[C Z]

score = 0
File.readlines('day2-input.txt').each do |line|
  case line.chomp
  when 'A X'
    score += 1 + 3
  when 'A Y'
    score += 1 + 0
  when 'A Z'
    score += 1 + 6
  when 'B X'
    score += 2 + 6
  when 'B Y'
    score += 2 + 3
  when 'B Z'
    score += 2
  when 'C X'
    score += 3
  when 'C Y'
    score += 3+6
  when 'C Z'
    score += 6 # 3 + 3
  else
    puts "error: invalid input (#{line.chomp})"
  end
end

puts score

