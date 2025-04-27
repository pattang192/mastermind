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
    puts "\n#{colors}"
  end

  def colors
    colors = ""
    COLORS.each do |key, value|
      colors << " #{value} #{key}"
    end
    colors.strip
  end

  def choose_role
    puts "\nTo be the code maker, enter 1. To be the codebreaker, enter 2."
    human_player = gets.chomp.to_i
    return human_player if [1, 2].include?(human_player)

    puts "That's not an option."
    choose_role
  end
end
