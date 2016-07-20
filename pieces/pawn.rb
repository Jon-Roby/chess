require_relative './../vector'

class Pawn < Piece

  FORWARD_MOVES = [[1, 0]]
  ATTACK_MOVES = [[1, -1], [1, 1]]

  def initialize(color, board, position)
    super
  end

  def attack_moves
    checked_moves = []
    moves = ATTACK_MOVES.dup
    moves.each do |move|
      move = [move[0] * (self.color == :white ? -1 : 1), move[1]]
      spot = Vector.new(move) + self.position
      if board.on_board?(spot) && board[*spot].enemy?(self.color) &&
        checked_moves << spot
      end
    end

    checked_moves
  end

  def forward_moves
    checked_moves = []
    moves = FORWARD_MOVES.dup
    moves << [2, 0] unless self.moved
    moves.each do |move|
      move = [move[0] * (self.color == :white ? -1 : 1), 0]
      spot = Vector.new(move) + self.position
      if !board.occupied?(spot) && board.on_board?(spot)
        checked_moves << spot
      end
    end

    checked_moves
  end

  def possible_moves
    (attack_moves + forward_moves)
  end

  def pawn?
    true
  end

  def to_s
    self.color == :white ? "♟ ".white : "♟ ".blue
  end
end
