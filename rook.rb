class Rook < Piece

  include Sliding

  DIRS = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  def to_s
    '♜'
  end

  def valid_moves
    DIRS.map {|dir| slide(pos, dir)}.flatten(1)
  end

end