class King < Piece

  include Stepping

  DIRS = [[1, 1], [1, 0], [0, 1], [1, -1], [-1, 0], [0, -1], [-1, -1], [-1, 1]]

  def to_s
    '♚'
  end

  def valid_moves
    steps(pos, DIRS)
  end

end