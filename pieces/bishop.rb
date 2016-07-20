class Bishop < Piece
  include Slideable

  def try_moves
    DIAGONAL
  end

  def to_s
    self.color == :white ? "♝ ".white : "♝ ".blue
  end
end
