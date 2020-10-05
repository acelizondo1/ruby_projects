module Colors
  COLORS = [
    "red", 
    "blue", 
    "green", 
    "yellow",
    "orange",
    "purple"
  ]

  def return_string_by_index(index_array)
    string_array = []
    index_array.each do |index|
      string_array.push(COLORS[index])
    end
    string_array
  end

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

  def check_code(player_code, secret_code)
    match_array = []
    if player_code == secret_code
      match_array = [4,4]
    else
      match_array = [0,0]
      player_code.each_with_index do |code, index|
        if secret_code[index] == code
          match_array[0] += 1
          match_array[1] += 1
        elsif secret_code.include?(code)
          match_array[1] += 1
        end
      end
    end
    match_array
  end
end

class Game
  include Colors
  @@MAX_GUESS = 12

  attr_reader :secret_code

  def initialize(role)
    @role = role
    if @role == "computer"
      @secret_code = generate_secret_code
    else
      @secret_code = nil
    end
  end

  def start_game(player)
    if @role == "player"
      computer_game(player)
    else
      player_game(player)
    end
  end

  def computer_game(player)
    computer_guess = []
    @secret_code = player.ask_for_code
    guess_result = [0,0]
    until player.guess == @secret_code || player.guess_count >= @@MAX_GUESS
      player.generate_computer_guess(guess_result, @secret_code)
      guess_result = check_code(player.guess, @secret_code)
      unless guess_result[0] == 4 && guess_result[1] == 4
        display_guess_results(guess_result)
      end
    end
    display_end_game(player)
  end

  def player_game(player)
    until player.guess_count >= @@MAX_GUESS || player.guess == @secret_code
      puts "You have #{@@MAX_GUESS-player.guess_count} guesses left."
      player.ask_for_guess
      guess_result = check_code(player.guess, @secret_code)
      unless guess_result[0] == 4 && guess_result[1] == 4
        display_guess_results(guess_result)
      end
    end
    display_end_game(player)
  end

  private
  def generate_secret_code
    code = Array.new(4)
    code.map! do |code| 
      code = generate_random_color
    end
  end

  def display_guess_results(results)
    if @role == "computer"
      addressing_string = "Your"
    else
      addressing_string = "The computer's"
    end
    puts "#{addressing_string} guess had #{results[0]} colors in the right position and #{results[1]} total correct colors"
  end

  def display_end_game(player)
    if(player.guess == @secret_code)
      if @role == "computer"
        puts "You successfully guessed the code!"
      else
        puts "The computer successfully guessed your code in #{player.guess_count} guesses"
      end
    else
      puts "You ran out of guesses. The correct code was:"
      @secret_code.each do |code|
        print code + " "
      end
      puts "\nPlease try again."
    end
  end

end

class Player
  include Colors
  attr_accessor :guess_count
  attr_reader   :guess

  def initialize(role)
    @role         = role
    @guess        = ""
    @guess_count  = 0
    if role == "computer"
      @guesses_array = generate_guess_array
    end
  end

  def ask_for_code
    get_code("Please enter the code your four color code in the format 'color color color color'(to list available color options enter 'options'):")
  end

  def ask_for_guess
    @guess_count += 1
    @guess = get_code("Please enter your guess in the format 'color color color color'(to list available color options enter 'options'):")
  end

  def generate_computer_guess(response_array, secret_code)
    @guess_count += 1
    if guess_count == 1
      @guess = return_string_by_index([0,0,1,1])
    else
      @guesses_array.reject! do |guess| 
        check = check_code(return_string_by_index(guess), secret_code)
        check[0] <= response_array[0] || check[1] <= response_array[0]
      end
      @guess = return_string_by_index(@guesses_array[rand(@guesses_array.length)])
    end
    @guess.each do |code|
      print code + " "
    end
    puts "\n"
  end

  private
  def get_code(display_string)
    valid_response = false
    until valid_response
      puts display_string
      response = gets.chomp
      valid_response = validate_response(response)
    end
    valid_response
  end

  def validate_response(guess_string)
    guess_array = []
    guess_string = guess_string.split(" ")
    if guess_string.length > 4 
      return false
    end
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

  def generate_guess_array
    guess_array = []
    for i in 0..5
      for j in 0..5
        for k in 0..5
          for l in 0..5
            guess_array.push([i,j,k,l])
          end
        end
      end
    end
     guess_array 
  end

end

game_type = ""
until game_type == "player" || game_type == "computer"
  puts "Enter 'player' to attempt to guess the computer's code, or enter 'computer' to select a code for the computer to guess:"
  game_type = gets.chomp.downcase
end
if(game_type == "player")
  new_game = Game.new("computer")
  player = Player.new("player")
else
  new_game = Game.new("player")
  player = Player.new("computer")
end
new_game.start_game(player)
