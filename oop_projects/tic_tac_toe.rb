require 'pry'
class Game
  attr_reader :current_game, :player_turn

  def initialize()
    @player_turn  = "x"
    @winner       = false
    @current_game = {
      [1,1] => "",
      [1,2] => "",
      [1,3] => "",
      [2,1] => "",
      [2,2] => "",
      [2,3] => "",
      [3,1] => "",
      [3,2] => "",
      [3,3] => "",
    }
  end

  def display_board
    puts "x,y  1     2     3  \n\n  1  #{@current_game[[1,1]]}  |  #{@current_game[[1,2]]}  |  #{@current_game[[1,3]]}  \n    ________________\n\n  2  #{@current_game[[2,1]]}  |  #{@current_game[[2,2]]}  |  #{@current_game[[2,3]]}  \n    ________________\n\n  3  #{@current_game[[3,1]]}  |  #{@current_game[[3,2]]}  |  #{@current_game[[3,3]]}  "
  end

  def update_board(placement)
    @current_game[placement] = @player_turn
    change_turn
    display_boards
    self.is_tie? ? self.update_winner(true) : false
  end

  def update_winner(tie=false)
    tie ? @winner = "tie" : @winner = @player_turn
  end

  def has_winner?
    @winner
  end

  def open_spot?(position)
    current_game[position] == "" ? true : false
  end

  def is_tie?
    @current_game.any { |cell| cell == ""}
  end

  private
  def change_turn
    @player_turn == 'x' ? @player_turn = "o" : @player_turn = "x"
  end
end

class Player
  attr_reader :name, :moves, :x_o

  WINS = [
    [[1,1], [1,2], [1,3]],
    [[2,1], [2,2], [2,3]],
    [[3,1], [3,2], [3,3]],
    [[1,1], [2,1], [3,1]],
    [[1,2], [2,2], [3,2]],
    [[1,3], [2,3], [3,3]],
    [[1,1], [2,2], [3,3]],
    [[1,3], [2,2], [3,1]],
  ]
  

  def initialize(name, x_o)
    @name  = name
    @x_o   = x_o
    @moves = []
  end

  def make_move(game)
    move = ""
    until self.valid_move?(game, move)
      puts "#{self.name} please enter your move in the format 'x, y' for an open spot"
      move = gets.chomp.split(",")
    end
    self.player_win? ? game.update_winner : ""
    @moves.last
  end

  def player_win?
    WINS.each do |win|
      is_win = win.all? { |cell| self.moves.include?(cell) }
      if is_win
        return true
      end
    end
    false
  end

  private
  def valid_move?(game, move)
    x = move[0].to_i
    y = move[1].to_i
    if valid_int?(x) && valid_int?(y)
      move = [x, y]
      game.open_spot?(move) ? @moves.push(move) : false
    else
      false
    end
  end

  def valid_int?(number)
    number > 0 && number < 4
  end

end

#Creates new Game instance and asks for names of the two player instances
new_game = Game.new()
puts "Please enter the name for the x player:"
name_x = gets.chomp
player_x = Player.new(name_x, "x")
puts "Please enter the name for the o player:"
name_o = gets.chomp
player_o = Player.new(name_o, "o")


#Main game loop, runs while no winner has been set 
until new_game.has_winner?
  if new_game.player_turn == "x"
    player_move = player_x.make_move(new_game)
  else
    player_move = player_o.make_move(new_game)
  end
  new_game.update_board(player_move)
end

#handles end of game message
if new_game.has_winner? == "tie"
  result = "It's a tie!"
else
  new_game.has_winner? == "x" ? result = "#{player_x.name} is the winner!" : result = "#{player_o.name} is the winner!"
end
puts result