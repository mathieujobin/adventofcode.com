require 'byebug'
require 'looksee'

BOARD_SIZE = 5

class BingoBoard
  def initialize(numbers)
    @board_id = self.class.next_board_id
    @numbers = numbers.map{|row| row.split(' ').map(&:to_i)}
    @states = {}
    @marked_moves = []
  end

  def self.next_board_id
    @board_count ||= 0
    @board_count += 1
  end

  def declare_victory!
    puts "I won #{to_s} with #{score} points"
    puts to_s
    exit 0
  end

  def score
    (@numbers.flatten - @marked_moves).sum * @marked_moves.last
  end

  def play(move)
    if pos = number_includes(move)
      mark_state(move, pos)
      display_marking_move(move, pos)
      if bingo?
        declare_victory!
      end
    end
  end

  def number_includes(move)
    @numbers.each_with_index do |row, row_index|
      row.each_with_index do |value, col_index|
        if value == move
          return [row_index, col_index]
        end
      end
    end
    false
  end

  def mark_state(move, pos)
    @states[pos[0]] ||= []
    @states[pos[0]][pos[1]] = true
    @marked_moves << move
  end

  def display_marking_move(move, pos)
    puts %Q{
      Marking Move #{move} at #{pos.join(',')} on board (#{@board_id})
    }
  end

  def bingo?
    debugger if $debug == true
    BOARD_SIZE.times do |row_id|
      if @states[row_id] == [true]*BOARD_SIZE
        return true
      end
    end
    BOARD_SIZE.times do |col_id|
      if @states.map { |row| row[col_id] }.flatten == [true]*BOARD_SIZE
        return true
      end
    end
    false
  end

  def to_s
    %Q[Board (#{@board_id})

    #{@numbers.map { |n| n.to_s.rjust(2) }.join(' ')}
    #{@states.inspect}
    ]
    #States: #{@states.map { |row| row.map { |state| state ? 'X' : ' ' }.join(' ') }.join("\n")}
    #]
  end
end

class Day4Solver
  attr_reader :boards

  def initialize
    read_boards
  end

  def play
    moves.each do |move|
      puts "Move: #{move}"
      boards.each do |board|
        board.play(move)
      end
    end
  end

  def moves
    @moves = data.first.split(',').map(&:to_i)
  end

  private

  def board_size_with_white_line
    @board_size_with_white_line ||= BOARD_SIZE + 1
  end

  def number_of_boards
    @number_of_boards ||= (data.size - 1) / board_size_with_white_line
  end

  def read_boards
    @boards = []
    number_of_boards.times { |i|
      first_line = 2+(i*board_size_with_white_line)
      last_line = 2+(i*board_size_with_white_line)+(BOARD_SIZE-1)
      # puts "<<<"
      @boards << BingoBoard.new(data[first_line..last_line]) # .join("\n")
      # puts ">>>"
    }
  end

  def data
    @data ||= File.read('input-day4.txt').split("\n")
  end
end

Day4Solver.new.play
