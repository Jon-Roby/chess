class King < Piece
  include Steppable

  KING = [
         [-1, -1],
         [-1, 0],
         [-1, 1],
         [0, 1],
         [1, 1],
         [1, 0],
         [1, -1],
         [0, -1]
  ]

  def try_moves
    KING
  end

  def king?
    true
  end

  def to_s
    #"♔"
    self.color == :white ? "♚ ".white : "♚ ".blue
  end

  def move(to_here)
    super
  end

end
