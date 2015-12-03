require_relative 'display.rb'
require_relative 'errors.rb'
require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'cursorable.rb'

class Chess

  attr_reader :current_player

  private
  attr_reader :board
  public

  def initialize (player1 = Player, player2 = Player)
    @board = Board.fresh
    @display = Display.new(@board, self)
    @white = player1.new(@display, :blue)
    @black = player2.new(@display, :red)
    @current_player = @white

  end

  def toggle_player
    @current_player = (current_player == @white) ? @black : @white
  end

  def play
    until over?
      current_player.take_turn
      toggle_player

    end
    finish_game
  end

def finish_game
    toggle_player
    if board.pieces.length <= 2
      puts "Game Over, Stalemate!"
    else
      puts "Game Over, #{current_player.color.to_s} Won!"
    end
    
  end

  def over?
    board.checkmate?(:blue) || board.checkmate?(:red) || board.pieces.length <= 2
  end

end

if __FILE__ == $PROGRAM_NAME
  Chess.new(Player, ComputerPlayer).play
end
