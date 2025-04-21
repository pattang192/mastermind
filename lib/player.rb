# player.rb
require_relative "mastermind"
require_relative "game"

# Contains functions shared by human and computer player
class Player
  include Mastermind
  include Game
end
