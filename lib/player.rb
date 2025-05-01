# player.rb
require_relative "mastermind"
require_relative "game"

# Contains functions shared by human and computer solver
class Player
  include Mastermind

  def initialize(board, game)
    @board = board
    @game = game
    @code = generate_code
    @permutations = all_combinations
    @colors = COLORS.values.shuffle
  end

  def create_code
    code = gets.chomp.downcase.strip.split
    if code_valid?(code)
      convert_to_pegs(code)
    else
      puts "Invalid input. Try again.".red
      create_code
    end
  end

  def code_valid?(code)
    code.size == 4 && code.all? { |color| COLORS.include?(color) }
  end

  def convert_to_pegs(array)
    array = array.map do |color|
      COLORS[color]
    end
    array.join(" ")
  end

  def find_exact_matches(code, guess)
    exact_match_index = []
    code.each_with_index do |color_i, i|
      exact_match_index << i if color_i == guess[i]
    end
    exact_match_index
  end

  def remove_exact_matches(correct_positions, code, guess)
    correct_positions.reverse.each do |index|
      code.delete_at(index)
      guess.delete_at(index)
    end
  end

  def find_loose_matches(code, guess)
    loose_match = 0
    code.reverse.each_with_index do |color_i, i|
      next unless guess.index(color_i)

      loose_match += 1
      guess.delete_at(guess.index(color_i))
      code.delete_at(i)
    end
    loose_match
  end

  def code # rubocop:disable Style/TrivialAccessors
    @code
  end
end
