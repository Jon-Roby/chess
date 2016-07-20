class Rook < Piece
  include Slideable

  def try_moves
    RANK + FILE
  end

  def to_s
    self.color == :white ? "♜ ".white : "♜ ".blue
  end
end
