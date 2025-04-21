# mastermind.rb

# Contains basic components (functions and variables) of the game
module Mastermind
  BLUE = "##".blue.on_blue
  YELLOW = "##".light_yellow.on_light_yellow
  RED = "##".red.on_red
  WHITE = "##".light_white.on_light_white
  GREEN = "##".light_green.on_light_green
  PURPLE = "##".magenta.on_magenta
  GRAY = "##".gray.on_gray

  COLORS = { "blue" => BLUE, "yellow" => YELLOW, "red" => RED, "white" => WHITE,
             "green" => GREEN, "purple" => PURPLE }.freeze

  MAX_TURNS = 12

  def intro
    puts "Welcome to Mastermind"
    puts "\nYou have 12 attempts to guess the secret code."
    puts "\n Here are the available colors:"
    puts colors
  end
end
