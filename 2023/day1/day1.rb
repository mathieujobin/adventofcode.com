require 'byebug'

contents = File.read("day1-seed1.txt").split("\n").compact

Numbers = %w[one two three four five six seven eight nine]

def word_to_digit(word)
  Numbers.index(word)+1
end

def replace_worded_numbers(line)
  while forward_match = line.match(%r[(#{Numbers.join('|')})])
    if forward_match
      line.gsub!(forward_match[0], word_to_digit(forward_match[0]).to_s)
    end
  end
end

def calib_val(line)
    puts "before> #{line}"
    replace_worded_numbers(line)
    puts "after>  #{line}"
    first_number = line.match(/\d+/)[0][0].to_i
    last_number = line.reverse.match(/\d+/)[0][0].to_i
    answer = (10*first_number) + last_number
    puts "answer> #{answer}"
    answer
end

puts contents.sum { |line| calib_val(line) }
