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

  def initialize
    @board = Board.fresh
    @display = Display.new(@board, self)
    @white = Player.new(@display, :blue)
    @black = Player.new(@display, :red)
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
    puts "Game Over, #{current_player.color.to_s} Won!"

  end

  def over?
    board.checkmate?(:blue) || board.checkmate?(:red)
  end

end

if __FILE__ == $PROGRAM_NAME
  Chess.new.play
end
