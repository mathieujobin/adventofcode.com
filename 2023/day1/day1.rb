require 'byebug'

contents = File.read("day1-seed1.txt").split("\n").compact

Numbers = %w[one two three four five six seven eight nine]

def calib_val(line)
    puts "before> #{line}"
    Numbers.each_with_index { |num,i| line.gsub!(num, (i+1).to_s) }
    puts "after>  #{line}"
    first_number = line.match(/\d+/)[0][0].to_i
    last_number = line.reverse.match(/\d+/)[0][0].to_i
    answer = (10*first_number) + last_number
    puts "answer> #{answer}"
    answer
end

puts contents.sum { |line| calib_val(line) }
