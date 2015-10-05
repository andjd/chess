require_relative 'board.rb'
require_relative 'cursorable.rb'
require 'colorize'


class Display
  include Cursorable

  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected? = false
  end


  def render_board
    b = board.map.with_index do |row, idx|
      row.map.with_index do |spot, idy|
        if spot
          spot.to_s.colorize(:color => spot.color, :background => background(idx, idy))
        else
          " ".colorize(:background => background(idx, idy))
        end
      end
    end
  end

  def background(i,j)
    if [i, j] == @cursor_pos
       :light_red
    elsif (i + j).odd?
       :light_black
    else
       :light_white
    end







end
