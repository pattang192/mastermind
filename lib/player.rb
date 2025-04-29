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

  def code # rubocop:disable Style/TrivialAccessors
    @code
  end
end
