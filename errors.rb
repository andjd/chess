class ChessError < StandardError
end

class InvalidMove < ChessError
  def message
    "invalid move"
  end
end

class NotInBoard < ChessError
  def message
    "space not on board"
  end
end