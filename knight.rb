class Knight < Piece

  include Stepping

  DIRS = [[2, 1], [1, 2], [2, -1], [-1, 2], [-2, 1], [1, -2], [-2, -1], [-1, -2]]

  def to_s
    '♞'
  end

  def valid_moves
    steps(pos, DIRS)
  end

end