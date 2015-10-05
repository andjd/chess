require_relative 'pieces.rb'

class Board

  BACK_ROW = [
    Proc.new { |color| Rook.new(color) },
    Proc.new { |color| Knight.new(color) },
    Proc.new { |color| Bishop.new(color) },
    Proc.new { |color| King.new(color) },
    Proc.new { |color| Queen.new(color) },
    Proc.new { |color| Bishop.new(color) },
    Proc.new { |color| Knight.new(color) },
    Proc.new { |color| Rook.new(color) }
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
      BACK_ROW[idx].call(:red)
    end

    @grid[7].map!.with_index do |_, idx|
      BACK_ROW[idx].call(:blue)
    end

    @grid[1].map! do |_|
      Pawn.new(:red)
    end

    @grid[6].map! do |_|
      Pawn.new(:blue)
    end

  end

end
