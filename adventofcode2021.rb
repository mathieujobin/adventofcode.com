require 'byebug'

def day1
  calculation = File.read('input-day1.txt').split("\n").map(&:to_i).reduce(increase: 0, decrease: 0, last: nil) {
    |acc, i|

    unless acc[:last].nil?
      if i > acc[:last]
        acc[:increase] += 1
      elsif i < acc[:last]
        acc[:decrease] += 1
      end
    end
    acc[:last] = i
    acc
  }
  puts calculation.inspect
rescue => e
  debugger
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
    raise "invalid" if @last_three.length < 3
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
  calculation = File.read('input-day1.txt').split("\n").map(&:to_i).reduce(increase: 0, decrease: 0, last_three: LastThree.new) {
    |acc, i|

    acc[:last_three].compute(acc, i)

    acc
  }
  puts calculation.inspect
rescue => e
  debugger
end

class Day2CommandParser
end

def day2
  calculation = File.read('input-day2.txt').split("\n").map(&:to_i).reduce(forward: 0, depth: 0, parser: Day2CommandParser.new) {
    |acc, i|

    acc[:last_three].compute(acc, i)

    acc
  }
  puts calculation.inspect
rescue => e
  debugger
end

day2

