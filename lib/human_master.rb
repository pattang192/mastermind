# human_master.rb
require_relative "player"

# Set up for human code maker and computer solver
class HumanMaster < Player
  def generate_code
    puts "Enter a four-color code, separated by spaces. (Eg. red blue red white)"
    create_code
  end

  def check_guess
    code = @code.split
    guess = @board.last.split
    exact_matches = find_exact_matches(code, guess)
    remove_exact_matches(exact_matches, code, guess)
    loose_matches = find_loose_matches(code, guess)
    @game.give_hint(exact_matches.size, loose_matches)
    @permutations = filter_matches(@permutations, @board.last, exact_matches.size, loose_matches)
    sleep(1)
  end

  def input_guess
    if @board.count < 3
      @board << [@colors[0], @colors[0], @colors[1], @colors[1]].join(" ")
      reduce_colors
    else
      @board << @permutations[0]
      if @permutations.count.zero?
        error
        exit
      end
    end
  end

  def reduce_colors
    @colors.delete_at(1)
    @colors.delete_at(0)
  end

  def exact_matches(perms, guess, num_matches)
    matches = []
    perms.each do |perm|
      match = 0
      guess.split.each_with_index do |color, idx|
        match += 1 if color == perm.split[idx]
      end
      matches << perm if match == num_matches
    end
    matches
  end

  def loose_matches(perms, guess, num_matches)
    matches = []
    guess = guess.split
    perms.each do |perm|
      perm = perm.split
      exact = find_exact_matches(guess, perm)
      remove_exact_matches(exact, guess, perm)
      matches << perm if find_loose_matches(guess, perm) == num_matches
    end
  end

  def filter_matches(perms, guess, exact_num, loose_num)
    perms = exact_matches(perms, guess, exact_num)
    loose_matches(perms, guess, loose_num)
  end

  def error
    puts "Looks like there was an error in your feedback. Game abandoned."
  end
end
