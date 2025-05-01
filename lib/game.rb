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
    guess = @board.last
    i = @board.size
    puts "\n#{guess} Guess #{i} \t Hint: #{@hint_board[i - 1]}"
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
    @board.last == @player.code # CHANGED since last commit
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
