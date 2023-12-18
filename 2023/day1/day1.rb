require 'byebug'

contents = File.read("day1-seed1.txt").split("\n").compact

def calib_val(line)
    puts line
    #debugger if line == "eightfour538"
    first_number = line.match(/\d+/)[0][0].to_i
    last_number = line.reverse.match(/\d+/)[0][0].to_i
    answer = (10*first_number) + last_number
    puts answer
    answer
end

puts contents.sum { |line| calib_val(line) }
