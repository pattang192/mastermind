# main.rb

require "colorize"
require "rubocop"
require_relative "game"
require_relative "mastermind"
require_relative "player"
require_relative "computer_master"
require_relative "human_master"

include Mastermind

def play_game
  intro
  human_player = choose_role
  case human_player
  when 1
    Game.new(HumanMaster).play
  when 2
    Game.new(ComputerMaster).play
  end
  repeat_game
end

def repeat_game
  puts "Would you like to play again? y/n"
  input = gets.chomp.downcase
  if input == "y"
    play_game
  else
    puts "Thank you for playing."
  end
end

play_game
