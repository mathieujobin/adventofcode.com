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

def day3(part)
  bits_collector = File.read('input-day3.txt').split("\n").each_with_object({}) do |line, acc|
    line.chars.each_with_index do |c, i|
      acc[i] ||= []
      acc[i] << c
    end
  end

  result = bits_collector.each_with_object(gamma: "", epsylon: "") do |(pos, values), acc|
    # puts pos.inspect
    counts = values.group_by(&:itself).map { |k, v| [k, v.length] }.to_h
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

day3 :part1
