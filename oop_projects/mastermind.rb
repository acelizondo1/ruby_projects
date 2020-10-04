module Colors
  COLORS = [
    "red", 
    "blue", 
    "green", 
    "yellow",
    "orange",
    "purple"
  ]

  def generate_random_color
    COLORS[rand(6)]
  end

  def list_colors
    color_string = "\nThe available colors are "
    COLORS.each_with_index do |color, index|
      if index%2 == 0
        color_string += "\n"
      end
      color_string += color + " "
    end
    puts color_string
  end

  def is_valid_color?(color_string)
    COLORS.include?(color_string)
  end
end

class Game
  include Colors
  @@MAX_GUESS = 2

  attr_reader :secret_code

  def initialize(role, code)
    @role = "computer"
    @secret_code = generate_secret_code
  end

  def start_game(player)
    until player.guess_count >= @@MAX_GUESS || player.guess == @secret_code
      puts "You have #{@@MAX_GUESS-player.guess_count} guesses left."
      player.ask_for_guess
      guess_result = check_code(player.guess)
      unless guess_result[0] == 4 && guess_result[1] ==4
        display_guess_results(guess_result)
      end
    end
    if(player.guess == @secret_code)
      puts "You successfully guessed the code!"
    else
      puts "You ran out of guesses. The correct code was:"
      @secret_code.each do |code|
        print code + " "
      end
      puts "\nPlease try again."
    end
  end

  private
  def generate_secret_code
    code = Array.new(4)
    code.map! do |code| 
      code = generate_random_color
    end
  end

  def check_code(player_code)
    match_array = []
    if player_code == self.secret_code
      match_array = [4,4]
    else
      match_array = [0,0]
      @secret_code.each_with_index do |code, index|
        if player_code[index] == code
          match_array[0] += 1
          match_array[1] += 1
        elsif player_code.include?(code)
          match_array[1] += 1
        end
      end
    end
    match_array
  end

  def display_guess_results(results)
    puts "Your guess had #{results[0]} colors in the right position and #{results[1]} total correct colors"
  end

end

class Player
  include Colors

  attr_reader :guess_count, :guess

  def initialize(role)
    @role         = "player"
    @guess        = ""
    @guess_count  = 0
  end

  def ask_for_guess
    valid_response = false
    until valid_response
      puts "Please enter your guess in the format 'color color color color'(to list available color options enter 'options'):"
      response = gets.chomp
      valid_response = validate_response(response)
    end
    @guess_count += 1
    @guess = valid_response
  end

  private
  def validate_response(guess_string)
    guess_array = []
    guess_string = guess_string.split(" ")
    guess_string.each do |color_guess|
      color_guess = color_guess.downcase
      if is_valid_color?(color_guess)
        guess_array.push(color_guess)
      elsif color_guess == 'options'
        list_colors
        return false
      else 
         return false
      end
    end
    guess_array
  end

end

new_game = Game.new("computer", 1)
player = Player.new("player")


new_game.start_game(player)