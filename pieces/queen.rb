class Queen < Piece
  include Slideable

  def try_moves
    RANK + FILE + DIAGONAL
  end

  def to_s
    self.color == :white ? "♛ ".white : "♛ ".blue
  end
end
