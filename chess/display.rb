require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'cursorable.rb'
require 'colorize'


class Display
  include Cursorable

  attr_reader :board, :selected_piece, :game, :cursor_pos

  def initialize(board, game)
    @board = board
    @game = game
    @cursor_pos = [0, 0]
    @selected_piece = nil
  end

  def select_piece(color)
    pos = self.get_input
    piece = board[pos]
    raise InvalidMove.new if piece.nil? || piece.color != color

    @selected_piece = board[pos]

    nil
  end

  def move_piece(color)

    pos = self.get_input

    raise InvalidMove.new unless selected_piece.safe_moves.include?(pos)

    selected_piece.move(pos)
    ensure
    @selected_piece = nil

    nil
  end

  def next_piece
    pieces = board.pieces.select{ |spot| spot && spot.color == game.current_player.color }
    current_piece_index = pieces.map { |piece| piece.pos }.find_index(cursor_pos)
    if current_piece_index
      pieces[(current_piece_index + 1) % pieces.length].pos
    else
      pieces.first.pos
    end
  end

  def render_board
    b = board.grid.map.with_index do |row, idx|
      row.map.with_index do |spot, idy|
        if spot
          " #{spot.to_s} ".colorize(:color => spot.color, :background => background(idx, idy))
        else
          "   ".colorize(:background => background(idx, idy))
        end
      end.join("")
    end.join("\n")

    print "#{game.current_player.color.to_s.capitalize}'s turn "
    puts $last_error ? "#{$last_error} \n".red : "\n\n"
    puts selected_piece ? "Selected Piece: #{selected_piece.to_s}\n\n" : "\n\n"
    puts b
    puts "\nUse arrow keys or WASD to move cursor."
    puts "Use return or space to select a piece."
    puts "Use tab to cycle through your pieces."
    $last_error = nil



  end

  def background(i,j)
    if selected_piece && [i, j] == selected_piece.pos
       :cyan
    elsif [i, j] == cursor_pos
      :yellow
    elsif (i + j).odd?
       :light_black
    else
       :light_white
    end
  end

end
