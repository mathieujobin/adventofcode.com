require 'byebug'

Numbers = %w[one two three four five six seven eight nine]

def fix_data(data)
  data.gsub!(/oneight/, "oneeight")
  data.gsub!(/threeight/, "threeeight")
  data.gsub!(/fiveight/, "fiveeight")
  data.gsub!(/nineight/, "nineeight")
  data.gsub!(/twone/, "twoone")
  data.gsub!(/sevenine/, "sevennine")
  data.gsub!(/eightwo/, "eighttwo")
end

def word_to_digit(word)
  Numbers.index(word)+1
end

def replace_first_and_last(line)
  forward_match = line.match(%r[(#{Numbers.join('|')})])
  reverse_match = line.reverse.match(%r[(#{Numbers.map(&:reverse).join('|')})])
  if forward_match
      line.gsub!(forward_match[0], word_to_digit(forward_match[0]).to_s)
  end
  if reverse_match
      bingo = reverse_match[0].reverse
      puts bingo
      line.gsub!(bingo, word_to_digit(bingo).to_s)
  end
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

data = File.read("day1-seed1.txt")
fix_data(data)
contents = data.split("\n").compact

puts contents.sum { |line| calib_val(line) }
