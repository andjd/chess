$last_error = nil
require "byebug"
class Player
  attr_reader :display, :color

  def initialize(display, color)
    @display = display
    @color = color
  end

  def take_turn
    display.select_piece(color)
    display.move_piece(color)

  rescue InvalidMove => e
    $last_error =  e.message
    retry
  end

end

class ComputerPlayer < Player

  attr_reader :board

  def initialize(display, color)
    super

    @board = display.board
  end

  def take_turn
    random_move

    system("clear")
    display.render_board
    #sleep(1)
  end

  def random_move
    rand_piece = nil
    until rand_piece && !rand_piece.safe_moves.empty?
      rand_piece = board.pieces(color).sample
    end

    rand_move = rand_piece.safe_moves.sample
    rand_piece.move(rand_move)
  end

  def all_possible_moves

  end

end
