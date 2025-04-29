# computer_master.rb
require_relative "player"

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
