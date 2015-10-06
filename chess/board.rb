require_relative 'pieces.rb'
require 'byebug'
class Board

  def self.fresh
    self.new.populate_board
  end

  BACK_ROW = [
    Proc.new { |color, board| Rook.new(color, board) },
    Proc.new { |color, board| Knight.new(color, board) },
    Proc.new { |color, board| Bishop.new(color, board) },
    Proc.new { |color, board| King.new(color, board) },
    Proc.new { |color, board| Queen.new(color, board) },
    Proc.new { |color, board| Bishop.new(color, board) },
    Proc.new { |color, board| Knight.new(color, board) },
    Proc.new { |color, board| Rook.new(color, board) }
  ]

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
      BACK_ROW[idx].call(:red, self)
    end

    @grid[7].map!.with_index do |_, idx|
      BACK_ROW[idx].call(:blue, self)
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

    self.grid.flatten.each do |spot|
      return true if spot && spot.color != color && spot.valid_moves.include?(k.pos)
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)

    k = find_piece(King, color)

    k.check_check.empty?
  end

  def capture(pos)
     if self[pos]
       captured_piece = self[pos]
       @captured_pieces << captured_piece
    end
  end


  def find_piece(piece, color)
    #returns only the first instance of piece
    self.grid.flatten.each do |spot|
      return spot if spot.is_a?(piece) && spot.color == color
    end
  end


  def deep_dup
    dd = Board.new
    self.grid.each.with_index do |row, idx|
      row.each.with_index do |spot, idy|
        dd[[idx,idy]] = spot.class.new(spot.color, dd) if spot
      end
    end
    dd
  end





end
