# main.rb

require "colorize"
require "rubocop"
require_relative "game"
require_relative "mastermind"
require_relative "player"

def play_game
  game = Game.new
  game.play
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
