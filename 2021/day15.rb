#!/usr/bin/env ruby

require 'byebug'
require 'active_support/all'

class Day15Solver

  def initialize(filename)
    @filename = filename
    @lowest_path_score = Float::INFINITY
    @skip_counter = 0
    @completed_path_counter = 0
    @start_time = 0
  end

  def data
    @data ||= File.read(@filename).split("\n").map(&:chars)
  end

  def start_pos
    [0, 0]
  end

  def destination
    @destination ||= [data.length - 1, data[0].length - 1]
  end

  def path_max_length
    @path_max_length ||= data.length + data[0].length - 2
  end

  def path_is_complete?(path)
    (path.size == path_max_length).tap do |complete|

      if complete
        @completed_path_counter += 1
        # only display score when we reach new lowest score
        score = path_score(path)
        if score < @lowest_path_score
          @lowest_path_score = score
          puts "New lowest score: #{@lowest_path_score}, completed path: #{@completed_path_counter} @#{elapsed}"
        end
      end
    end
  end

  def path_score(path)
    path.map(&:to_i).reduce(:+)
  end

  def __next_step(pos, path)
    next_pos = [pos[0] + 1, pos[1]]
    next_pos if path_is_complete?(path + [next_pos])
  end

  def display_skip_counter?
    if @skip_counter > 1_000_000
      @skip_counter % 1_000_000 == 0
    elsif @skip_counter > 1_000_000
      @skip_counter % 1_000_000 == 0
    elsif @skip_counter > 100_000
      @skip_counter % 100_000 == 0
    elsif @skip_counter > 10_000
      @skip_counter % 10_000 == 0
    elsif @skip_counter > 1000
      @skip_counter % 1000 == 0
    elsif @skip_counter > 100
      @skip_counter % 100 == 0
    else
      false
    end
  end

  def exec_direction_in_subprocess(direction, pos_x, pos_y, path)
    exec_direction(direction, pos_x, pos_y, path)
  end

  def smaller_next_move(pos_x, pos_y)
    next_right = data[pos_x+1][pos_y].to_i rescue Float::INFINITY
    next_down  = data[pos_x][pos_y+1].to_i rescue Float::INFINITY
    next_right < next_down ? :right : :down
  end

  def exec_direction(direction, pos_x, pos_y, path)
    next_value = data[pos_x][pos_y] rescue nil
    if next_value.nil?
      puts "reached far #{direction} #{path.length}" if ENV['DEBUG_DAY15']
      path_is_complete?(path)
    else
      child_path = path.dup + [next_value]
      puts "Traversing #{direction} from #{pos}(#{current_value}) - #{child_path}" if ENV['DEBUG_DAY15'] || path.size > path_max_length
      if smaller_next_move(pos_x, pos_y) == :right
        traverse_sub_trail(:right, [pos_x, pos_y], child_path)
        traverse_sub_trail(:down, [pos_x, pos_y], child_path)
      else
        traverse_sub_trail(:down, [pos_x, pos_y], child_path)
        traverse_sub_trail(:right, [pos_x, pos_y], child_path)
      end
    end
  end

  def elapsed
    ActiveSupport::Duration.build(Time.now - @start_time).parts
  end

  def traverse_sub_trail(direction, pos, path)
    # Skip calculation when score is already higher than lowest score
    if path.size > data.size && path_score(path) > @lowest_path_score
      @skip_counter+=1
      puts "Skipped #{@skip_counter} times (at: #{path.size}) @#{elapsed}" if display_skip_counter?
      return
    end
    current_value = data[pos[0]][pos[1]]
    unless path_is_complete?(path)
      if direction == :right
        exec_direction_in_subprocess(:right, pos[0], pos[1]+1, path)
      else
        exec_direction_in_subprocess(:down, pos[0]+1, pos[1], path)
      end
    end
  end

  def run
    @start_time = Time.now
    traverse_sub_trail(:down, start_pos.dup, [])
    traverse_sub_trail(:right, start_pos.dup, [])
    puts "Completed #{@completed_path_counter} paths"
  end
end

if ARGV[0]
  solver = Day15Solver.new(ARGV[0])
  solver.run
else
  puts "Please provide a filename and sort the output, such as..."
  puts "ruby day15.rb <filename>"
end


