# game.rb
require_relative "mastermind"
require_relative "player"
# Creates components for a new game and holds shared playing functions
class Game
  attr_accessor :board, :hint_board

  include Mastermind
  def initialize(player_class)
    @board = []
    @hint_board = []
    @player = player_class.new(@board, self)
  end

  def play
    loop do
      @player.input_guess
      @player.check_guess
      print_board
      conclusion
      return if game_over?
    end
  end

  def print_board
    @board.each_with_index do |guess, i|
      puts "\n#{guess} Guess #{i + 1} \t Hint: #{@hint_board[i]}"
    end
  end

  def give_hint(num_red_pegs, num_white_pegs)
    hint = ""
    hint << (" #{RED}" * num_red_pegs) << (" #{WHITE}" * num_white_pegs)
    @hint_board << hint
  end

  def max_turns?
    @board.size == MAX_TURNS
  end

  def decoded?
    @hint_board.last.split.count(RED) == 4
  end

  def game_over?
    max_turns? || decoded?
  end

  def conclusion
    if decoded?
      puts "You win!"
    elsif max_turns?
      puts "\nGAME OVER! The secret code was #{@player.code}"
    end
  end
end
