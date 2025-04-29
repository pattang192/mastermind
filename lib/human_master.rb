# human_master.rb
require_relative "player"

# Set up for human code maker and computer solver
class HumanMaster < Player
  def generate_code
    puts "Enter a four-color code, separated by spaces. (Eg. red blue red white)"
    create_code
  end

  def create_code
    code = gets.chomp.downcase.strip.split
    if code_valid?(code)
      convert_to_pegs(code)
    else
      puts "Invalid input. Try again.".red
      create_code
    end
  end

  def code_valid?(code)
    code.size == 4 && code.all? { |color| COLORS.include?(color) }
  end

  def convert_to_pegs(array)
    array.map do |color|
      COLORS[color]
    end
    .join(" ")
  end

  def check_guess
    puts "\nGUESS: #{@board.last}"
    puts "\nCODE: #{@code}"
    num_red_pegs = correct_positions
    num_white_pegs = wrong_positions
    if (num_red_pegs + num_white_pegs) <= 4
      @game.give_hint(num_red_pegs, num_white_pegs)
      @permutations = filter_matches(@permutations, @board.last, num_red_pegs, num_white_pegs)
    else
      puts "That doesn't add up. Try again."
      check_guess
    end
  end

  def correct_positions
    puts "How many colors are in the correct position?"
    num_of_pegs
  end

  def wrong_positions
    puts "How many colors are correct, but in the wrong position?"
    num_of_pegs
  end

  def num_of_pegs
    pegs = gets.chomp.to_i
    if pegs.between?(0, 4)
      pegs
    else
      puts "Invalid entry".red
      num_of_pegs
    end
  end

  def input_guess
    if @board.size < 3
      @board << create_guess
      reduce_colors
    else
      @board << @permutations[0]
      if @permutations.count.zero?
        error
        exit
      end
    end
  end

  def create_guess
    [@colors[0], @colors[0], @colors[1], @colors[1]].join(" ")
  end

  def reduce_colors
    @colors.delete_at(1)
    @colors.delete_at(0)
  end

  def exact_matches(perms, guess, num_matches)
    matches = []
    perms.each do |perm|
      match = 0
      perm.split.each_with_index do |color, idx|
        match += 1 if color == guess.split[idx]
      end
      matches << perm if match == num_matches
    end
    matches
  end

  def loose_matches(perms, guess, num_matches)
    matches = []
    perms.each do |perm|
      match = 0
      perm.split.each_with_index do |color, idx|
        match += 1 if guess.split.include?(color) && color != guess.split[idx]
      end
      matches << perm if match == num_matches
    end
    matches
  end

  def filter_matches(perms, guess, exact_num, loose_num)
    perms = exact_matches(perms, guess, exact_num)
    loose_matches(perms, guess, loose_num)
  end

  def error
    puts "Looks like there was an error in your feedback. Game abandoned."
  end
end
