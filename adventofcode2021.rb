require 'byebug'

def day1
  calculation = File.read('input-day1.txt').split("\n").map(&:to_i).each_with_object(
    increase: 0, decrease: 0,
    last: nil
  ) do |i, acc|
    unless acc[:last].nil?
      if i > acc[:last]
        acc[:increase] += 1
      elsif i < acc[:last]
        acc[:decrease] += 1
      end
    end
    acc[:last] = i
  end
  puts calculation.inspect
end

class LastThree
  def initialize
    @last_three = []
  end

  def add(i)
    @last_three << i
    @last_three.shift if @last_three.length > 3
  end

  def sum
    raise 'invalid' if @last_three.length < 3

    @last_three.reduce(:+)
  end

  def size
    @last_three.length
  end

  def last_two_plus(i)
    @last_three[1] + @last_three[2] + i
  end

  def compute(acc, i)
    if size == 3
      if last_two_plus(i) > sum
        acc[:increase] += 1
      elsif last_two_plus(i) < sum
        acc[:decrease] += 1
      end
    end
    add i
    acc
  end
end

def day1_part2
  calculation = File.read('input-day1.txt').split("\n").map(&:to_i).each_with_object(
    increase: 0, decrease: 0,
    last_three: LastThree.new
  ) do |i, acc|
    acc[:last_three].compute(acc, i)
  end
  puts calculation.inspect
end

def day2(part)
  calculation = File.read('input-day2.txt').split("\n").map(&:split).each_with_object(
    aim: 0,
    forward: 0,
    depth: 0
  ) do |(cmd, value), acc|
    if part == :part1
      case cmd
      when 'up'
        acc[:depth] -= value.to_i
      when 'down'
        acc[:depth] += value.to_i
      when 'forward'
        acc[:forward] += value.to_i
      else
        raise "invalid input #{[cmd, value].inspect}"
      end
    else
      case cmd
      when 'up'
        acc[:aim] -= value.to_i
      when 'down'
        acc[:aim] += value.to_i
      when 'forward'
        acc[:depth] += value.to_i * acc[:aim]
        acc[:forward] += value.to_i
      else
        raise "invalid input #{[cmd, value].inspect}"
      end
    end
  end
  puts calculation.inspect
  puts "Answer: #{calculation[:forward] * calculation[:depth]}"
end

class Day3Solver
  def data
    @data ||= File.read('input-day3.txt').split("\n")
  end

  def bits_collector(data)
    data.each_with_object({}) do |line, acc|
      line.chars.each_with_index do |c, i|
        acc[i] ||= []
        acc[i] << c
      end
    end
  end

  def count_unique_values(values)
    values.group_by(&:itself).map { |k, v| [k, v.length] }.to_h
  end

  def solve_part1
    result = bits_collector(data).each_with_object(gamma: "", epsylon: "") do |(pos, values), acc|
      # puts pos.inspect
      counts = count_unique_values(values)
      if counts["0"] > counts["1"]
        acc[:gamma] << "0"
        acc[:epsylon] << "1"
      else
        acc[:gamma] << "1"
        acc[:epsylon] << "0"
      end
      acc
    end
    puts result.inspect
    puts "Answer: #{result[:gamma].to_i(2) * result[:epsylon].to_i(2)}"
  end

  def indexes_with_value(collection, value)
    collection.each_with_index.select { |v, i| v == value }.map(&:last)
  end

  def found_value?(indexes)
    indexes.is_a?(Array) && indexes.length == 1
  end

  def values_at(values, indexes)
    # maybe use values_at instead of [] if its a problem
    if indexes.is_a?(Array)
      values.values_at *indexes
    elsif indexes.is_a?(Range)
      values[indexes]
    else
      raise "error"
    end
  end

  def locate_indexes(current_values, acc, rating, condition)
    # current_values = values_at(values, acc[rating])
    counts = count_unique_values(current_values)
    # Eventually, one side disappears, for the next condition not to fails. I ||= 0 here
    counts["0"] ||= 0
    counts["1"] ||= 0
    acc[rating] = \
      if condition.call(counts["0"], counts["1"])
        indexes_with_value(current_values, "0")
      else
        indexes_with_value(current_values, "1")
      end
  end

  def solve_one_rating(current_data, pos, acc, rating, condition)
    current_values = bits_collector(current_data)[pos]
    puts acc[rating].inspect
    locate_indexes(current_values, acc, rating, condition)
    current_data = values_at(current_data, acc[rating])
    puts [pos, current_data.size, rating].inspect
    if found_value? acc[rating]
      # debugger
      current_data.first.to_i(2)
      # current_data[acc[rating].last].to_i(2)
    else
      solve_one_rating(current_data, pos+1, acc, rating, condition)
    end
  end

  def display_answer(result)
    puts result.inspect
    final = 1
    [:oxygen, :co2].each do |rating|
      answer = result[rating]
      final *= answer
      puts "Answer #{rating}: #{answer}"
    end
    puts "Day3 Part2 Answer: #{final}"
  end

  def solve_part2

    indexes_hash = {oxygen: (0..-1), co2: (0..-1)}
    result = {oxygen: 0, co2: 0}
    result[:oxygen] = solve_one_rating(data.dup, 0, indexes_hash, :oxygen, ->(a,b) { a > b })
    result[:co2] = solve_one_rating(data.dup, 0, indexes_hash, :co2, ->(a,b) { a < b })


    # I am going to keep the index of numbers that are good, because at this point, I have arrays sorted by position.
    #result = .each_with_object() do |(pos, values), acc|

    display_answer result
  end
end

Day3Solver.new.solve_part2
