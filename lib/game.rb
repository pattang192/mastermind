# game.rb
require_relative "mastermind"
require_relative "player"
# Creates components for a new game and holds shared playing functions
class Game
  attr_accessor :board, :hint_board

  include Mastermind
  def initialize(player_1_class, player_2_class)
    @board = []
    @hint_board = []
    @players = [player_1_class.new(@board, @hint_board), player_2_class.new(@board, @hint_board)]
    @code = @players[0].generate_code
  end

  def play
    loop do
      @players[1].input_guess(@board)
      @players[0].check_guess(@code)
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

  def max_turns?
    @board.size == MAX_TURNS
  end

  def decoded?
    @board.last == @code
  end

  def game_over?
    max_turns? || decoded?
  end

  def conclusion
    if decoded?
      puts "You win!"
    elsif max_turns?
      puts "\nGAME OVER! The secret code was #{@code}"
    end
  end
end
