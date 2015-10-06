require_relative 'pieces.rb'
require 'byebug'
class Board

  def self.fresh
    self.new.populate_board
  end

  def self.on_board?(pos)
    pos.all? {|el| el.between?(0,7)}
  end


  BACK_ROW = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @captured_pieces = []
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos,piece)
    x,y = pos
    grid[x][y] = piece
  end

  def populate_board

    @grid[0].map!.with_index do |_, idx|
      BACK_ROW[idx].new(:red, self)
    end

    @grid[7].map!.with_index do |_, idx|
      BACK_ROW[idx].new(:blue, self)
    end

    @grid[1].map! do |_|
      Pawn.new(:red, self)
    end

    @grid[6].map! do |_|
      Pawn.new(:blue, self)
    end

    self

  end

  def in_check?(color)
    k = find_piece(King, color)

    pieces.each do |spot|
      return true if spot && spot.color != color && spot.valid_moves.include?(k.pos)
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)

    my_pieces = pieces.select { |piece| piece.color == color }

    my_pieces.each do |piece|
      return false unless piece.safe_moves.empty?
    end

    true
  end

  def capture(pos)
     if self[pos]
       captured_piece = self[pos]
       @captured_pieces << captured_piece
    end
  end

  #returns only the first instance of piece
  def find_piece(piece, color)
    pieces.each do |spot|
      return spot if spot.is_a?(piece) && spot.color == color
    end
  end

  def pieces
    self.grid.flatten.compact
  end

  def deep_dup
    dd = Board.new
    pieces.each do |piece|
        dd[piece.pos] = piece.class.new(piece.color, dd)
    end

    dd
  end

end
