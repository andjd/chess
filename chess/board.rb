require_relative 'pieces.rb'
require 'byebug'
class Board

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

    populate_board
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end


  def populate_board

    @grid[0].map!.with_index do |_, idx|
      #debugger
      BACK_ROW[idx].call(:red, self)
    end

    @grid[7].map!.with_index do |_, idx|
      BACK_ROW[idx].call(:blue, self)
    end

    @grid[1].map! do |_|
      Pawn.new(:red, self)
    end

    # @grid[6].map! do |_|
    #   Pawn.new(:blue, self)
    # end

  end

end
