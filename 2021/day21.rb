#!/usr/bin/env ruby

require 'byebug'
require 'looksee'

class Day21Game
  class DeterministicDie
    attr_reader :current_value, :die_counter
    def initialize
      @die_counter = 0
      @current_value = 0
    end

    def roll
      @die_counter += 1
      if @current_value > 99
        @current_value = 1
      else
        @current_value += 1
      end
    end
  end

  class Player
    attr_accessor :score, :cur_position
  end

  def initialize(input)
    @input = input
    @die = DeterministicDie.new
    @players = []
    @players << Player.new
    @players << Player.new
    @players[0].score = 0
    @players[1].score = 0
    a, b = input.split("\n").map { |line| line.split(" ").last }
    @players[0].cur_position = a.to_i
    @players[1].cur_position = b.to_i
    @cur_player = -1
  end

  def game_over?
    @players.any? { |player| player.score >= 1000 }
  end

  def compute_new_position(player, movement)
    # debugger
    new_pos = (@players[player].cur_position + movement) % 10
    @players[player].cur_position = new_pos == 0 ? 10 : new_pos
  end

  def play
    until game_over?
      @cur_player = (@cur_player + 1) % 2
      three_dices = [@die.roll, @die.roll, @die.roll]
      compute_new_position(@cur_player, three_dices.sum)
      @players[@cur_player].score += @players[@cur_player].cur_position
      puts "Player #{@cur_player + 1} rolls #{three_dices} and moves to space #{@players[@cur_player].cur_position} for a total score of #{@players[@cur_player].score}"
    end
    puts results
    puts [@die, @players].inspect
  end

  def results
    final_value = \
      if @players[0].score < @players[1].score
        @die.die_counter * @players[0].score
      else
        @die.die_counter * @players[1].score
      end
    "Final value: #{final_value}
    Die counter: #{@die.die_counter}
    Player 1: #{@players[0].score}
    Player 2: #{@players[1].score}
    "
  end
end

example_input = "Player 1 starting position: 4
Player 2 starting position: 8
"
part1_input = "Player 1 starting position: 1
Player 2 starting position: 5
"

Day21Game.new(example_input).play
