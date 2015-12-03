module Sliding
  def slide(pos, dir)
    begin
    next_pos = [pos[0] + dir[0], pos[1] + dir[1]]
    raise NotInBoard.new unless Board.on_board?(next_pos)
    move_space =  board[next_pos]

    if move_space.nil?
      valid_moves =  slide(next_pos, dir)
      return [next_pos] + valid_moves

    elsif move_space.color == self.color
      return []

    elsif move_space.color != self.color
      return [next_pos]

    end

    rescue NotInBoard => e
      return []
    end
  end

end