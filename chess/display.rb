require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'cursorable.rb'
require 'colorize'


class Display
  include Cursorable

  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected_piece = nil
  end

  def select_piece(color)
    pos = self.get_input
    piece = @board[pos]
    raise InvalidMove.new if piece.nil? || piece.color != color

    @selected_piece = @board[pos]

    nil
  end

  def move_piece(color)
    pos = self.get_input

    raise InvalidMove.new unless @selected_piece.check_check.include?(pos)

    @selected_piece.move(pos)

    nil
  end


  def render_board
    b = board.grid.map.with_index do |row, idx|
      row.map.with_index do |spot, idy|
        if spot
          spot.to_s.colorize(:color => spot.color, :background => background(idx, idy))
        else
          " ".colorize(:background => background(idx, idy))
        end
      end.join("")
    end.join("\n")

    puts b


  end

  def background(i,j)
    if [i, j] == @cursor_pos
       :yellow
    elsif (i + j).odd?
       :light_black
    else
       :light_white
    end
  end







end
