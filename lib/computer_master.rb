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

  def check_guess
    code = @code.split
    guess = @board.last.split
    exact_matches = find_exact_matches(code, guess)
    remove_exact_matches(exact_matches, code, guess)
    loose_matches = find_loose_matches(code, guess)
    @game.give_hint(exact_matches.size, loose_matches)
  end
end
