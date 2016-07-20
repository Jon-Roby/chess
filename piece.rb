
class Piece
  attr_reader :color
  attr_accessor :position, :board, :moved

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
    @moved = false
  end

  def piece?
    true
  end

  def king?
    false
  end

  def pawn?
    false
  end

  def ally?(other_color)
    self.color == other_color
  end

  def enemy?(other_color)
    self.color != other_color
  end

  def move(to_here)
    if board.valid_moves(self.position).include?(to_here)
      board.move!(self.position, to_here)
      true
    else
      false
    end
  end

end
