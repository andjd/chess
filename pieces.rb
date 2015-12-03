# encoding: UTF-8
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'rook.rb'
require_relative 'bishop.rb'
require_relative 'knight.rb'
require_relative 'sliding.rb'
require_relative 'stepping.rb'

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

  def move(new_pos)
    raise InvalidMove.new unless self.valid_moves.include?(new_pos)

    board.capture(pos)
    board[pos] = nil
    board[new_pos] = self
  end



  def safe_moves
    moves = self.valid_moves

    moves.reject do |valid_move|
      phantom_board = board.deep_dup
      phantom_piece = phantom_board[pos]
      phantom_piece.move(valid_move)

      phantom_board.in_check?(color)
    end
  end

end

