module Steppable

  def possible_moves
    moves = []
    self.try_moves.each do |step|
      coord1, coord2 = self.position[0] + step[0], self.position[1] + step[1]
      if self.board.on_board?([coord1, coord2]) && !self.board[coord1, coord2].ally?(self.color)
        moves << [coord1, coord2]
      end
    end
    moves
  end

end
