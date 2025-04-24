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
    code
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
