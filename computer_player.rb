class ComputerPlayer < Player

  attr_reader :board

  def initialize(display, color)
    super

    @board = display.board
  end

  def take_turn
    sleep(1)

    random_move

    system("clear")
    display.render_board
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
