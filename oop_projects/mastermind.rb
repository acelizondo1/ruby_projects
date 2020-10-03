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

  def initialize(role, code)
    @role = "computer"
    @secret_code = Array.new(4)
  end

  def generate_secret_code
    @secret_code.map! do |code| 
      code = generate_random_color
    end
  end

end

class Player
  include Colors

  def initialize(role)
    @role         = "player"
    @player_guess = ""
    @guess_count  = 0
  end

end

new_game = Game.new("computer", 1)
player = Player.new("player")

p new_game.generate_secret_code