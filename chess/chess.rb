require_relative 'display.rb'

class ChessError < StandardError
end

class InvalidMove < ChessError
  def message
    "invalid move"
  end
end

class NotInBoard < ChessError
  def message
    "space not on board"
  end
end



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
    @current_player = current_player == @white ? @black : @white
  end

  def play
    until over?
      current_player.take_turn

      toggle_player

    end

    toggle_player
    if board.pieces.length <= 2
      puts "Game Over, You Both Fail!"
    else
      puts "Game Over, #{current_player.color.to_s} Won!"
    end
    
  end

  def over?
    board.checkmate?(:blue) || board.checkmate?(:red) || board.pieces.length <= 2
  end

end

if __FILE__ == $PROGRAM_NAME
  Chess.new(ComputerPlayer, ComputerPlayer).play
end
