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
