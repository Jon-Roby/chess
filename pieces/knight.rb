class Knight < Piece
  include Steppable

  # sorted clockwise using row, column coordinates
  KNIGHT = [
             [-2,1],
             [-1,2],
             [1,2],
             [2,1],
             [2,-1],
             [1,-2],
             [-1,-2],
             [-2,-1],
  ]

  def try_moves
    KNIGHT
  end
  
  def to_s
    self.color == :white ? "♞ ".white : "♞ ".blue
  end
end
