class Pawn < Piece

  attr_reader :dir

  def initialize(color, board)
    super
    @dir = (color == :blue ? -1 : 1)
  end

  def to_s
    '♟'
  end

  def valid_moves
    out = []
    next_step = [pos[0] + dir, pos[1]]

    #starting double
    if (color == :blue && pos[0] == 6) || (color == :red && pos[0] == 1)
      nexter_step = [pos[0]+ (dir * 2), pos[1]]
      out << next_step if board[next_step].nil?
      out << nexter_step if board[nexter_step].nil? && board[next_step].nil?

    #normal
    else
      out << next_step if Board.on_board?(next_step) && board[next_step].nil? 
    end

    #capture
    right = [pos[0] + dir, pos[1] + 1]
    left = [pos[0] + dir, pos[1] - 1]

    [left, right].each do |diag|
      out << diag if Board.on_board?(diag) && board[diag] && board[diag].color != self.color
    end

    out
  end

end