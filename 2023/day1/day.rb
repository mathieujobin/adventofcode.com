#require 'debugger'

contents = File.read("seed1.txt").split("\n").compact

def calib_val(line)
    puts line
    first_number = line.match(/\d+/)[0].to_i
    last_number = line.reverse.match(/\d+/)[0].to_i
    answer = (10*first_number) + last_number
    puts answer
    answer
end

puts contents.sum { |line| calib_val(line) }
