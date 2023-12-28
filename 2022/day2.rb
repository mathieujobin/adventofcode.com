#!/usr/bin/env ruby

# rock paper scissors game

rock = %w[A X]
paper = %w[B Y]
scissors = %w[C Z]

def part1
  left_score = right_score = 0
  File.readlines('day2-input.txt').each do |line|
    case line.chomp
    when 'A X'
      left_score += 1 + 3
      right_score += 1 + 3
    when 'A Y'
      left_score += 1 + 0
      right_score += 2 + 6
    when 'A Z'
      left_score += 1 + 6
      right_score += 3 + 0
    when 'B X'
      left_score += 2 + 6
      right_score += 1 + 0
    when 'B Y'
      left_score += 2 + 3
      right_score += 2 + 3
    when 'B Z'
      left_score += 2
      right_score += 3 + 6
    when 'C X'
      left_score += 3
      right_score += 1 + 6
    when 'C Y'
      left_score += 3+6
      right_score += 2
    when 'C Z'
      left_score += 6 # 3 + 3
      right_score += 3 + 3
    else
      puts "error: invalid input (#{line.chomp})"
    end
  end

  puts right_score
end

def part2
  sequences = {
    'A' => {
      'X' => 3 + 0, # lose
      'Y' => 1 + 3, # draw
      'Z' => 2 + 6, # win
    },
    'B' => {
      'X' => 1+0, # lose
      'Y' => 2+3, # draw
      'Z' => 3+6, # win
    },
    'C' => {
      'X' => 2+0, # lose
      'Y' => 3+3, # draw
      'Z' => 1+6, # win
    }
  }
  score = 0
  File.readlines('day2-input.txt').each do |line|
    left, right = line.chomp.split(' ')
    score += sequences[left][right]
  end
  puts score
end

part2
