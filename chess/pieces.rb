# encoding: UTF-8

require 'byebug'

class Piece

  attr_reader :color, :board

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

  def on_board?(pos)
    pos.all? {|el| el.between?(0,7)}
  end

  def move(new_pos)
    raise InvalidMove.new unless self.valid_moves.include?(new_pos)
    board.capture(pos)

    board[pos] = nil

    board[new_pos] = self

  end



  def check_check
    moves = self.valid_moves

    moves.reject do |v_move|
      phantom_board = board.deep_dup
      phantom_piece = phantom_board[pos]
      phantom_piece.move(v_move)
      phantom_board.in_check?(color)
    end
  end

end

module Sliding
  def slide(pos, dir)
    begin
    next_pos = [pos[0] + dir[0], pos[1] + dir[1]]
    raise NotInBoard.new unless on_board?(next_pos)
    move_space =  board[next_pos]

    if move_space.nil?
      valid_moves =  slide(next_pos, dir)
      return [next_pos] + valid_moves

    elsif move_space.color == self.color
      return []

    elsif move_space.color != self.color
      return [next_pos]

    end

    rescue NotInBoard => e
      return []
    end
  end

end


module Stepping
  def steps(pos, dirs)
    locs = dirs.map {|el| [pos[0] + el[0], pos[1] + el[1]]}
    locs.select! do |loc|
      on_board?(loc)
      # begin
      #   raise NotInBoard.new unless loc.all? {|el| el.between?(0,7)}
      # rescue NotInBoard => e
      #   false
      # end
      # true
    end

    locs.select! do |loc|
      board[loc].nil? ? true : board[loc].color != self.color
    end

    locs
  end



end

class Pawn < Piece
  attr_reader :dir

  def initialize(color, board)
    super

    @starting = nil
    @dir = (color == :blue ? -1 : 1)

  end

  def to_s
    '♟'
  end

  def valid_moves
    @starting ||= pos
    out = []
    #starting double
    next_step = [pos[0] + dir, pos[1]]
    if @starting == pos
      nexter_step = [pos[0]+ (dir * 2), pos[1]]
      out << next_step if board[next_step].nil?
      out << nexter_step if board[nexter_step].nil? && board[next_step].nil?
    #normal
    else
      out << next_step if board[next_step].nil? && on_board?(next_step)
    end

    #capture
    right = [pos[0] + dir, pos[1] + 1]
    left = [pos[0] + dir, pos[1] - 1]

    out << left if on_board?(left) && board[left] && board[left].color != self.color

    out << right if on_board?(right) && board[right] && board[right].color != self.color

    out
  end

end

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

class Bishop < Piece
  include Sliding
  DIRS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  def to_s
    '♝'
  end

  def valid_moves
    DIRS.map {|dir| slide(pos, dir)}.flatten(1)
  end

end

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

class Queen < Piece
  include Sliding
  DIRS = [[1, 1], [1, 0], [0, 1], [1, -1], [-1, 0], [0, -1], [-1, -1], [-1, 1]]

  def to_s
    '♛'
  end

  def valid_moves
    DIRS.map {|dir| slide(pos, dir)}.flatten(1)
  end

end

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
