# player.rb
require_relative "mastermind"
require_relative "game"

# Contains functions shared by human and computer player
class Player
  include Mastermind
  include Game
end

# Contains functions unique to computer player
class ComputerPlayer < Player
  def random_color
    COLORS[COLORS.keys[rand(6)]]
  end

  def colors
    colors = ""
    COLORS.each do |key, value|
      colors << " #{value} #{key}"
    end
    colors
  end

  def generate_code
    code = ""
    i = 0
    while i < 4
      code << " #{random_color}"
      i += 1
    end
    code.strip
  end

  def check_guess
    code = @code.split
    guess = @board.last.split
    correct_positions = find_correct_positions(code, guess)
    remove_correct_positions(correct_positions, code, guess)
    wrong_positions = find_wrong_positions(code, guess)
    give_hint(correct_positions.size, wrong_positions)
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

  def print_board
    @board.each_with_index do |guess, i|
      puts "\n#{guess} Guess #{i + 1} \t Hint: #{@hint_board[i]}"
    end
  end

  def give_hint(num_red_pegs, num_white_pegs)
    hint = ""
    hint << (" #{RED}" * num_red_pegs) << (" #{WHITE}" * num_white_pegs)
    hint << (" #{GRAY}" * (4 - (num_red_pegs + num_white_pegs))) if (num_red_pegs + num_white_pegs) < 4
    @hint_board << hint
    print_board
  end
end

# Contains functions unique to human player
class HumanPlayer < Player
  def input_guess
    puts "Enter your guess, separated by spaces. (Eg. red blue red blue)"
    guess = gets.chomp.downcase.strip.split
    if code_valid?(guess)
      convert_to_pegs(guess)
    else
      puts "Invalid input".red
      input_guess
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
end
