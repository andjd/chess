# encoding: UTF-8
class Piece

  attr_reader :color
  
  def initialize(color)
    @color = color
  end


end

class Pawn < Piece
  def to_s
    '♟'
  end
end

class Knight < Piece
  def to_s
    '♞'
  end
end

class Bishop < Piece
  def to_s
    '♝'
  end
end

class Rook < Piece
  def to_s
    '♜'
  end
end

class Queen < Piece
  def to_s
    '♛'
  end
end

class King < Piece
  def to_s
    '♚'
  end
end
