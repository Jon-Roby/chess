require 'io/console'
require_relative 'board'
require_relative 'vector'
require_relative 'player'
require_relative 'hud'
require 'byebug'

class Game
  attr_reader :board, :white, :black, :hud
  attr_accessor :cursor, :quit, :current_player

  def initialize
    @cursor = [4,4]
    @board = Board.new
    @hud = Hud.new
    board.populate
    @quit = false
    @white = Player.new(:white)
    @black = Player.new(:black)
    @current_player = @white
  end

  def get_movement(character)
    controls = {"w" => [-1,0], "a" => [0, -1], "s" => [1,0], "d" => [0,1] }

    if controls.include?(character)
      controls[character]
    else
      return [0,0]
    end
  end

  def display_board(cursor)
    board.render(cursor)

    hud.render(current_player.color)
  end

  def make_turn(color)
    character = STDIN.getch

    self.cursor = Vector.new(self.cursor) + get_movement(character)

    piece = board[ *self.cursor ]

    if character == " "
      if piece.piece? && piece.color == color
        board.currently_selected_piece = piece
      elsif board.currently_selected_piece.piece?
        if board.currently_selected_piece.move(self.cursor)
          swap_players
          board.currently_selected_piece = board.sentinel
        end
      end
    elsif character == "q"
      self.quit = true
    end
  end

  def swap_players
    self.current_player = self.current_player == white ? black : white
  end

  def cursor=(coord)
    @cursor = coord if board.on_board?(coord)
  end

  def game_over?
    return true if self.quit

    pieces = board.find_pieces_for_color(current_player.color)

    moves = []

    pieces.each do |piece|
      moves << board.valid_moves_for_piece(piece)

      return false unless moves.empty?
    end

    unless moves.empty?
      debugger
    end

    if moves.empty?
      return true

      if board.in_check?(current_player.color)
        # other player won
      else
        # stalemate
      end
    end
  end

  def play
    until game_over?
      system("clear")
      display_board(self.cursor)
      make_turn(self.current_player.color)
    end
    self.quit = false
  end
end
