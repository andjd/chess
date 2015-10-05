# encoding: UTF-8
class ChessError < StandardError
end

class NotInBoard < ChessError
  def message
    "space not on board"
  end
end

class Piece

  attr_reader :color

  def initialize(color, board)
    @color = color
    @board = board
  end

  def pos
    board.grid.each.with_index do |row, idx|
      row.each.with_index do |spot, idy|
        return [idx, idy] if spot == self
      end
    end
    nil
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
  include Sliding
  DIRS = [[1, 1], [1, 0], [0, 1], [1, -1], [-1, 0], [0, -1], [-1, -1], [-1, 1]]
  def to_s
    '♛'
  end

  def valid_moves
    DIRS.map {|dir| slide(pos, dir)}

end

class King < Piece
  def to_s
    '♚'
  end
end

module Sliding
  def slide(pos, dir)
    begin
    next_pos = [pos[0] + dir[0], pos[1] + dir[1]]
    raise NotInBoard.new unless next_pos.all?(&:between?(0,7))
    move_space =  board[next_pos]

    if move_space.nil?
      valid_moves =  slide(next_pos, dir)
      return [next_pos] + valid_moves

    elsif move_space.color == self.color
      return []

    elsif move_space.color != self.color
      return [next_pos]

    rescue NotInBoard => e
      return []
    end
  end



end


module Stepping


end
