require_relative 'game'

if $PROGRAM_NAME == __FILE__
  chess = Game.new()
  chess.play
end
