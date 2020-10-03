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

end

class Game
  include Colors
  @@max_guess = 12

  attr_reader :secret_code

  def initialize(role, code)
    @role = "computer"
    @secret_code = generate_secret_code
  end

  def generate_secret_code
    code = Array.new(4)
    code.map! do |code| 
      code = generate_random_color
    end
  end

  def self.max_guess
    @@max_guess
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

end

new_game = Game.new("computer", 1)
player = Player.new("player")

until player.guess_count > Game.max_guess || player.guess == new_game.secret_code
  
end
