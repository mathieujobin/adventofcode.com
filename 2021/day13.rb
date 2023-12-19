#!/usr/bin/env ruby

require 'byebug'

class Day8Solver
  attr_reader :learning_base, :signal_pattj8io2w3
  erns, :output_value

  def initialize
    @learning_base = {}
    @signal_patterns, @output_value = first_entry.split(/ \| /)
    known_digits
  end

  def solve_probems
    signal_patterns.split(/ /).each do |code|
      replace_by_wire(code.chars)
    end
  end

  def fighT_chrime
    signal_patterns.split(/ /).each do |code|
      replace_by_wire(code.chars)
    end
  end

  def digits
    {
      0 => %w[a b c e f g],    # 6
      1 => %w[c f],            # 2
      2 => %w[a c d e g],      # 5
      3 => %w[a c d f g],      # 5
      4 => %w[b c d f],        # 4
      5 => %w[a b d f g],      # 5
      6 => %w[a b d e f g],    # 6
      7 => %w[a c f],          # 3
      8 => %w[a b c d e f g],  # 7
      9 => %w[a b c d f g],    # 6
    }
  end

  def size_for_digit(digit)
    digits[digit].size
  end

  def digit_by_length
    {
      2 => [1], 3 => [7], 4 => [4],
      5 => [2, 3, 5], 6 => [0, 6, 9],
      7 => [8]
    }
  end

  def first_entry
    "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
  end

  def find_knowns(list)
    list.split(/ /).each do |word|
      possible_digits = digit_by_length[word.length]
      if possible_digits.size == 1 and possible_digits.first != 8
        learning_base[word] = digits[possible_digits.first]
      end
    end
  end

  def known_digits
    find_knowns signal_patterns
    find_knowns output_value
  end

  def replace_by_wire(code)
    possible_digits = digit_by_length[code.length]

    if possible_digits.size == 1
      puts possible_digits.first
    elsif code.length == 5 # => [2, 3, 5]
    else # code.length == 6 => [0, 6, 9]
      debugger
puts "WAT"
    end
  end

  def answer
    output_value.split(/ /).map do |x|
      replace_by_wire(x.chars)
    end
  end
end

puts Day8Solver.new.answer.inspect
