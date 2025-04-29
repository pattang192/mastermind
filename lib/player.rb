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
  end

  def code # rubocop:disable Style/TrivialAccessors
    @code
  end
end

# Set up for computer code maker and human solver
class ComputerMaster < Player
  def generate_code
    code = ""
    i = 0
    while i < 4
      code << " #{random_color}"
      i += 1
    end
    code.strip
  end

  def random_color
    COLORS[COLORS.keys[rand(6)]]
  end

  def input_guess
    puts "Enter your guess, separated by spaces. (Eg. red blue red blue)"
    @board << create_code
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

  def check_guess
    code = @code.split
    guess = @board.last.split
    correct_positions = find_correct_positions(code, guess)
    remove_correct_positions(correct_positions, code, guess)
    wrong_positions = find_wrong_positions(code, guess)
    @game.give_hint(correct_positions.size, wrong_positions)
  end

  def find_correct_positions(code, guess)
    correct_positions = []
    code.each_with_index do |color_i, i|
      correct_positions << i if color_i == guess[i]
    end
    correct_positions
  end

  def remove_correct_positions(correct_positions, code, guess)
    correct_positions.reverse.each do |index|
      code.delete_at(index)
      guess.delete_at(index)
    end
  end

  def find_wrong_positions(code, guess)
    wrong_positions = 0
    code.reverse.each_with_index do |color_i, i|
      next unless guess.index(color_i)

      wrong_positions += 1
      guess.delete_at(guess.index(color_i))
      code.delete_at(i)
    end
    wrong_positions
  end
end

# Set up for human code maker and computer solver
class HumanMaster < Player
  def generate_code
    puts "Enter a four-color code, separated by spaces. (Eg. red blue red white)"
    create_code
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
    array.map do |color|
      COLORS[color]
    end
    .join(" ")
  end

  def check_guess
    puts "\nGUESS: #{@board.last}"
    puts "\nCODE: #{@code}"
    num_red_pegs = correct_positions
    num_white_pegs = wrong_positions
    if (num_red_pegs + num_white_pegs) <= 4
      @game.give_hint(num_red_pegs, num_white_pegs)
    else
      puts "That doesn't add up. Try again."
      check_guess
    end
  end

  def correct_positions
    puts "How many colors are in the correct position?"
    num_of_pegs
  end

  def wrong_positions
    puts "How many colors are correct, but in the wrong position?"
    num_of_pegs
  end

  def num_of_pegs
    pegs = gets.chomp.to_i
    if pegs.between?(0, 4)
      pegs
    else
      puts "Invalid entry".red
      num_of_pegs
    end
  end

  def input_guess
    @board << create_guess
  end
end
