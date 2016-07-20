class Hud
  def render(turn_color)
    rows, columns = STDIN.winsize

    output = "WASD to move cursor\nSpacebar to select\nQ to exit game"

    output += "\nIt is #{turn_color.to_s.capitalize}'s turn"

    puts

    output.split("\n").each do |line|
      print " " * ((columns - line.length) / 2)
      print line
      puts
    end
  end
end
