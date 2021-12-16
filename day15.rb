#!/usr/bin/env ruby

require 'byebug'

class Day15Solver

  def initialize(filename)
    @filename = filename
    @trails = {}
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
      # puts [complete, path.size, data.length, data[0].length, data.length + data[0].length].inspect
      puts "Path complete: #{path_score(path)}:: #{path}" if complete
    end
  end

  def path_score(path)
    path.map(&:to_i).reduce(:+)
  end

  def __next_step(pos, path)
    next_pos = [pos[0] + 1, pos[1]]
    next_pos if path_is_complete?(path + [next_pos])
  end

  def traverse_sub_trail(direction, pos, path)
    current_value = data[pos[0]][pos[1]]
    unless path_is_complete?(path)
      if direction == :right
        next_value = data[pos[0]][pos[1]+1]
        if next_value.nil?
          puts "reached far right #{path.length}" if ENV['DEBUG_DAY15']
          path_is_complete?(path)
        else
          child_path = path.dup + [next_value]
          puts "Traversing right from #{pos}(#{current_value}) - #{child_path}" if ENV['DEBUG_DAY15'] || path.size > path_max_length
          traverse_sub_trail(:right, [pos[0], pos[1]+1], child_path)
          traverse_sub_trail(:down, [pos[0], pos[1]+1], child_path)
        end
      else
        next_value = data[pos[0]+1][pos[1]] rescue nil
        if next_value.nil?
          puts "reached bottom #{path.length}" if ENV['DEBUG_DAY15']
          path_is_complete?(path)
        else
          child_path = path.dup + [next_value]
          puts "Traversing down from #{pos}(#{current_value}) - #{child_path}" if ENV['DEBUG_DAY15'] || path.size > path_max_length
          traverse_sub_trail(:right, [pos[0]+1, pos[1]], child_path)
          traverse_sub_trail(:down, [pos[0]+1, pos[1]], child_path)
        end
      end
    end
  end

  def run
    traverse_sub_trail(:right, start_pos.dup, [])
    traverse_sub_trail(:down, start_pos.dup, [])
  end
end

if ARGV[0]
  solver = Day15Solver.new(ARGV[0])
  solver.run
else
  puts "Please provide a filename and sort the output, such as..."
  puts "ruby day15.rb <filename> | sort -n | head"
end


