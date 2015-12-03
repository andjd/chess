module Stepping

  def steps(pos, dirs)
    locs = dirs.map {|el| [pos[0] + el[0], pos[1] + el[1]]}
    locs.select! do |loc|
      Board.on_board?(loc) &&
      (board[loc].nil? ? true : board[loc].color != self.color)
    end

    locs
  end

end