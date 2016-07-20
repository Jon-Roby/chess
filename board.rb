require_relative 'square'
require_relative 'pieces'
require 'colorize'

class Board
  attr_accessor :board, :currently_selected_piece
  attr_reader :sentinel

  def initialize
    @sentinel = EmptySquare.new
    @board = Array.new(8) { Array.new(8) { sentinel } }
    @currently_selected_piece = sentinel
  end

  def current_piece_valid_moves
    return [] unless self.currently_selected_piece.piece?

    valid_moves_for_piece(self.currently_selected_piece)
  end

  def valid_moves_for_piece(piece)
    piece.possible_moves & self.valid_moves(piece.position)
  end

  def in_check?(color)
    king = find_king(color)
    board.flatten.each do |piece|
      if piece.piece? && piece.color != color
        return true if piece.possible_moves.include?(king.position)
      end
    end
    false
  end

  def find_pieces_for_color(color)
    board.flatten.select do |piece|
      piece.piece? && piece.color == color
    end
  end

  def find_king(color)
    board.flatten.find do |piece|
      piece.piece? && piece.king? && piece.color == color
    end
  end

  def check_mate?(color)
    return false unless in_check?(color)
    board.flatten.none? do |piece|
      piece.piece? && (piece.color == color) && valid_moves(piece.position).any?
    end

  end

  def valid_moves(coord)
    #for a piece, possible_moves + don't leave king in check
    piece = self[*coord]
    piece.possible_moves.reject do |move|
      dupped_board = self.deep_dup
      dupped_board.move!(coord, move)
      dupped_board.in_check?(piece.color)
    end

  end

  def deep_dup
    dupped_board = Board.new

    self.board.each do |row|
      row.each do |piece|
        next if !piece.piece?
        dupped_piece = piece.dup
        dupped_piece.board = dupped_board
        dupped_board[ *piece.position ] = dupped_piece
      end
    end

    dupped_board
  end

  def render(cursor)
    rows, columns = STDIN.winsize

    ((rows - 8)/2).times { puts }

    current_piece_moves = current_piece_valid_moves
    @board.each.with_index do |row, row_i|
      print " " * ((columns - 16) / 2)
      row.each.with_index do |square_or_piece, col_i|
        str = square_or_piece.piece? ? square_or_piece.to_s : "  "

        if [row_i, col_i] == cursor
          print(str.on_yellow)
        elsif current_piece_moves.include?([row_i, col_i])
          print(str.on_green)
        else
          if (col_i + row_i) % 2 == 0
            print(str.on_red)
          else
            print(str.on_black)
          end
        end
      end

      puts
    end
    ""
  end

  def populate
    populate_back_rank(0, :black)
    populate_pawns(1, :black)

    populate_pawns(6, :white)
    populate_back_rank(7, :white)
  end

  def populate_pawns(row, color)
    self.board[row].each_with_index do |square, index|
      self.board[row][index] = Pawn.new(color, self, [row, index])
    end
  end

  def populate_back_rank(row, color)
    row_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    row_classes.each.with_index do |klass, i|
      self[row, i] = klass.new(color, self, [row, i])
    end
  end

  def [](row, col)
    board[row][col]
  end

  def []=(row, col, value)
    board[row][col] = value
  end

  def on_board?(pos)
    (0..7).to_a.include?(pos[0]) && (0..7).to_a.include?(pos[1])
  end

  def occupied?(pos)
    self[ *pos ].piece?
  end

  def move!(from_here, to_here)
    self[ *to_here ] = self[ *from_here ]
    self[ *to_here ].position = to_here
    self[ *from_here ] = sentinel

    if self[ *to_here ].piece?
      self[ *to_here ].moved = true
    end
  end

  def row(num)
    board[num]
  end
end
